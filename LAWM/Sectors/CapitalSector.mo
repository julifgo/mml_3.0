within LAWM.Sectors;
package CapitalSector
  block TotalCapital
     // Because this block depends on the numbering of sectors, we "hardcode" the number of sectors
     //  instead of having it as a parameter.
     parameter Real capitalDeteriorationRatioPerSector[5];
     parameter Real tradeBalanceFoodSector;         // trade Balance for 3 sectors are left in individual variables to avoid confusion of indices (1 to 3 vs 1 to 5)
     parameter Real tradeBalanceOtherGoodsSector;
     parameter Real tradeBalanceCapitalSector;
     parameter Real tradeableSectors_operand[5] = {tradeBalanceFoodSector,0,0,tradeBalanceOtherGoodsSector,tradeBalanceCapitalSector}; //the only sectors with trade are the food (sector 1), other goods (sector 4) and capital sectors (sector 5). It's an operand for a matrix multiplication because Modelica is not imperative and I don't know how to do a sum of not all of the elements of an array (have first to initialize in 0)
     //In:
     discrete LAWM.Utilities.Interfaces.RealInput capDistributionPerSector_prev_year[5] annotation ( Placement(visible = true, transformation(origin = {-30, 34},  extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 34},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     discrete LAWM.Utilities.Interfaces.RealInput gnpProportionsPerSector_prev_year[5]  annotation ( Placement(visible = true, transformation(origin = {-30, 20},  extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 20},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     discrete LAWM.Utilities.Interfaces.RealInput tradeEliminationModifier              annotation ( Placement(visible = true, transformation(origin = {-30, 6},   extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 6},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     discrete LAWM.Utilities.Interfaces.RealInput gnpPerCapita_prev_year                annotation ( Placement(visible = true, transformation(origin = {-30, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     discrete LAWM.Utilities.Interfaces.RealInput totalCapital_prev_year                annotation ( Placement(visible = true, transformation(origin = {-30, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     discrete LAWM.Utilities.Interfaces.RealInput gnpCapitalSector_prev_year            annotation ( Placement(visible = true, transformation(origin = {-30, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
     //Out
     discrete LAWM.Utilities.Interfaces.RealOutput totalCapital                         annotation ( Placement(visible = true, transformation(origin = {22, 4},   extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {22, 4},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));

     //Aux:
       // Capital Deterioration vars
     discrete Real capitalDeteriorationPerSector[5]; // 5 positions corresponding to the 5 sectors. The 5 is hardcoded for now. Needs abstraction in the future
     discrete Real capitalDeteriorationFromSectors;
       // Capital from trade vars
     discrete Real tradeFromTradeableSectors;
     discrete Real capitalFromTrade;
   equation
     // Capital Deteriorarion Formulas
     for i in 1:5 loop
       capitalDeteriorationPerSector[i] = capitalDeteriorationRatioPerSector[i] * capDistributionPerSector_prev_year[i];
     end for;
     capitalDeteriorationFromSectors = sum(capitalDeteriorationPerSector);
     // Capital from trade formulas
     tradeFromTradeableSectors = gnpProportionsPerSector_prev_year * tradeableSectors_operand; // matrices multiplication. "Tradeable sectors operands" is a vector with 0's and 1's to add only some elements of the array when multiplying the matrices.
     capitalFromTrade           = tradeEliminationModifier * tradeFromTradeableSectors *gnpPerCapita_prev_year;
     // Final Formula
     totalCapital = totalCapital_prev_year + gnpCapitalSector_prev_year + capitalFromTrade -capitalDeteriorationFromSectors;
     annotation(Diagram(graphics = {Rectangle(origin = {-1, 2}, extent = {{-57, 46}, {45, -48}})}));
  end TotalCapital;

  block CapitalProportionPerSectorProjection
    // Prameters
    parameter Integer numberOfSectors;
    parameter Real capProportionPerSectorProjection_init[numberOfSectors];
    // No inputs
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput capProportionPerSector[numberOfSectors] annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    capProportionPerSector = capProportionPerSectorProjection_init;
  end CapitalProportionPerSectorProjection;

  block CapitalDistributionPerSector
    // Prameters
    parameter Integer numberOfSectors;
    //Inputs
    discrete LAWM.Utilities.Interfaces.RealInput totalCapital                                annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput capProportionPerSector[numberOfSectors] annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealInput capDistributionPerSector[numberOfSectors] annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    capDistributionPerSector = {totalCapital * capProportionPerSector[i] for i in 1:numberOfSectors};
  end CapitalDistributionPerSector;

  block CapitalSector
    // Parameters
    parameter Real capitalDeteriorationRatioPerSector[number_of_sectors];
    parameter Real tradeBalanceFoodSector;
    parameter Real tradeBalanceOtherGoodsSector;
    parameter Real tradeBalanceCapitalSector;
    parameter Integer number_of_sectors;
    parameter Real capProportionPerSectorProjection_init[number_of_sectors];
    // Components
    LAWM.Sectors.CapitalSector.TotalCapital total_cap(each capitalDeteriorationRatioPerSector = capitalDeteriorationRatioPerSector, tradeBalanceFoodSector = tradeBalanceFoodSector, tradeBalanceOtherGoodsSector = tradeBalanceOtherGoodsSector, tradeBalanceCapitalSector = tradeBalanceCapitalSector);
    LAWM.Sectors.CapitalSector.CapitalProportionPerSectorProjection cap_propor_proj(numberOfSectors = number_of_sectors, capProportionPerSectorProjection_init=capProportionPerSectorProjection_init);
    LAWM.Sectors.CapitalSector.CapitalDistributionPerSector cap_dist(numberOfSectors = number_of_sectors);
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput capDistributionPerSector_prev_year[number_of_sectors] annotation ( Placement(visible = true , transformation(origin = {-110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput gnpProportionsPerSector_prev_year[number_of_sectors]  annotation ( Placement(visible = true , transformation(origin = {-110 , -54 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -54 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput gnpPerCapita_prev_year                                annotation ( Placement(visible = true , transformation(origin = {-110 , -18 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -18 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalCapital_prev_year                                annotation ( Placement(visible = true , transformation(origin = {-110 ,  18 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  18 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput gnpCapitalSector_prev_year                            annotation ( Placement(visible = true , transformation(origin = {-110 ,  54 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  54 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.IntegerInput tradeEliminationModifier                           annotation ( Placement(visible = true , transformation(origin = {-110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput capProportionPerSector[number_of_sectors]    annotation ( Placement(visible = true , transformation(origin = {110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput capDistributionPerSector[number_of_sectors]  annotation ( Placement(visible = true , transformation(origin = {110 ,   0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 ,   0 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput totalCapital                                 annotation ( Placement(visible = true , transformation(origin = {110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  equation
// Capital Proportion Per Sector
  // Outputs (no inputs in this module)
  capProportionPerSector = cap_propor_proj.capProportionPerSector;
// Capital Distribution Per Sector
  // Inputs:
  cap_dist.totalCapital= total_cap.totalCapital;
  cap_dist.capProportionPerSector = cap_propor_proj.capProportionPerSector;
  // Outputs
  capDistributionPerSector = cap_dist.capDistributionPerSector;
// Total Capital
  // Inputs
  total_cap.capDistributionPerSector_prev_year = capDistributionPerSector_prev_year;
  total_cap.gnpProportionsPerSector_prev_year  = gnpProportionsPerSector_prev_year;
  total_cap.gnpPerCapita_prev_year             = gnpPerCapita_prev_year;
  total_cap.totalCapital_prev_year             = totalCapital_prev_year;
  total_cap.gnpCapitalSector_prev_year         = gnpCapitalSector_prev_year;
  total_cap.tradeEliminationModifier           = tradeEliminationModifier;
  // Outputs
  totalCapital = total_cap.totalCapital;
  end CapitalSector;

end CapitalSector;
