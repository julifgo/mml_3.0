within LAWM.Economy;
block Economy
// Parameters
  parameter Integer number_of_sectors;
  parameter Real tech_progr_year_start;
  parameter Real avgSalaryPerSector[number_of_sectors];
  parameter Real gammaPerSector[number_of_sectors];
  parameter Real laborForceVariationInProjectivePhase;
  parameter Real foodSectorLaborForceVariationInProjectivePhase;
  parameter Real FRS4SE;
  parameter Real alfa1_perSector[number_of_sectors];
  parameter Real alfa2_perSector[number_of_sectors];
  parameter Integer regressionPhaseYears;

// Components
  LAWM.Economy.GNP.GNPSectorial gnp_sectorial(each
    tech_progr_year_start = tech_progr_year_start,
    avgSalary             = avgSalaryPerSector,
    gamma                 = gammaPerSector,
    numberOfSectors       = number_of_sectors
  );

  LAWM.Economy.LaborForce.LaborForceProjection labor_force_proj(
    laborForceVariationInProjectivePhase           = laborForceVariationInProjectivePhase,
    foodSectorLaborForceVariationInProjectivePhase = foodSectorLaborForceVariationInProjectivePhase
  );

  LAWM.Economy.LaborForce.SecondaryLaborForcePercentage sec_lf_perc(
    FRS4SE=FRS4SE
  );

  LAWM.Economy.AlfaPerSector alfa_per_sec(
    number_of_sectors = number_of_sectors,
    regressionPhaseYears = regressionPhaseYears,
    alfa1_perSector = alfa1_perSector,
    alfa2_perSector = alfa2_perSector
  );

  LAWM.Economy.GNP.GNPPerCapita gnp_per_cap;
  // Inputs
  discrete LAWM.Utilities.Interfaces.RealInput capProportionPerSector[number_of_sectors]                  annotation ( Placement(visible = true , transformation(origin = {-110 , -90.00  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -90.00  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput totalCapital                                               annotation ( Placement(visible = true , transformation(origin = {-110 , -64.29  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -64.29  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year                                  annotation ( Placement(visible = true , transformation(origin = {-110 , -38.57  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -38.57  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput totalPopulation                                            annotation ( Placement(visible = true , transformation(origin = {-110 , -12.86  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -12.86  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput laborForceProportionsPerSector_prev_year[number_of_sectors] annotation ( Placement(visible = true , transformation(origin = {-110 , 12.86   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , 12.86   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealInput laborForceProportion_prev_year                              annotation ( Placement(visible = true , transformation(origin = {-110 , 38.57   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , 38.57   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.IntegerInput gammaExponent                                           annotation ( Placement(visible = true , transformation(origin = {-110 , 64.29   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , 64.29   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  discrete LAWM.Utilities.Interfaces.IntegerInput yearCounter                                             annotation ( Placement(visible = true , transformation(origin = {-109 , 90      } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , 90      } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  // Outputs
  discrete LAWM.Utilities.Interfaces.RealOutput gnpPerSector[number_of_sectors]                   annotation ( Placement(visible = true, transformation(origin = {110, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput gnpProportionsPerSector[number_of_sectors]        annotation ( Placement(visible = true, transformation(origin = {110, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput gnpPerCapita                                      annotation ( Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput laborForceProportionsPerSector[number_of_sectors] annotation ( Placement(visible = true, transformation(origin = {110, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput laborForcePercentagePerSector[number_of_sectors]  annotation ( Placement(visible = true, transformation(origin = {110, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput laborForceProportion                              annotation ( Placement(visible = true, transformation(origin = {110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.RealOutput secondaryLaborForcePercentage                     annotation ( Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  // Alfa
  // Inputs
  alfa_per_sec.yearCounter = yearCounter;
  // Outputs
  // (none, used only in GNP)

// GNP
  // Inputs <- Outputs
  gnp_sectorial.laborForceDistribution     = labor_force_proj.laborForceProportionsPerSector;
  gnp_sectorial.alfa                       = alfa_per_sec.alfaPerSector;
  gnp_sectorial.capProportionPerSector     = capProportionPerSector;
  gnp_sectorial.totalCapital               = totalCapital;
  gnp_sectorial.totalPopulation_prev_year  = totalPopulation_prev_year;
  gnp_sectorial.gammaExponent              = gammaExponent;
  gnp_sectorial.laborForceProportion       = labor_force_proj.laborForceProportion;
  // Global variables <- Outputs
  gnpPerSector            = gnp_sectorial.gnpPerSector;
  gnpProportionsPerSector = gnp_sectorial.gnpProportionsPerSector;

// GNP Per capita
  // Inputs:
  gnp_per_cap.totalGNP        = gnp_sectorial.totalGNP;
  gnp_per_cap.totalPopulation = totalPopulation;
  // Outputs
  gnpPerCapita = gnp_per_cap.gnpPerCapita;

// Labor Force Projection
  // Inputs
  labor_force_proj.laborForceProportionsPerSector_prev_year = laborForceProportionsPerSector_prev_year;
  labor_force_proj.laborForceProportion_prev_year           = laborForceProportion_prev_year;
  // Outputs
  laborForceProportionsPerSector = labor_force_proj.laborForceProportionsPerSector;
  laborForcePercentagePerSector  = labor_force_proj.laborForcePercentagePerSector;
  laborForceProportion           = labor_force_proj.laborForceProportion;

// Secondary Labor Force
  // Inputs
  sec_lf_perc.laborForceProportionsOtherGoodsSector = labor_force_proj.laborForceProportionsPerSector[4];
  sec_lf_perc.laborForceProportionsCapitalSector    = labor_force_proj.laborForceProportionsPerSector[5];
  // Outputs
  secondaryLaborForcePercentage = sec_lf_perc.secondaryLaborForcePercentage;
end Economy;
