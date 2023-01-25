within LAWM.Economy;
package LaborForce
block LaborForceProjection
    parameter Real laborForceVariationInProjectivePhase; // TLFPRO in Fortran
    parameter Real foodSectorLaborForceVariationInProjectivePhase; // AGPROJ in Fortran

    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput laborForceProportion_prev_year annotation(Placement(visible = true, transformation(origin = {-120, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput laborForceProportionsPerSector_prev_year[5] annotation(Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput laborForceProportion annotation(Placement(visible = true, transformation(origin = {110, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput laborForceProportionsPerSector[5] annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput laborForcePercentagePerSector[5] annotation(Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    // Aux:
    discrete Real laborForceProportionChangeRatio;
    discrete Real influxOfLaborForceFromFoodSectorMultiplier;

  equation
    laborForceProportion= laborForceProportion_prev_year + laborForceVariationInProjectivePhase;
    laborForceProportionChangeRatio= laborForceProportion / laborForceProportion_prev_year;
    influxOfLaborForceFromFoodSectorMultiplier =
      1 + foodSectorLaborForceVariationInProjectivePhase /
      (laborForceProportion_prev_year/ laborForceProportionChangeRatio - (laborForceProportionsPerSector_prev_year[1]) * laborForceProportionChangeRatio); // the "1" index corresponds to Food Sector
    //      Food Sector is not like the others. The "1" index corresponds to the food sector
    laborForceProportionsPerSector[1] = (laborForceProportionsPerSector_prev_year[1] * laborForceProportionChangeRatio) -
                                        foodSectorLaborForceVariationInProjectivePhase;
    //      For sectors other than Food Sector. We have 5 sectors. It's hardcoded for now.
    for sec_index in 2:5 loop
        laborForceProportionsPerSector[sec_index] = laborForceProportionsPerSector_prev_year[sec_index] *
                                                    laborForceProportionChangeRatio *
                                                    influxOfLaborForceFromFoodSectorMultiplier;
    end for;
    // Calculate the percentage per sector using the proportion
    laborForcePercentagePerSector = laborForceProportionsPerSector * 100;
end LaborForceProjection;
block SecondaryLaborForcePercentage
 // Parameters
  parameter Real FRS4SE;
 // Inputs
  discrete LAWM.Utilities.Interfaces.RealInput laborForceProportionsOtherGoodsSector annotation(Placement(visible = true, transformation(origin = {-62, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput laborForceProportionsCapitalSector annotation(Placement(visible = true, transformation(origin = {-62, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  discrete LAWM.Utilities.Interfaces.RealOutput secondaryLaborForcePercentage annotation(Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
   secondaryLaborForcePercentage = 100*(laborForceProportionsCapitalSector+FRS4SE*laborForceProportionsOtherGoodsSector);
end SecondaryLaborForcePercentage;

end LaborForce;
