within LAWM.Regions;
package Base
  partial block Region
    parameter Integer number_of_sectors = 5;
    
    LAWM.Other.Sources.DiscreteTimeSource     discrete_time_src(startTime=1960) annotation( Placement(visible = true, transformation(origin = {-78, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LAWM.Other.IntegersAdd                    substract_1970(k1 = 1, k2 = -1) annotation( Placement(visible = true, transformation(origin = {24, 38}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant constant_1970(k = 1970) annotation( Placement(visible = true, transformation(origin = {-78, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
    discrete Integer yearCounter;
  
    RegionVariables             vars(number_of_sectors=number_of_sectors);
    RegionPreviousYearVariables prev_yr_vars(number_of_sectors=number_of_sectors);
    
    LAWM.Phase.Projection proj(
      number_of_sectors                              = number_of_sectors,
      initialUrbanPopPercentage                      = inits.urbanPopulationPercentage_init,
      cultivatedArableLand1960                       = params.cultivatedArableLand1960,
      avgSalaryPerSector                             = params.avgSalaryPerSector,
      gammaPerSector                                 = params.gammaPerSector,
      regressionPhaseYears                           = params.regressionPhaseYears,
      alfa1_perSector                                = params.alfa1_perSector,
      alfa2_perSector                                = params.alfa2_perSector,
      FRS4SE                                         = params.FRS4SE,
      laborForceVariationInProjectivePhase           = params.laborForceVariationInProjectivePhase,
      foodSectorLaborForceVariationInProjectivePhase = params.foodSectorLaborForceVariationInProjectivePhase,
      capitalDeteriorationRatioPerSector             = params.capitalDeteriorationRatioPerSector,
      tradeBalanceFoodSector                         = params.tradeBalanceFoodSector,
      tradeBalanceOtherGoodsSector                   = params.tradeBalanceOtherGoodsSector,
      tradeBalanceCapitalSector                      = params.tradeBalanceCapitalSector,
      capProportionPerSectorProjection_init          = params.capProportionPerSectorProjection_init,
      maxEnrolmentPercentage                         = params.maxEnrolmentPercentage,
      maxMatriculationPercentage                     = params.maxMatriculationPercentage,
      maxCaloriesPerDayPerPerson                     = params.maxCaloriesPerDayPerPerson,
      proteinsPerCalorie                             = params.proteinsPerCalorie,
      tech_progr_year_start                          = params.tech_progr_year_start,
      maxPopDensityPerHa                             = params.maxPopDensityPerHa,
      maxHousesPerCapitaPercentage                   = params.maxHousesPerCapitaPercentage,
      maleNewbornProbability                         = params.maleNewbornProbability
    ) annotation( Placement(visible = true, transformation(origin = {-12, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  initial equation
    // Implicit "initialization phase": Estimated or measured values for 1960:
    vars.totalCapital                     = inits.totalCapital_init;
    vars.capDistributionPerSector         = inits.capDistributionPerSector_init;
    vars.laborForceProportion             = inits.laborForceProportion_init;
    vars.laborForceProportionsPerSector   = inits.laborForceProportionsPerSector_init;
    vars.gnpPerSector                     = inits.gnpPerSector_init;
    vars.totalPopulation                  = inits.totalPopulation_init;
    vars.populationByAgeBySex[:,1]        = inits.populationByAge_males_init;
    vars.populationByAgeBySex[:,2]        = inits.populationByAge_females_init;
    vars.crudeBirthRate                   = inits.crudeBirthRate_init;
    vars.secondaryLaborForcePercentage    = inits.secondaryLaborForcePercentage_init;
    vars.gnpProportionsPerSector          = inits.gnpProportionsPerSector_init;
    vars.gnpPerCapita                     = inits.gnpPerCapita_init;
    vars.lifeExpectancy                   = inits.lifeExpectancy_init;
    vars.housesPerCapitaPercentage        = inits.housesPerCapitaPercentage_init;
    vars.urbanPopulationPercentage        = inits.urbanPopulationPercentage_init;
  
    // We initialize the "previous years vars" to avoid warning messages. The values used are arbitrary.
    prev_yr_vars.laborForceProportion_prev_year           = 1;
    prev_yr_vars.totalPopulation_prev_year                = 1;
    prev_yr_vars.laborForceProportionsPerSector_prev_year = {1 for i in 1:number_of_sectors};
    prev_yr_vars.capDistributionPerSector_prev_year       = { 1 for i in 1:number_of_sectors};
    prev_yr_vars.gnpProportionsPerSector_prev_year        = {1 for i in 1:number_of_sectors};
    prev_yr_vars.gnpPerCapita_prev_year                   = 1;
    prev_yr_vars.totalCapital_prev_year                   = 1;
    prev_yr_vars.gnpPerSector_prev_year                   = {1 for i in 1:number_of_sectors};
    prev_yr_vars.populationByAgeBySex_prev_year           = {{1 for i in 1:2} for j in 1:70};
    prev_yr_vars.lifeExpectancy_prev_year                 = 1;
    prev_yr_vars.secondaryLaborForcePercentage_aux        = 1;
    prev_yr_vars.crudeBirthRate_prev_year                 = 1;
    prev_yr_vars.urbanPopulationPercentage_prev_year      = 1;
    prev_yr_vars.housesPerCapitaPercentage_prev_year      = 1;
  equation
  
    connect(constant_1970.y               , substract_1970.u2) annotation( Line(points = {{-67, 34}, {-31, 34}, {-31, 38}, {11, 38}}, color = {255, 127, 0}));
    connect(discrete_time_src.discreteTime, substract_1970.u1) annotation( Line(points = {{-72, 62}, {-27.5, 62}, {-27.5, 48}, {11, 48}}, color = {255, 127, 0}));
  
    vars.costFirstThreeSectors = inits.costFirstThreeSectors_init; // doesn't change in projection phase
  
    yearCounter = discrete_time_src.discreteTime - 1959;
  
    // Years loop
    when sample(1961, 1) then
      // Assign values to projection phase inputs
      proj.gammaExponent                            = substract_1970.y;
      proj.yearCounter                              = yearCounter;
      proj.costFirstThreeSectors                    = vars.costFirstThreeSectors;
      proj.totalPopulation_prev_year                = prev_yr_vars.totalPopulation_prev_year;
      proj.capDistributionPerSector_prev_year       = prev_yr_vars.capDistributionPerSector_prev_year;
      proj.gnpProportionsPerSector_prev_year        = prev_yr_vars.gnpProportionsPerSector_prev_year;
      proj.gnpPerCapita_prev_year                   = prev_yr_vars.gnpPerCapita_prev_year;
      proj.totalCapital_prev_year                   = prev_yr_vars.totalCapital_prev_year;
      proj.gnpPerSector_prev_year                   = prev_yr_vars.gnpPerSector_prev_year;
      proj.urbanPopulationPercentage_prev_year      = prev_yr_vars.urbanPopulationPercentage_prev_year;
      proj.housesPerCapitaPercentage_prev_year      = prev_yr_vars.housesPerCapitaPercentage_prev_year;
      proj.crudeBirthRate_prev_year                 = prev_yr_vars.crudeBirthRate_prev_year;
      proj.laborForceProportionsPerSector_prev_year = prev_yr_vars.laborForceProportionsPerSector_prev_year;
      proj.laborForceProportion_prev_year           = prev_yr_vars.laborForceProportion_prev_year;
      proj.secondaryLaborForcePercentage_aux        = prev_yr_vars.secondaryLaborForcePercentage_aux;
      proj.lifeExpectancy_prev_year                 = prev_yr_vars.lifeExpectancy_prev_year;
      proj.populationByAgeBySex_prev_year           = prev_yr_vars.populationByAgeBySex_prev_year;
  
      // Get projection phase outputs
      vars.capDistributionPerSector       = proj.capDistributionPerSector;
      vars.laborForceProportion           = proj.laborForceProportion;
      vars.laborForceProportionsPerSector = proj.laborForceProportionsPerSector;
      vars.totalCapital                   = proj.totalCapital;
      vars.totalPopulation                = proj.totalPopulation;
      vars.gnpProportionsPerSector        = proj.gnpProportionsPerSector;
      vars.gnpPerCapita                   = proj.gnpPerCapita;
      vars.gnpPerSector                   = proj.gnpPerSector;
      vars.populationByAgeBySex           = proj.populationByAgeBySex;
      vars.urbanPopulationPercentage      = proj.urbanPopulationPercentage;
      vars.lifeExpectancy                 = proj.lifeExpectancy;
      vars.crudeBirthRate                 = proj.crudeBirthRate;
      vars.secondaryLaborForcePercentage  = proj.secondaryLaborForcePercentage;
      vars.housesPerCapitaPercentage      = proj.housesPerCapitaPercentage;
  
      // Assign variables with values corresponding to the previous year
      prev_yr_vars.laborForceProportionsPerSector_prev_year = pre(vars.laborForceProportionsPerSector);
      prev_yr_vars.laborForceProportion_prev_year           = pre(vars.laborForceProportion);
      prev_yr_vars.totalPopulation_prev_year                = pre(vars.totalPopulation);
      prev_yr_vars.populationByAgeBySex_prev_year           = pre(vars.populationByAgeBySex);
      prev_yr_vars.lifeExpectancy_prev_year                 = pre(vars.lifeExpectancy);
      prev_yr_vars.capDistributionPerSector_prev_year       = pre(vars.capDistributionPerSector);
      prev_yr_vars.gnpProportionsPerSector_prev_year        = pre(vars.gnpProportionsPerSector);
      prev_yr_vars.gnpPerCapita_prev_year                   = pre(vars.gnpPerCapita);
      prev_yr_vars.totalCapital_prev_year                   = pre(vars.totalCapital);
      prev_yr_vars.gnpPerSector_prev_year                   = pre(vars.gnpPerSector);
      prev_yr_vars.secondaryLaborForcePercentage_aux        = max(pre(prev_yr_vars.secondaryLaborForcePercentage_aux), vars.secondaryLaborForcePercentage);
      prev_yr_vars.crudeBirthRate_prev_year                 = pre(vars.crudeBirthRate);
      prev_yr_vars.urbanPopulationPercentage_prev_year      = pre(vars.urbanPopulationPercentage);
      prev_yr_vars.housesPerCapitaPercentage_prev_year      = pre(vars.housesPerCapitaPercentage);
    end when;
  end Region;

  record RegionVariables
    parameter Integer number_of_sectors;
    discrete Real capDistributionPerSector[number_of_sectors];
    discrete Real laborForceProportion;
    discrete Real laborForceProportionsPerSector[number_of_sectors];
    discrete Real totalCapital;
    discrete Real totalPopulation;
    discrete Real gnpProportionsPerSector[number_of_sectors];
    discrete Real gnpPerCapita;
    discrete Real gnpPerSector[number_of_sectors];
    discrete Real populationByAgeBySex[70,2];
    discrete Real urbanPopulationPercentage;
    discrete Real lifeExpectancy;
    discrete Real crudeBirthRate;
    discrete Real secondaryLaborForcePercentage;
    discrete Real housesPerCapitaPercentage;
    discrete Real costFirstThreeSectors[3];
  end RegionVariables;

  record RegionPreviousYearVariables
    parameter Integer number_of_sectors;
    discrete Real laborForceProportionsPerSector_prev_year[number_of_sectors];
    discrete Real laborForceProportion_prev_year;
    discrete Real totalPopulation_prev_year;
    discrete Real capDistributionPerSector_prev_year[number_of_sectors];
    discrete Real gnpProportionsPerSector_prev_year[number_of_sectors];
    discrete Real gnpPerCapita_prev_year;
    discrete Real totalCapital_prev_year;
    discrete Real gnpPerSector_prev_year[number_of_sectors];
    discrete Real populationByAgeBySex_prev_year[70,2];
    discrete Real lifeExpectancy_prev_year;
    discrete Real secondaryLaborForcePercentage_aux;  // this value corresponds to "maximum value of secondary labor force percentage in the past"
    discrete Real crudeBirthRate_prev_year;
    discrete Real urbanPopulationPercentage_prev_year;
    discrete Real housesPerCapitaPercentage_prev_year;
  end RegionPreviousYearVariables;

  record RegionInits
    parameter Integer number_of_sectors;
    parameter Real capProportionPerSectorProjection_init[number_of_sectors];
    parameter Real gnpPerCapita_init;
    parameter Real laborForceProportionsPerSector_init[number_of_sectors];
    parameter Real gnpProportionsPerSector_init[number_of_sectors];
    parameter Real totalGNP_init;
    parameter Real populationByAge_males_init[70];
    parameter Real populationByAge_females_init[70];
    parameter Real laborForceProportion_init;
    parameter Real housesPerCapitaPercentage_init;
    parameter Real gnpPerSector_init[number_of_sectors];
    parameter Real totalPopulation_init;
    parameter Real crudeBirthRate_init;
    parameter Real capDistributionPerSector_init[number_of_sectors];
    parameter Real totalCapital_init;
    parameter Real lifeExpectancy_init;
    parameter Real urbanPopulationPercentage_init;
    parameter Real crudeDeathRate_init;
    parameter Real childMortality_init;
    parameter Real caloriesPerDayPerPerson_init;
    parameter Real secondaryLaborForcePercentage_init;
    parameter Real enrolmentPercentage_init;
    parameter Real costFirstThreeSectors_init[3];
    parameter Real caloriesProduced_init;
    parameter Real proteinsPerDayPerPerson_init;
    parameter Real exceedingCaloriesPerDayPerPerson_init;
    parameter Real matriculationPercentage_init;
    parameter Real availableEducationSlots_init;
    parameter Real peoplePerFamily_init;
    parameter Real urbanPopulation_init;
    parameter Real agePyramid_init[3];
    parameter Real houses_init;
    parameter Real housesPerFamily_init;
  end RegionInits;

  record RegionParameters
    parameter Integer number_of_sectors;
    parameter Real cultivatedArableLand1960;
    parameter Real avgSalaryPerSector[number_of_sectors];
    parameter Real gammaPerSector[number_of_sectors];
    parameter Integer regressionPhaseYears;
    parameter Real alfa1_perSector[number_of_sectors];
    parameter Real alfa2_perSector[number_of_sectors];
    parameter Real FRS4SE;
    parameter Real laborForceVariationInProjectivePhase;
    parameter Real foodSectorLaborForceVariationInProjectivePhase;
    parameter Real capitalDeteriorationRatioPerSector[number_of_sectors];
    parameter Real tradeBalanceFoodSector;
    parameter Real tradeBalanceOtherGoodsSector;
    parameter Real tradeBalanceCapitalSector;
    parameter Real capProportionPerSectorProjection_init[number_of_sectors];
    parameter Real maxEnrolmentPercentage;
    parameter Real maxMatriculationPercentage;
    parameter Real maxCaloriesPerDayPerPerson;
    parameter Real proteinsPerCalorie;
    parameter Real tech_progr_year_start;
    parameter Real maleNewbornProbability;
    parameter Real maxHousesPerCapitaPercentage;
    parameter Real maxPopDensityPerHa;
  end RegionParameters;

end Base;
