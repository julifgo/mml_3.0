within LAWM.Phase;

model Projection
  // Params
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
  parameter Real initialUrbanPopPercentage;
  // Inits. We have to set these values as initial values or the equations get unsatisfiable. We use the
  //   values from developed but any value that doesn't raise an error is good enough
  parameter Real gnpPerCapita_init = 0.14017849E+04;
  parameter Real laborForceProportionsPerSector_init[number_of_sectors] = {0.12400000E+00, 0.99999997E-04, 0.60000001E-02, 0.24590001E+00, 0.70000000E-01};
  parameter Real gnpProportionsPerSector_init[number_of_sectors] = {0.1670e+00, 0.8800E-01, 0.3400E-01, 0.4950e+00, 0.2160e+00};
  parameter Real populationByAge_males_init[70] = {0.76406270E+07, 0.78861740E+07, 0.81084205E+07, 0.83055750E+07, 0.84785330E+07, 0.86263990E+07, 0.87500680E+07, 0.88486460E+07, 0.89194420E+07, 0.89669380E+07, 0.90153310E+07, 0.89956150E+07, 0.89436380E+07, 0.88665690E+07, 0.87635110E+07, 0.85959300E+07, 0.84740520E+07, 0.83414210E+07, 0.81980365E+07, 0.80403130E+07, 0.80734705E+07, 0.77893890E+07, 0.74622920E+07, 0.71127910E+07, 0.67632905E+07, 0.60015575E+07, 0.59038765E+07, 0.59182150E+07, 0.60150000E+07, 0.61682425E+07, 0.67444710E+07, 0.67543285E+07, 0.66969745E+07, 0.65867475E+07, 0.64424665E+07, 0.59836345E+07, 0.59522690E+07, 0.59692960E+07, 0.60185845E+07, 0.60831080E+07, 0.63689815E+07, 0.63223815E+07, 0.62211160E+07, 0.60696655E+07, 0.58769920E+07, 0.57237490E+07, 0.54450445E+07, 0.51394555E+07, 0.48258005E+07, 0.45184190E+07, 0.39045522E+07, 0.38032865E+07, 0.37934290E+07, 0.38516790E+07, 0.39574255E+07, 0.43176800E+07, 0.43553190E+07, 0.43526305E+07, 0.43149920E+07, 0.42415070E+07, 0.41438260E+07, 0.40210525E+07, 0.38776675E+07, 0.37181518E+07, 0.35478820E+07, 0.33686510E+07, 0.31867312E+07, 0.30057078E+07, 0.28291650E+07, 0.24432800E+08};
  parameter Real populationByAge_females_init[70] = {0.73198035E+07, 0.75528040E+07, 0.77651930E+07, 0.79551780E+07, 0.81227590E+07, 0.82688325E+07, 0.83880215E+07, 0.84865990E+07, 0.85600830E+07, 0.86093720E+07, 0.86685180E+07, 0.86505950E+07, 0.86030990E+07, 0.85287180E+07, 0.84301410E+07, 0.82607670E+07, 0.81523325E+07, 0.80358320E+07, 0.79112665E+07, 0.77750505E+07, 0.78306120E+07, 0.75716230E+07, 0.72714110E+07, 0.69514830E+07, 0.66288670E+07, 0.59011880E+07, 0.58285995E+07, 0.58635495E+07, 0.59791535E+07, 0.61503195E+07, 0.67677710E+07, 0.67785250E+07, 0.67175865E+07, 0.66010860E+07, 0.64550125E+07, 0.59522690E+07, 0.59486845E+07, 0.60114155E+07, 0.61207465E+07, 0.62578580E+07, 0.65759935E+07, 0.66441015E+07, 0.66682975E+07, 0.66512710E+07, 0.65912285E+07, 0.67202750E+07, 0.64783125E+07, 0.61718275E+07, 0.58277035E+07, 0.54710330E+07, 0.46322310E+07, 0.45488885E+07, 0.45847350E+07, 0.47119890E+07, 0.49028700E+07, 0.54629680E+07, 0.55436220E+07, 0.55624410E+07, 0.55283870E+07, 0.54486295E+07, 0.53348175E+07, 0.51914325E+07, 0.50274360E+07, 0.48544775E+07, 0.46761425E+07, 0.45058730E+07, 0.43463570E+07, 0.42101415E+07, 0.41043950E+07, 0.41238416E+08};
  parameter Real laborForceProportion_init = 0.44600001E+00;
  parameter Real housesPerCapitaPercentage_init = 0.17365164E+02;
  parameter Real gnpPerSector_init[number_of_sectors] = {0.22159491E+12, 0.11676858E+12, 0.45115134E+11, 0.65682322E+12, 0.28661380E+12};
  parameter Real totalPopulation_init = 0.94659002E+09;
  parameter Real crudeBirthRate_init = 0.22190907E+02;
  parameter Real capDistributionPerSector_init[number_of_sectors] = {0.19203121E+12, 0.89614569E+12, 0.96015606E+11, 0.14082289E+13, 0.60809884E+12};
  parameter Real totalCapital_init = 0.32005203E+13;
  parameter Real lifeExpectancy_init = 0.69437271E+02;
  parameter Real urbanPopulationPercentage_init = 0.59139999E+02;
  parameter Real secondaryLaborForcePercentage_init = 0.15596418E+02;
  parameter Real costFirstThreeSectors_init[3] = {0.21518909E-03, 0.71037091E+03, 0.25713278E+03};
  Modelica.Blocks.Sources.IntegerConstant constant_1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {26, -60}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  // Inputs:
  // this value corresponds to "maximum value of secondary labor force percentage in the past"
  // Outputs:
  discrete LAWM.Utilities.Interfaces.RealOutput populationByAgeBySex[70, 2] annotation(
    Placement(visible = true, transformation(origin = {110, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Economy.Economy economy(each number_of_sectors = number_of_sectors, tech_progr_year_start = tech_progr_year_start, avgSalaryPerSector = avgSalaryPerSector, gammaPerSector = gammaPerSector, laborForceVariationInProjectivePhase = laborForceVariationInProjectivePhase, foodSectorLaborForceVariationInProjectivePhase = foodSectorLaborForceVariationInProjectivePhase, FRS4SE = FRS4SE, regressionPhaseYears = regressionPhaseYears, alfa1_perSector = alfa1_perSector, alfa2_perSector = alfa2_perSector) annotation(
    Placement(visible = true, transformation(origin = {-48, 52}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  LAWM.Sectors.CapitalSector.CapitalSector capital_sec(each number_of_sectors = number_of_sectors, capitalDeteriorationRatioPerSector = capitalDeteriorationRatioPerSector, tradeBalanceFoodSector = tradeBalanceFoodSector, tradeBalanceOtherGoodsSector = tradeBalanceOtherGoodsSector, tradeBalanceCapitalSector = tradeBalanceCapitalSector, capProportionPerSectorProjection_init = capProportionPerSectorProjection_init) annotation(
    Placement(visible = true, transformation(origin = {53, -73}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  LAWM.Sectors.EducationSector.EducationSector education_sec(maxEnrolmentPercentage = maxEnrolmentPercentage, maxMatriculationPercentage = maxMatriculationPercentage) annotation(
    Placement(visible = true, transformation(origin = {53, -19}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  LAWM.Sectors.FoodSector.FoodSector food_sec(maxCaloriesPerDayPerPerson = maxCaloriesPerDayPerPerson, proteinsPerCalorie = proteinsPerCalorie) annotation(
    Placement(visible = true, transformation(origin = {53, 83}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  LAWM.Sectors.HousingSector.HousingSector housing_sec(maxPopDensityPerHa = maxPopDensityPerHa) annotation(
    Placement(visible = true, transformation(origin = {53, 21}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  LAWM.Demography.Demography.Demography demography(maleNewbornProbability = maleNewbornProbability, maxHousesPerCapitaPercentage = maxHousesPerCapitaPercentage, cultivatedArableLand1960 = cultivatedArableLand1960, initialUrbanPopPercentage = initialUrbanPopPercentage) annotation(
    Placement(visible = true, transformation(origin = {-48, -46}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput gnpPerSector_prev_year[5] annotation(
    Placement(visible = true, transformation(origin = {-110, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput totalCapital_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.IntegerInput gammaExponent annotation(
    Placement(visible = true, transformation(origin = {-110, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.IntegerInput yearCounter annotation(
    Placement(visible = true, transformation(origin = {-110, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput capDistributionPerSector_prev_year[5] annotation(
    Placement(visible = true, transformation(origin = {-110, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -116}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput gnpProportionsPerSector_prev_year[5] annotation(
    Placement(visible = true, transformation(origin = {-110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput gnpPerCapita_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput costFirstThreeSectors[3] annotation(
    Placement(visible = true, transformation(origin = {-110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput urbanPopulationPercentage_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput housesPerCapitaPercentage_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput crudeBirthRate_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput laborForceProportionsPerSector_prev_year[5] annotation(
    Placement(visible = true, transformation(origin = {-110, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput laborForceProportion_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput secondaryLaborForcePercentage_aux annotation(
    Placement(visible = true, transformation(origin = {-110, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput lifeExpectancy_prev_year annotation(
    Placement(visible = true, transformation(origin = {-110, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealInput populationByAgeBySex_prev_year[70,2] annotation(
    Placement(visible = true, transformation(origin = {-110, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput totalCapital annotation(
    Placement(visible = true, transformation(origin = {110, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput totalPopulation annotation(
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput capDistributionPerSector[5] annotation(
    Placement(visible = true, transformation(origin = {110, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput gnpProportionsPerSector[5] annotation(
    Placement(visible = true, transformation(origin = {110, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput gnpPerCapita annotation(
    Placement(visible = true, transformation(origin = {110, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput gnpPerSector[5] annotation(
    Placement(visible = true, transformation(origin = {110, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput urbanPopulationPercentage annotation(
    Placement(visible = true, transformation(origin = {110, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput housesPerCapitaPercentage annotation(
    Placement(visible = true, transformation(origin = {110, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput crudeBirthRate annotation(
    Placement(visible = true, transformation(origin = {110, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput laborForceProportionsPerSector[5] annotation(
    Placement(visible = true, transformation(origin = {110, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput laborForcePercentagePerSector[5] annotation(
    Placement(visible = true, transformation(origin = {110, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput laborForceProportion annotation(
    Placement(visible = true, transformation(origin = {110, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput secondaryLaborForcePercentage annotation(
    Placement(visible = true, transformation(origin = {110, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -148}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LAWM.Utilities.Interfaces.RealOutput lifeExpectancy annotation(
    Placement(visible = true, transformation(origin = {110, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
// We have to initialize the variables with the standard values for 1961. Otherwise, the initizialiation raises errors
  gammaExponent = -9;
  yearCounter = 1;
  laborForceProportion_prev_year = laborForceProportion_init;
  totalPopulation_prev_year = totalPopulation_init;
  laborForceProportionsPerSector_prev_year = laborForceProportionsPerSector_init;
  capDistributionPerSector_prev_year = capDistributionPerSector_init;
  gnpProportionsPerSector_prev_year = gnpProportionsPerSector_init;
  gnpPerCapita_prev_year = gnpPerCapita_init;
  totalCapital_prev_year = totalCapital_init;
  gnpPerSector_prev_year = gnpPerSector_init;
  populationByAgeBySex_prev_year[:, 1] = populationByAge_males_init;
  populationByAgeBySex_prev_year[:, 2] = populationByAge_females_init;
  lifeExpectancy_prev_year = lifeExpectancy_init;
  secondaryLaborForcePercentage_aux = secondaryLaborForcePercentage_init;
  crudeBirthRate_prev_year = crudeBirthRate_init;
  urbanPopulationPercentage_prev_year = urbanPopulationPercentage_init;
  housesPerCapitaPercentage_prev_year = housesPerCapitaPercentage_init;
  costFirstThreeSectors = costFirstThreeSectors_init;
equation
  connect(economy.laborForceProportion, laborForceProportion) annotation(
    Line(points = {{-32, 40}, {82, 40}, {82, 18}, {100, 18}, {100, 18}, {110, 18}}, color = {0, 0, 127}));
  connect(economy.secondaryLaborForcePercentage, secondaryLaborForcePercentage) annotation(
    Line(points = {{-32, 44}, {84, 44}, {84, 34}, {110, 34}, {110, 34}}, color = {0, 0, 127}));
  connect(costFirstThreeSectors[1], food_sec.costPerCalorieProduced) annotation(
    Line(points = {{-110, 12}, {-2, 12}, {-2, 72}, {38, 72}, {38, 72}}, color = {0, 0, 127}, thickness = 0.5));
  connect(costFirstThreeSectors[2], housing_sec.costPerHouseBuilt) annotation(
    Line(points = {{-110, 12}, {-2, 12}, {-2, 32}, {38, 32}, {38, 32}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demography.peoplePerFamily, housing_sec.peoplePerFamily) annotation(
    Line(points = {{-32, -58}, {12, -58}, {12, 16}, {38, 16}}, color = {0, 0, 127}));
  connect(demography.totalPopulation, housing_sec.totalPopulation) annotation(
    Line(points = {{-32, -34}, {10, -34}, {10, 22}, {38, 22}}, color = {0, 0, 127}));
  connect(totalPopulation_prev_year, housing_sec.totalPopulation_prev_year) annotation(
    Line(points = {{-110, 0}, {8, 0}, {8, 26}, {38, 26}, {38, 26}}, color = {0, 0, 127}));
  connect(constant_1.y, capital_sec.tradeEliminationModifier) annotation(
    Line(points = {{28, -60}, {38, -60}, {38, -62}}, color = {255, 127, 0}));
  connect(gnpPerSector_prev_year[5], capital_sec.gnpCapitalSector_prev_year) annotation(
    Line(points = {{-110, 36}, {-64, 36}, {-64, -18}, {-10, -18}, {-10, -66}, {38, -66}}, color = {0, 0, 127}, thickness = 0.5));
  connect(totalCapital_prev_year, capital_sec.totalCapital_prev_year) annotation(
    Line(points = {{-110, 24}, {-82, 24}, {-82, -20}, {-12, -20}, {-12, -70}, {38, -70}}, color = {0, 0, 127}));
  connect(gnpPerCapita_prev_year, capital_sec.gnpPerCapita_prev_year) annotation(
    Line(points = {{-110, -12}, {-84, -12}, {-84, -22}, {-14, -22}, {-14, -76}, {38, -76}}, color = {0, 0, 127}));
  connect(laborForceProportionsPerSector_prev_year, economy.laborForceProportionsPerSector_prev_year) annotation(
    Line(points = {{-110, 44}, {-82, 44}, {-82, 54}, {-64, 54}}, color = {0, 0, 127}, thickness = 0.5));
  connect(gnpProportionsPerSector_prev_year, capital_sec.gnpProportionsPerSector_prev_year) annotation(
    Line(points = {{-110, -24}, {-14, -24}, {-14, -80}, {38, -80}, {38, -80}}, color = {0, 0, 127}, thickness = 0.5));
  connect(capDistributionPerSector_prev_year, capital_sec.capDistributionPerSector_prev_year) annotation(
    Line(points = {{-110, 72}, {-86, 72}, {-86, -28}, {-18, -28}, {-18, -86}, {38, -86}, {38, -84}}, color = {0, 0, 127}, thickness = 0.5));
  connect(populationByAgeBySex_prev_year, demography.populationByAgeBySex_prev_year) annotation(
    Line(points = {{-110, -86}, {-84, -86}, {-84, -50}, {-64, -50}, {-64, -50}, {-64, -50}}, color = {0, 0, 127}, thickness = 0.5));
  connect(capDistributionPerSector_prev_year, capital_sec.capDistributionPerSector_prev_year) annotation(
    Line);
  connect(costFirstThreeSectors[3], education_sec.costPerEducationSlot) annotation(
    Line(points = {{-110, 12}, {-2, 12}, {-2, -8}, {38, -8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.laborForcePercentagePerSector[1], demography.agrLabForcePerc) annotation(
    Line(points = {{-32, 48}, {-20, 48}, {-20, -7.5}, {-66, -7.5}, {-66, -58.375}, {-64, -58.375}, {-64, -58}}, color = {0, 0, 127}, thickness = 0.5));
  connect(housing_sec.housesPerCapitaPercentage, housesPerCapitaPercentage) annotation(
    Line(points = {{68, 22}, {76, 22}, {76, 6}, {110, 6}}, color = {0, 0, 127}));
  connect(totalPopulation_prev_year, demography.totalPopulation_prev_year) annotation(
    Line(points = {{-110, 0}, {-76, 0}, {-76, -62}, {-64, -62}}, color = {0, 0, 127}));
  connect(lifeExpectancy_prev_year, demography.lifeExpectancy_prev_year) annotation(
    Line(points = {{-110, -98}, {-82, -98}, {-82, -52}, {-64, -52}, {-64, -52}}, color = {0, 0, 127}));
  connect(lifeExpectancy_prev_year, demography.lifeExpectancy_prev_year) annotation(
    Line);
  connect(crudeBirthRate_prev_year, demography.crudeBirthRate_prev_year) annotation(
    Line(points = {{-110, -74}, {-86, -74}, {-86, -47}, {-64, -47}, {-64, -48}}, color = {0, 0, 127}));
  connect(housesPerCapitaPercentage_prev_year, demography.housesPerCapitaPercentage_prev_year) annotation(
    Line(points = {{-110, -48}, {-90, -48}, {-90, -38}, {-64, -38}}, color = {0, 0, 127}));
  connect(demography.secondaryLaborForcePercentage_aux, secondaryLaborForcePercentage_aux) annotation(
    Line(points = {{-64, -42}, {-88, -42}, {-88, -62}, {-110, -62}}, color = {0, 0, 127}));
  connect(secondaryLaborForcePercentage_aux, demography.secondaryLaborForcePercentage_aux) annotation(
    Line);
  connect(urbanPopulationPercentage_prev_year, demography.urbanPopulationPercentage_prev_year) annotation(
    Line);
  connect(demography.urbanPopulationPercentage_prev_year, urbanPopulationPercentage_prev_year) annotation(
    Line(points = {{-64, -36}, {-110, -36}}, color = {0, 0, 127}));
  connect(costFirstThreeSectors[1], food_sec.costPerCalorieProduced) annotation(
    Line);
  connect(costFirstThreeSectors[2], housing_sec.costPerHouseBuilt) annotation(
    Line);
  connect(totalPopulation_prev_year, housing_sec.totalPopulation_prev_year) annotation(
    Line);
  connect(totalPopulation_prev_year, economy.totalPopulation_prev_year) annotation(
    Line(points = {{-110, 0}, {-76, 0}, {-76, 46}, {-64, 46}}, color = {0, 0, 127}));
  connect(laborForceProportion_prev_year, economy.laborForceProportion_prev_year) annotation(
    Line(points = {{-110, 58}, {-64, 58}}, color = {0, 0, 127}));
  connect(demography.totalPopulation, food_sec.totalPopulation) annotation(
    Line(points = {{-32, -34}, {2, -34}, {2, 94}, {38, 94}, {38, 94}}, color = {0, 0, 127}));
  connect(demography.totalPopulation, education_sec.totalPopulation) annotation(
    Line(points = {{-32, -34}, {-2, -34}, {-2, -22}, {38, -22}}, color = {0, 0, 127}));
  connect(demography.agePyramid[2], education_sec.population7to18) annotation(
    Line(points = {{-32, -42}, {0, -42}, {0, -30}, {38, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(housing_sec.housesPerCapitaPercentage, demography.housesPerCapitaPercentage) annotation(
    Line(points = {{68, 22}, {76, 22}, {76, -96}, {-74, -96}, {-74, -44}, {-64, -44}}, color = {0, 0, 127}));
  connect(food_sec.caloriesPerDayPerPerson, demography.caloriesPerDayPerPerson) annotation(
    Line(points = {{68, 84}, {70, 84}, {70, 98}, {-78, 98}, {-78, -34}, {-64, -34}, {-64, -34}}, color = {0, 0, 127}));
  connect(education_sec.enrolmentPercentage, demography.enrolmentPercentage) annotation(
    Line(points = {{68, -18}, {74, -18}, {74, -94}, {-72, -94}, {-72, -56}, {-64, -56}, {-64, -56}}, color = {0, 0, 127}));
  connect(demography.lifeExpectancy, lifeExpectancy) annotation(
    Line(points = {{-32, -54}, {90, -54}, {90, -66}, {110, -66}}, color = {0, 0, 127}));
  connect(capital_sec.totalCapital, totalCapital) annotation(
    Line(points = {{68, -62}, {87, -62}, {87, -82}, {110, -82}}, color = {0, 0, 127}));
  connect(capital_sec.capDistributionPerSector, capDistributionPerSector) annotation(
    Line(points = {{68, -72}, {84, -72}, {84, -98}, {110, -98}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demography.urbanPopulationPercentage, urbanPopulationPercentage) annotation(
    Line(points = {{-32, -50}, {102, -50}, {102, -52}, {110, -52}}, color = {0, 0, 127}));
  connect(demography.crudeBirthRate, crudeBirthRate) annotation(
    Line(points = {{-32, -46}, {82, -46}, {82, -38}, {110, -38}}, color = {0, 0, 127}));
  connect(demography.populationByAgeBySex, populationByAgeBySex) annotation(
    Line(points = {{-32, -38}, {80, -38}, {80, -26}, {110, -26}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demography.totalPopulation, totalPopulation) annotation(
    Line(points = {{-32, -34}, {78, -34}, {78, -10}, {110, -10}}, color = {0, 0, 127}));
  connect(demography.totalPopulation, economy.totalPopulation) annotation(
    Line(points = {{-32, -34}, {-28, -34}, {-28, 8}, {-72, 8}, {-72, 50}, {-64, 50}}, color = {0, 0, 127}));
  connect(demography.urbanPopulationPercentage, urbanPopulationPercentage) annotation(
    Line);
  connect(economy.laborForceProportion, laborForceProportion) annotation(
    Line);
  connect(economy.laborForcePercentagePerSector, laborForcePercentagePerSector) annotation(
    Line(points = {{-32, 48}, {110, 48}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.laborForceProportionsPerSector, laborForceProportionsPerSector) annotation(
    Line(points = {{-32, 52}, {87, 52}, {87, 62}, {110, 62}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.gnpPerSector, gnpPerSector) annotation(
    Line);
  connect(economy.gnpPerCapita, gnpPerCapita) annotation(
    Line(points = {{-32, 56}, {84, 56}, {84, 74}, {110, 74}}, color = {0, 0, 127}));
  connect(economy.gnpProportionsPerSector, gnpProportionsPerSector) annotation(
    Line(points = {{-32, 60}, {81, 60}, {81, 88}, {110, 88}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.gnpPerSector[3], education_sec.gnpEducationSector) annotation(
    Line(points = {{-32, 64}, {0, 64}, {0, -15}, {39, -15}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.gnpPerSector[2], housing_sec.gnpHousingSector) annotation(
    Line(points = {{-32, 64}, {0, 64}, {0, 9}, {39, 9}}, color = {0, 0, 127}, thickness = 0.5));
  connect(economy.gnpPerSector[1], food_sec.gnpFoodSector) annotation(
    Line(points = {{-32, 64}, {0, 64}, {0, 83}, {39, 83}}, color = {0, 0, 127}, thickness = 0.5));
  connect(capital_sec.capProportionPerSector, economy.capProportionPerSector) annotation(
    Line(points = {{68, -84}, {70.5, -84}, {70.5, -90}, {-68, -90}, {-68, 40}, {-64, 40}, {-64, 40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(capital_sec.totalCapital, economy.totalCapital) annotation(
    Line(points = {{68, -62}, {72, -62}, {72, -92}, {-70, -92}, {-70, 42}, {-64, 42}}, color = {0, 0, 127}));
  connect(gammaExponent, economy.gammaExponent) annotation(
    Line(points = {{-110, 88}, {-82, 88}, {-82, 62}, {-64, 62}}, color = {255, 127, 0}));
  connect(yearCounter, economy.yearCounter) annotation(
    Line(points = {{-110, 100}, {-80, 100}, {-80, 64}, {-64, 64}}, color = {255, 127, 0}));
  connect(food_sec.caloriesPerDayPerPerson, demography.caloriesPerDayPerPerson) annotation(
    Line);
  connect(education_sec.enrolmentPercentage, demography.enrolmentPercentage) annotation(
    Line);
  connect(yearCounter, demography.yearCounter) annotation(
    Line(points = {{-110, 100}, {-80, 100}, {-80, -30}, {-64, -30}}, color = {255, 127, 0}));
//Economy
// Inputs
// Outputs
// Capital Sector
// Inputs
// Outputs
// Education
//Inputs
//Outputs
// Food Sector
// Inputs
// Outputs
// Housing
// Inputs
// Outputs
// Demography
// Inputs
//Outputs
  annotation(
    Diagram);
end Projection;
