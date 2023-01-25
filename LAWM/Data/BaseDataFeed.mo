within LAWM.Data;
partial block BaseDataFeed
  //Globals:
  parameter Integer number_of_sectors = 5;
  //  Inputs
  discrete input Integer year;
  //  Outputs
  discrete output Real population;
  discrete output Real totalCapital;
  discrete output Real alfaPerSector[number_of_sectors];
  discrete output Real laborForceProportionsPerSector[number_of_sectors];
  discrete output Real capProportionPerSector[number_of_sectors];
  discrete output Real capDistributionPerSector[number_of_sectors];
  discrete output Real gnpProportionsPerSector[number_of_sectors];
  discrete output Real tradeEliminationModifier;
  discrete output Real gnpPerCapita;
  discrete output Real laborForceProportion;
  discrete output Real populationByAgeBySex[70,2];
  discrete output Real survivalRateByAgeBySex[71,2];
  discrete output Real fertilityOfWomenBetween16and50[35];
  discrete output Real crudeBirthRate;
  discrete output Real lifeExpectancy;
  discrete output Real agePyram[3];
  discrete output Real crudeDeathRate;
  discrete output Real childMortality;
  discrete output Real urbanPopulationPercentage;
  discrete output Real urbanPopulation;
  discrete output Real housesPerCapitaPercentage;
  discrete output Real enrolmentPercentage;
  discrete output Real physicalOutput[3];
  discrete output Real peoplePerFamily;
  discrete output Real costFirstThreeSectors[3];
  discrete output Real gnpPerSector[number_of_sectors];
  discrete output Real caloriesPerDayPerPerson;
  discrete output Real secondaryLaborForcePercentage;

  //Aux:
  discrete Integer list_pos_for_year;
equation
  list_pos_for_year             = integer(year-1960+1);
  population                    = population_1960_to_2000[list_pos_for_year];
  tradeEliminationModifier      = tradeEliminationModifier_1960_to_2000[list_pos_for_year];
  gnpPerCapita                  = gnpPerCapita_1960_to_2000[list_pos_for_year];
  totalCapital                  = totalCapital_1960_to_2000[list_pos_for_year];
  laborForceProportion          = laborForceProportion_1960_to_2000[list_pos_for_year];
  crudeBirthRate                = crudeBirthRate_1960_to_2000[list_pos_for_year];
  lifeExpectancy                = lifeExpectancy_1960_to_2000[list_pos_for_year];
  enrolmentPercentage           = enrolmentPercentage_1960_to_2000[list_pos_for_year];
  agePyram[1]                   = popBetween1And6_1960_to_2000[list_pos_for_year];
  agePyram[2]                   = popBetween7And18_1960_to_2000[list_pos_for_year];
  agePyram[3]                   = popBetween11And70_1960_to_2000[list_pos_for_year];
  crudeDeathRate                = crudeDeathRate_1960_to_2000[list_pos_for_year];
  childMortality                = childMortality_1960_to_2000[list_pos_for_year];
  urbanPopulationPercentage     = urbanPopulationPercentage_1960_to_2000[list_pos_for_year];
  urbanPopulation               = urbanPopulationPercentage * population;
  housesPerCapitaPercentage     = housesPerCapitaPercentage_1960_to_2000[list_pos_for_year];
  peoplePerFamily               = peoplePerFamily_1960_to_2000[list_pos_for_year];
  caloriesPerDayPerPerson       = caloriesPerDayPerPerson_1960_to_2000[list_pos_for_year];
  secondaryLaborForcePercentage = secondaryLaborForcePercentage_1960_to_2000[list_pos_for_year];
  capDistributionPerSector              = {
      foodSectorCapital_1960_to_2000[list_pos_for_year],
      housingSectorCapital_1960_to_2000[list_pos_for_year],
      educationSectorCapital_1960_to_2000[list_pos_for_year],
      otherGoodsSectorCapital_1960_to_2000[list_pos_for_year],
      capitalSectorCapital_1960_to_2000[list_pos_for_year]};
  gnpProportionsPerSector        = {
      gnpProportionFoodSector_1960_to_2000[list_pos_for_year],
      gnpProportionHousingSector_1960_to_2000[list_pos_for_year],
      gnpProportionEducationSector_1960_to_2000[list_pos_for_year],
      gnpProportionOtherGoodsSector_1960_to_2000[list_pos_for_year],
      gnpProportionCapitalSector_1960_to_2000[list_pos_for_year]};
// Initialize sector arrays
  for sec_index in 1:3 loop
    costFirstThreeSectors[sec_index] = costFirstThreeSectors_1960_to_2000[sec_index,list_pos_for_year];
  end for;
  for sec_index in 1:number_of_sectors loop
    laborForceProportionsPerSector[sec_index]  = laborForceDistributionPerSector_1960_to_2000[sec_index,list_pos_for_year];
    capProportionPerSector[sec_index]    = capProportionPerSector_1960_to_2000[sec_index,list_pos_for_year];
    alfaPerSector[sec_index]                   = alfaPerSector_1960_to_2000[sec_index,list_pos_for_year];
    gnpPerSector[sec_index]                    = gnpPerSector_1960_to_2000[sec_index,list_pos_for_year];
  end for;
// Initialzie age arrays
  for age in 1:70 loop
  // Age structure per sex
    populationByAgeBySex[age,1] = popByAge_males_1960_to_2000[age,list_pos_for_year];
    populationByAgeBySex[age,2] = popByAge_females_1960_to_2000[age,list_pos_for_year];
  end for;
  for age in 1:71 loop
  // Age structure per sex
    survivalRateByAgeBySex[age,1] = survByAge_males_1960_to_2000[age,list_pos_for_year];
    survivalRateByAgeBySex[age,2] = survByAge_females_1960_to_2000[age,list_pos_for_year];
  end for;
  for age in 16:50 loop
  // Women fertility
    fertilityOfWomenBetween16and50[age-15] = fertilityOfWomenBetween16and50_1960_to_2000[age - 15,list_pos_for_year];
  end for;
  // Physical output
  for sec_index in 1:3 loop
    physicalOutput[sec_index] = physicalOutput_1960_to_2000[sec_index,list_pos_for_year];
  end for;
end BaseDataFeed;

