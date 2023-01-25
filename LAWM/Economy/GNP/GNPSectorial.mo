within LAWM.Economy.GNP;
block GNPSectorial
    // Parameters
    parameter Integer numberOfSectors = 5; // we hardcode the number of sectors because we need them to be 5
    parameter Real avgSalary[numberOfSectors];
    parameter Real gamma[numberOfSectors];
    parameter Real tech_progr_year_start = 1970.9; // (it should start at year 1971 but in Modelica we have to put something smaller) This year is hardcoded in the Fortran code as "KOUNT > 11". It's the starting year to take into account the technological progress when calculating GNP

    // Input vars:
    //  Per sector:
    discrete LAWM.Utilities.Interfaces.RealInput    laborForceDistribution[numberOfSectors] annotation ( Placement(visible = true, transformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput    capProportionPerSector[numberOfSectors]    annotation ( Placement(visible = true, transformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput    alfa [numberOfSectors]                  annotation ( Placement(visible = true, transformation(origin = {-62, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    //  For all sectors:
    discrete LAWM.Utilities.Interfaces.RealInput    totalCapital              annotation ( Placement(visible = true, transformation(origin = {-62, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.IntegerInput gammaExponent             annotation ( Placement(visible = true, transformation(origin = {-62, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput    totalPopulation_prev_year annotation ( Placement(visible = true, transformation(origin = {-62, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput    laborForceProportion      annotation ( Placement(visible = true, transformation(origin = {-62, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

    // Output vars
    discrete LAWM.Utilities.Interfaces.RealOutput gnpPerSector[numberOfSectors]            annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput gnpProportionsPerSector[numberOfSectors] annotation ( Placement(visible = true, transformation(origin = {60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput totalGNP                                 annotation ( Placement(visible = true, transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    //Aux
    CobbDouglas cobbDouglas[numberOfSectors];
    discrete Real laborForce[numberOfSectors];
    discrete Real secCapital[numberOfSectors];
    discrete Real grossSecGNP[numberOfSectors];
    discrete Real secSalaries[numberOfSectors];
    discrete Real techProgressModifier[numberOfSectors];


 equation
 // In the original version, we use the labor force proportions from sectors 1 to 4 to calculate the salaries for their respective sectors. This makes sense.
 //   But, instead of doing the same for sector 5, we substract the results of 1 to 4 to the total of all 5 that was already calculated. It should end up being
 //   the same as using the labor force proprotions for that sector, but for some years and regions it isn't.
    // First, calculate the salaries:
    // Calculate laborForce for sectors 1 to 4
    for i_sector in 1:4 loop
      laborForce[i_sector] = laborForceDistribution[i_sector] * totalPopulation_prev_year; // (1)
    end for;
    // Using the labor force from 1 to 4, calculate the one for 5
    laborForce[5] = laborForceProportion*totalPopulation_prev_year - sum(laborForce[i] for i in 1:4);
    // Using the laborforces 1 to 5, calculate the salaries
    for i_sector in 1:numberOfSectors loop
      // Salaries
      secSalaries[i_sector] = laborForce[i_sector] * avgSalary[i_sector]; // (2)
    end for;
    // Then, calculate the capital. We don't have to distinguish between sectors
    for i_sector in 1:numberOfSectors loop
      // Capital
      secCapital[i_sector] = capProportionPerSector[i_sector] * totalCapital; //(3)
    end for;
    // Finally, calculate Cobb Douglas using the salaries, capitals and their respective alfas
    for i_sector in 1:numberOfSectors loop
      // Cobb Douglas:
      connect(secSalaries[i_sector]            , cobbDouglas[i_sector].salaries);
      connect(secCapital[i_sector]             , cobbDouglas[i_sector].capital);
      connect(alfa[i_sector]                   , cobbDouglas[i_sector].alfa);
      connect(cobbDouglas[i_sector].production , grossSecGNP[i_sector]);
      techProgressModifier[i_sector] = gamma[i_sector]^gammaExponent;
      // GNP per sector
      gnpPerSector[i_sector] = if time >= tech_progr_year_start then grossSecGNP[i_sector] * techProgressModifier[i_sector] else grossSecGNP[i_sector];
    end for;
    // Calculate total GNP
    totalGNP = sum(gnpPerSector[i_sector] for i_sector in 1:numberOfSectors);
    // Calculate GNP proportions per sector
    gnpProportionsPerSector = {gnpPerSector[i_sector]/totalGNP for i_sector in 1:numberOfSectors};
end GNPSectorial;
