within LAWM.Sectors;
package HousingSector
block HousingAllocation
  // Inputs
  LAWM.Utilities.Interfaces.RealInput peoplePerFamily annotation( Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput population annotation( Placement(visible = true, transformation(origin = {-60, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput houses annotation( Placement(visible = true, transformation(origin = {-60, -82}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -82}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  // Outputs
  LAWM.Utilities.Interfaces.RealOutput housesPerCapitaPercentage annotation( Placement(visible = true, transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput housesPerFamily annotation( Placement(visible = true, transformation(origin = {60, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  housesPerCapitaPercentage = 100.* houses / population;
  housesPerFamily           = houses  * peoplePerFamily / population;
end HousingAllocation;

block UrbanizationRate
  // Parameters:
  parameter Real maxPopDensityPerHa = 150000;
  // Inputs
  LAWM.Utilities.Interfaces.RealInput population_this_year annotation( Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year annotation( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  // Outputs
  LAWM.Utilities.Interfaces.RealOutput urbanizationRate annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  urbanizationRate = max(0.,(population_this_year-totalPopulation_prev_year)/maxPopDensityPerHa);
end UrbanizationRate;

block HousingSectorPhysicalOutput
   //Inputs
  LAWM.Utilities.Interfaces.RealInput gnpHousingSector annotation( Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput costPerHouseBuilt annotation( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
   //Outputs
  LAWM.Utilities.Interfaces.RealOutput houses annotation( Placement(visible = true, transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
   houses = gnpHousingSector/costPerHouseBuilt;
end HousingSectorPhysicalOutput;

block HousingSector
  // Parameters
  parameter Real maxPopDensityPerHa;
  // Components
  LAWM.Sectors.HousingSector.HousingSectorPhysicalOutput housing_phyout();
  LAWM.Sectors.HousingSector.HousingAllocation housing_allocation();
  LAWM.Sectors.HousingSector.UrbanizationRate urb_rate(maxPopDensityPerHa);
  // Inputs
  discrete LAWM.Utilities.Interfaces.RealInput gnpHousingSector          annotation ( Placement(visible = true, transformation(origin = {-110, -90 }, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput peoplePerFamily           annotation ( Placement(visible = true, transformation(origin = {-110, -45 }, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -45}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput totalPopulation           annotation ( Placement(visible = true, transformation(origin = {-110,   0 }, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110,   0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year annotation ( Placement(visible = true, transformation(origin = {-110,  45 }, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110,  45}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput costPerHouseBuilt         annotation ( Placement(visible = true, transformation(origin = {-110,  90 }, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110,  90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Outputs
  discrete LAWM.Utilities.Interfaces.RealOutput housesPerCapitaPercentage annotation ( Placement(visible = true, transformation(origin = {110, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
// Phyisical Output: Housing
  // Inputs
  housing_phyout.gnpHousingSector    = gnpHousingSector;
  housing_phyout.costPerHouseBuilt   = costPerHouseBuilt;
// Housing allocation
  // Inputs
  housing_allocation.peoplePerFamily = peoplePerFamily;
  housing_allocation.population      = totalPopulation;
  housing_allocation.houses          = housing_phyout.houses;
  // Outputs
  housesPerCapitaPercentage = housing_allocation.housesPerCapitaPercentage;
// Urbanization Rate
  // Inputs
  urb_rate.population_this_year       = totalPopulation;
  urb_rate.totalPopulation_prev_year  = totalPopulation_prev_year;
end HousingSector;

end HousingSector;
