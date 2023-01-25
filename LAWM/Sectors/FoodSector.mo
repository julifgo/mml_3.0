within LAWM.Sectors;
package FoodSector
  block FoodSectorProjection
     parameter Real maxCaloriesPerDayPerPerson;
     parameter Real proteinsPerCalorie;

     // In:
     LAWM.Utilities.Interfaces.RealInput population       annotation ( Placement(visible = true, transformation(origin = {-120, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealInput caloriesProduced annotation ( Placement(visible = true, transformation(origin = {-120, -18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -18}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

     // Out:
     LAWM.Utilities.Interfaces.RealOutput caloriesPerDayPerPerson          annotation ( Placement(visible = true, transformation(origin = {110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealOutput grossCaloriesPerDayPerPerson     annotation ( Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealOutput exceedingCaloriesPerDayPerPerson annotation ( Placement(visible = true, transformation(origin = {110, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealOutput proteinsPerDayPerPerson          annotation ( Placement(visible = true, transformation(origin = {110, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

     // Aux:
     Real grossExceedingCaloriesPerDayPerPerson;
   equation
     grossCaloriesPerDayPerPerson    = caloriesProduced / (population*365);
     grossExceedingCaloriesPerDayPerPerson = grossCaloriesPerDayPerPerson - maxCaloriesPerDayPerPerson;
     exceedingCaloriesPerDayPerPerson = max(0,grossExceedingCaloriesPerDayPerPerson);
     caloriesPerDayPerPerson         = min(grossCaloriesPerDayPerPerson, maxCaloriesPerDayPerPerson);
     proteinsPerDayPerPerson         = proteinsPerCalorie * caloriesPerDayPerPerson;
  end FoodSectorProjection;


  block FoodSectorPhysicalOutput
     //Inputs
     LAWM.Utilities.Interfaces.RealInput gnpFoodSector annotation( Placement(visible = true, transformation(origin = {-64, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-64, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealInput costPerCalorieProduced annotation( Placement(visible = true, transformation(origin = {-64, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-64, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     //Outputs
     LAWM.Utilities.Interfaces.RealOutput caloriesProduced annotation( Placement(visible = true, transformation(origin = {54, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {54, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   equation
     caloriesProduced                = gnpFoodSector/costPerCalorieProduced; // (1)
  end FoodSectorPhysicalOutput;

  block FoodSector
    // Parameters
    parameter Real maxCaloriesPerDayPerPerson;
    parameter Real proteinsPerCalorie;
    // Components
    LAWM.Sectors.FoodSector.FoodSectorProjection food_sec_proj(maxCaloriesPerDayPerPerson =maxCaloriesPerDayPerPerson, proteinsPerCalorie =proteinsPerCalorie);
    LAWM.Sectors.FoodSector.FoodSectorPhysicalOutput food_phyout();
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput costPerCalorieProduced  annotation ( Placement(visible = true , transformation(origin = {-110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,-90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput gnpFoodSector           annotation ( Placement(visible = true , transformation(origin = {-110 ,   0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation         annotation ( Placement(visible = true , transformation(origin = {-110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , 90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));

    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput caloriesPerDayPerPerson           annotation ( Placement(visible = true , transformation(origin = {110 , 0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , 0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    output Real exceedingCaloriesPerDayPerPerson;
    output Real proteinsPerDayPerPerson;
  equation
  // Food Sector: Physical Output
    // Inputs
    food_phyout.gnpFoodSector          = gnpFoodSector;
    food_phyout.costPerCalorieProduced = costPerCalorieProduced;
  // Food Sector: Food Sector Projection
    // Inputs
    food_sec_proj.population           = totalPopulation;
    food_sec_proj.caloriesProduced     = food_phyout.caloriesProduced;
    // Outputs
    caloriesPerDayPerPerson          = food_sec_proj.caloriesPerDayPerPerson;
    exceedingCaloriesPerDayPerPerson = food_sec_proj.exceedingCaloriesPerDayPerPerson;
    proteinsPerDayPerPerson          = food_sec_proj.proteinsPerDayPerPerson;
  end FoodSector;

end FoodSector;
