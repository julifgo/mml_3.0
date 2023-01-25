within LAWM.Economy;
block AlfaPerSector
  // Parameters:
  parameter Integer number_of_sectors;
  parameter Real alfa1_perSector[number_of_sectors];
  parameter Real alfa2_perSector[number_of_sectors];
  parameter Integer regressionPhaseYears;
  // Inputs
  LAWM.Utilities.Interfaces.IntegerInput yearCounter annotation( Placement(visible = true, transformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  // Outputs
  LAWM.Utilities.Interfaces.RealOutput alfaPerSector[number_of_sectors] annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Aux vars:
  Integer alfa_year;
equation
  alfa_year = min(yearCounter,regressionPhaseYears);
  for i_sector in 1:number_of_sectors loop
      alfaPerSector[i_sector] = 0.1*(alfa_year-1)*(alfa2_perSector[i_sector]-alfa1_perSector[i_sector])+alfa1_perSector[i_sector];
  end for;
end AlfaPerSector;
