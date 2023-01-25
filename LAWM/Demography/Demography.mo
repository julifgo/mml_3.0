within LAWM.Demography;
package Demography
  block AgeStructureAndMortalities
  //=======================================================================
  //
  // THIS SUBROUTINE COMPUTES THE AGE STRUCTURE BY SEX OF THE POPULATION FOR YEAR T+1
  // INPUT: populationByAgeBySex_prev_year = AGE STRUCTURE BY SEX AT YEAR T  (POB in Poblac Fortran and POAGSX model.for)
  //        totalPopulation_prev_year = TOTAL POPULATION AT YEAR T  (TOTPOB in Poblac Fortran and POB in model.for)
  //        survivalRateByAgeBySex_this_year = SURVIVAL RATES BY SEX COMPUTED BY SUBROUTINE SOBRE (SUPERV in Poblac Fortran)
  //        fertilityOfWomenBetween16and50_this_year = SPECIFIC FERTILITY RATES COMPUTED BY SUBROUTINE FECUN (FECU in Poblac Fortran)
  // OUTPUT : populationByAgeBySex_this_year = AGE STRUCTURE BY SEX AT YEAR T+1 (PPOBB in Poblac Fortran and POAGSX model.for)
  //       childMortality_this_year = CHILD MORTALITY (CHMORT in Fortran)
  //       crudeDeathRate_this_year=CRUDE DEATH RATE (FMORT in Fortran)
  //
  //=======================================================================

  // Parameters
    parameter Real maleNewbornProbability = 0.5122;
  // Inputs:
    discrete LAWM.Utilities.Interfaces.RealInput populationByAgeBySex_prev_year[70,2]         annotation ( Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year                    annotation ( Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput survivalRateByAgeBySex_this_year[71,2]       annotation ( Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput fertilityOfWomenBetween16and50_this_year[35] annotation ( Placement(visible = true, transformation(origin = {-120,-60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120,-60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  // Outputs:
    discrete LAWM.Utilities.Interfaces.RealOutput populationByAgeBySex_this_year[70,2]        annotation ( Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput births_this_year                            annotation ( Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput totalPopulation_this_year                   annotation ( Placement(visible = true, transformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput totalDeaths                                 annotation ( Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput crudeDeathRate_this_year                    annotation ( Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput childMortality_this_year                    annotation ( Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  // Auxs:
    discrete Real survivors2yrsOrOlder;
    discrete Real deaths1yrOrOlder;
    discrete Real maleNewborns_this_year;
    discrete Real femaleNewborns_this_year;
    discrete Real deathsOfMaleNewborns_this_year;
    discrete Real deathsOfFemaleNewborns_this_year;
    discrete Real deathsOfNewborns;
    discrete Real DIMF;
    discrete Real SEPFAC;
    discrete Real X_initial;
    discrete Real chmor_aux_perSex[2];

  // Calculate for everyone except babies and the ones who had 70+ in time T
  equation
    for age in 1:68 loop
      populationByAgeBySex_this_year[age + 1, 1] = populationByAgeBySex_prev_year[age, 1] * survivalRateByAgeBySex_this_year[age + 1, 1];  // Men: Survivors of age I in time T will have age I+1 in T+1
      populationByAgeBySex_this_year[age + 1, 2] = populationByAgeBySex_prev_year[age, 2] * survivalRateByAgeBySex_this_year[age + 1, 2];  // Women: idem up
    end for;

  // Calculate for the ones that had 70 or more in time T
     populationByAgeBySex_this_year[70, 1] = populationByAgeBySex_prev_year[69, 1] * survivalRateByAgeBySex_this_year[70, 1] + populationByAgeBySex_prev_year[70, 1] * survivalRateByAgeBySex_this_year[71, 1]; // Men: new with 70 + the ones who had 70+ and survived
     populationByAgeBySex_this_year[70, 2] = populationByAgeBySex_prev_year[69, 2] * survivalRateByAgeBySex_this_year[70, 2] + populationByAgeBySex_prev_year[70, 2] * survivalRateByAgeBySex_this_year[71, 2]; // Women:idem up

     survivors2yrsOrOlder     = sum(populationByAgeBySex_this_year[age,1] + populationByAgeBySex_this_year[age,2] for age in 2:70);
     deaths1yrOrOlder         = totalPopulation_prev_year - survivors2yrsOrOlder;
  // Calculate for the newborns (they may or may not reach age 1)
     births_this_year         = sum(fertilityOfWomenBetween16and50_this_year[age - 15] * populationByAgeBySex_this_year[age, 2] for age in 16:50);
     maleNewborns_this_year   = maleNewbornProbability * births_this_year;
     femaleNewborns_this_year = births_this_year - maleNewborns_this_year;


     populationByAgeBySex_this_year[1, 1] = maleNewborns_this_year   * survivalRateByAgeBySex_this_year[1, 1];
     populationByAgeBySex_this_year[1, 2] = femaleNewborns_this_year * survivalRateByAgeBySex_this_year[1, 2];

     totalPopulation_this_year = survivors2yrsOrOlder + populationByAgeBySex_this_year[1, 1] + populationByAgeBySex_this_year[1, 2]; // this year's population = survivors from prev year + newborns from this year survivors


     deathsOfMaleNewborns_this_year   = maleNewborns_this_year         - populationByAgeBySex_this_year[1, 1];
     deathsOfFemaleNewborns_this_year = femaleNewborns_this_year       - populationByAgeBySex_this_year[1, 2];
     deathsOfNewborns                 = deathsOfMaleNewborns_this_year + deathsOfFemaleNewborns_this_year;
     totalDeaths                      = deathsOfNewborns               + deaths1yrOrOlder;


     crudeDeathRate_this_year = 2000. * totalDeaths /  (totalPopulation_this_year + totalPopulation_prev_year); // Ale: the 2k appears because (totalPopulation_this_year+totalPopulation_prev_year)/2 was a denominator, the 2 therefore is now multiplying and before there was a 1k (1k inhabitants)
  //
  // // Child mortality (the variables need to be renamed in the future)
  //
  // //
  // //=======================================================================
  // //
  // //    IN THE FOLLOWING, THE NON-LINEAR EQUATION
  // //         1.-EXP(-X)-X*survivalRateByAgeBySex_this_year(1,ISEXO)=0.
  // //    IS SOLVED BY THE NEWTON- RAPHSON ALGORITHM FOR ISEXO=1,2
  // //    CHILDREN MORTALITY FOR EACH SEX IS EQUAL TO   1000.*X
  // //    SEE ' INTRODUCTION TO  DEMOGRAPHIC ANALYSIS ' BY NADER FERGANY
  // //    THE AMERICAN UNIVERSITY AT CAIRO
  // //=======================================================================
  // //
  // //
    DIMF = (populationByAgeBySex_prev_year[1, 1] - populationByAgeBySex_this_year[2, 1]) + (populationByAgeBySex_prev_year[1, 2] - populationByAgeBySex_this_year[2, 2]);  // Ale: creo que los bebes entre 1 y 2 años (de ambos sexos) que se murieron)
    SEPFAC = 4 / ((survivalRateByAgeBySex_this_year[2, 1] + survivalRateByAgeBySex_this_year[2, 2]) * 3); // 125% * (probabilidad supervivencia de niños de 1 a 2 años varones por mismo pero mujeres)
    X_initial = (deathsOfMaleNewborns_this_year + deathsOfFemaleNewborns_this_year + SEPFAC * DIMF) / births_this_year;
    for sex in 1:2 loop
      // Set the aux calculation for this sex
      chmor_aux_perSex[sex] = CHMORAux_NewtonRaphson(X_initial,survivalRateByAgeBySex_this_year[1,sex]);
    end for;
    childMortality_this_year = 1000 * (maleNewbornProbability * chmor_aux_perSex[1] + (1 - maleNewbornProbability) * chmor_aux_perSex[2]);
  end AgeStructureAndMortalities;



  block WomenFertility
  // ALE: my explanation of the variables (the original didn't have them)
  // Input:
  //  BIRTH  = is BIRTHR (CRUDE BIRTH RATE PER 1000 INHABITANTS,(1960)) in model.for
  //  POB    = is POAGSX(1,J) (POPULATION PER AGE, SEX AND BLOCK) in  model.for. The (1,J) is because the second column is "2 columns in  one".
  //           It corresponds to "sex and block" at the same time,  instead of making the matrix a matrix of 3 dimensions. We are  basically
  //           given a 1 dimension vector but with data corresponding to a  2 dimensional matrix.
  // OUTPUT:
  //  FECUT  = it's defined as X (TOTAL FERTILITY RATE to the paper by Scolnik/Hopkins 1975) but it's never used. Original name in MML: FMF. I
  //           changed it because FECUT is the name given in the calling module. Handbook: FECUT = FMF = Total fecundity (defined as the average
  //           number of children a woman would have at the end of her fertile life if exposed to the present fecundity rates)
  //  FERTIL = Fertilidad de las mujeres entre las edades 16 a 50. Se puede definir usando distintas fórmulas  dependiendo del "rango" en el que
  //           esté la TOTAL FERTILITY RATE (X y FECUT) en el vector _TotFertRate_Xs.
  // Locals:
  //  X      = FECUT
  //  _TotFertRate_Xs = range of "TOTAL FERTILITY RATE" used to "encompass" the one calculated form the BIRTH input variable. It's used for the "X values" of the interpolation to obtain the fertilities for this BIRTH input.
  //  _Fecundity_Ys = it provides the standard fertilities. It's used as the "Y values" to obtain the fertilities for this BIRTH by interpolating it using _TotFertRate_Xs as the "X values".
  //  K      = used as the "index of the closest boundary" when the value falls out of the table on one of the sides (smaller than the min or larger than the max)
  //  A,B    = variables to calculate FERTIL. A changes meaning between uses and B is used for acumulating total births
  //
  // Explained in detail in:
  // "Handbook of the Latin American World Model", 1977, page 37 (44 in
  // pdf)

  // Parameters:
    parameter Real TotFertRate_Xs[6] = {2.4,3.1,4.7,5.3,5.5,6.6};
    parameter Real Fecundity_Ys[35,6]   ={
          {1.500000  , 8.130000  , 4.560000 , 4.720000 , 4.770000 , 5.040000},
          {8.000000  , 26.88000  , 48.01000 , 43.25000 , 41.66000 , 33.32000},
          {20.00000  , 48.38000  , 121.1900 , 114.0600 , 111.6800 , 99.19000},
          {25.60000  , 72.40000  , 180.3000 , 179.9900 , 179.8900 , 179.3500},
          {56.00000  , 115.6400  , 209.9900 , 214.8800 , 216.5100 , 225.0800},
          {83.00000  , 165.3000  , 233.2600 , 240.3000 , 242.6500 , 254.9900},
          {120.0000  , 201.1400  , 256.2300 , 263.1700 , 265.4900 , 277.6700},
          {151.6000  , 219.5200  , 273.9900 , 284.1300 , 287.5100 , 305.2900},
          {161.5000  , 213.4000  , 273.9800 , 292.3100 , 298.9000 , 330.4900},
          {165.5000  , 205.6200  , 269.4000 , 291.5300 , 298.4100 , 337.6700},
          {167.0000  , 198.6300  , 259.0800 , 284.0500 , 292.3700 , 336.1200},
          {166.0000  , 191.4800  , 248.6800 , 274.9500 , 283.7000 , 329.7100},
          {162.8000  , 182.5000  , 237.3500 , 264.7800 , 273.9200 , 321.9800},
          {150.0000  , 166.5100  , 222.7000 , 252.1900 , 262.0200 , 313.6900},
          {138.0000  , 150.9200  , 210.2600 , 240.3400 , 250.3600 , 303.0600},
          {124.0000  , 133.5800  , 195.7100 , 226.7500 , 237.1000 , 291.4900},
          {113.0000  , 117.7600  , 184.3100 , 214.9600 , 225.1800 , 278.9000},
          {101.7000  , 104.0000  , 176.4700 , 202.6300 , 213.0100 , 267.5900},
          {90.00000  , 91.50000  , 157.7100 , 189.7500 , 200.4300 , 256.5700},
          {80.00000  , 80.59000  , 146.2900 , 179.2700 , 190.2600 , 248.0400},
          {69.00000  , 70.66000  , 137.0900 , 169.5400 , 180.3500 , 237.1900},
          {60.00000  , 61.74000  , 127.5100 , 158.2600 , 168.5100 , 222.3900},
          {50.40000  , 53.24000  , 113.1900 , 144.2800 , 154.6400 , 209.1100},
          {43.50000  , 45.36000  , 96.37000 , 125.7000 , 135.4800 , 186.8800},
          {37.00000  , 39.16000  , 80.82000 , 106.8100 , 115.4700 , 160.9900},
          {28.50000  , 29.94000  , 65.12000 , 87.29000 , 94.68000 , 133.5200},
          {22.50000  , 23.42000  , 48.93000 , 68.55000 , 75.09000 , 109.4700},
          {17.40000  , 17.56000  , 38.81000 , 55.12000 , 60.56000 , 89.15000},
          {12.50000  , 13.08000  , 29.87000 , 43.69000 , 48.30000 , 72.52000},
          {8.000000  , 8.430000  , 25.09000 , 35.43000 , 38.87000 , 56.97000},
          {5.000000  , 5.260000  , 19.52000 , 28.03000 , 30.86000 , 45.75000},
          {2.500000  , 2.720000  , 13.95000 , 20.63000 , 22.85000 , 34.54000},
          {1.100000  , 1.290000  , 9.480000 , 14.90000 , 16.71000 , 26.22000},
          {0.6000000 , 0.6700000 , 5.160000 , 9.800000 , 11.35000 , 19.48000},
          {0.2000000 , 0.2800000 , 2.020000 , 5.370000 , 6.490000 , 12.36000} };

    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput crudeBirthRate_prev_year             annotation ( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput populationByAgeBySex_prev_year[70,2] annotation ( Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year                 annotation ( Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput fertilityOfWomenBetween16and50[35]  annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    // Auxs:
    discrete Real X;
    discrete Real B;  // births from initial calculation of fecundity rates
    discrete Real A; // used of the adjustment of the interpolated fecundity rates for matching the given natality
    discrete Real grossFertilityOfWomenBetween16and50[35];
  equation
    X=0.13794*crudeBirthRate_prev_year+0.10616;  // From the Book ' PRINCIPLES OF DEMOGRAPHY ', D.BOGUE,J.WILEY

  // In fortran it finds the position in the X grid once and uses it for all of the ages. Here it's "refound" for every pos even though it will always be the same position.
  // This solution is slower but simpler. If one wanted to do something similar to the Fortran version, Piecewise would need to be modified to offer the extra functionality
    for age in 16:50 loop
      // This for can be removed if we adapt Piecewise to accept matrices instead of arrays for Y and use the same X for every row of the Ys
      // (doing that may improve performance because the same position for X would be used for every row of Y)
      grossFertilityOfWomenBetween16and50[age-15]  = LAWM.Other.Interpolation.Piecewise(X,TotFertRate_Xs,Fecundity_Ys[age-15,:]);
    end for;

  // Calculate the number of births corresponding to the initial fecundity rates
    B                              = sum(grossFertilityOfWomenBetween16and50[age -15]*populationByAgeBySex_prev_year[age,2] for age in 16:50);
  // ADJUSTMENT OF THE INTERPOLATED FECUNDITY RATES FOR MATCHING THE GIVEN NATALITY
    A                              = 0.001*crudeBirthRate_prev_year*totalPopulation_prev_year/B;
    fertilityOfWomenBetween16and50 = grossFertilityOfWomenBetween16and50*A;
  end WomenFertility;

  block SurvivalRates
    // Parameters:
    // Life expectancy Xs used for interpolation
    parameter Real LiEx_Xs_perSex[4,2] = {
                                      {40.65, 43.06}, // [male,female]
                                      {50.23, 53.62},
                                      {58.91, 62.7 },
                                      {66.8 , 73.24} }; // X values of interpolation table. The life expectancy will be enclosed between 2 of these values or one of the boundaries

    parameter Real survRate_Ys[2,71,4] = {
    {
      {0.8485             , 0.91126           , 0.95759           , 0.97535           },  //sr_age_0_to_1_m
      {0.9083385559649876,0.9493106510628767,0.9888810512899999,0.9950437952699400},  //sr_age_1_to_2_m
      {0.9581794771939670,0.9761382093897369,0.9957304797399148,0.9976395028512668},  //sr_age_2_to_3_m
      {0.9786235968762842,0.9872997837949199,0.9980781564201547,0.9987620414156196},  //sr_age_3_to_4_m
      {0.9887504931277135,0.9929583868420435,0.9989875269788113,0.9993194325900443},  //sr_age_4_to_5_m
      {0.9940704392301950,0.9960163813065409,0.9992932282056086,0.9995919059649698},  //sr_age_5_to_6_m
      {0.9968339985099910,0.9976622874847076,0.9993176624405615,0.9997023728995997},  //sr_age_6_to_7_m
      {0.9981370108830079,0.9984804335336122,0.9992081521688135,0.9997152499519505},  //sr_age_7_to_8_m
      {0.9985734161470897,0.9987921494962981,0.9990385335050329,0.9996681503416528},  //sr_age_8_to_9_m
      {0.9984888253913884,0.9987878989235115,0.9988476095528931,0.9995846470008360},  //sr_age_9_to_10_m
      {0.9980944116434924,0.9985866582975046,0.9986559883787024,0.9994802288323609},  //sr_age_10_to_11_m
      {0.9975235931999935,0.9982655636653478,0.9984742460531745,0.9993653869941156},  //sr_age_11_to_12_m
      {0.9968624945799232,0.9978759264293476,0.9983071919799490,0.9992473450886659},  //sr_age_12_to_13_m
      {0.9961673209160438,0.9974524333850736,0.9981562282385938,0.9991310908524672},  //sr_age_13_to_14_m
      {0.9954747508803952,0.9970186982885699,0.9980207135070974,0.9990200227779682},  //sr_age_14_to_15_m
      {0.9948083992928154,0.9965907498361984,0.9978987791192581,0.9989163724492033},  //sr_age_15_to_16_m
      {0.9941829668709007,0.9961792981876402,0.9977878304752906,0.9988214901449392},  //sr_age_16_to_17_m
      {0.9936069774818377,0.9957912503529069,0.9976848613215946,0.9987360438161028},  //sr_age_17_to_18_m
      {0.9930846251643523,0.9954307483914488,0.9975866534790624,0.9986601613441312},  //sr_age_18_to_19_m
      {0.9926170447058860,0.9950998958368450,0.9974899047566574,0.9985935345857121},  //sr_age_19_to_20_m
      {0.9922032001303975,0.9947992753853775,0.9973913109528569,0.9985354970188773},  //sr_age_20_to_21_m
      {0.9918405147059653,0.9945283238065656,0.9972876180379263,0.9984850827439071},  //sr_age_21_to_22_m
      {0.9915253229382133,0.9942856073223308,0.9971756547301156,0.9984410720524350},  //sr_age_22_to_23_m
      {0.9912531980313638,0.9940690264226476,0.9970523520665344,0.9984020271470658},  //sr_age_23_to_24_m
      {0.9910191910112520,0.9938759698947137,0.9969147543016889,0.9983663205215009},  //sr_age_24_to_25_m
      {0.9908180064120293,0.9937034318007811,0.9967600240156091,0.9983321577910313},  //sr_age_25_to_26_m
      {0.9906441319220896,0.9935481010931593,0.9965854433693484,0.9982975962703650},  //sr_age_26_to_27_m
      {0.9904919342888190,0.9934064307965357,0.9963884128221420,0.9982605602523860},  //sr_age_27_to_28_m
      {0.9903557302951330,0.9932746917791437,0.9961664482074571,0.9982188536984729},  //sr_age_28_to_29_m
      {0.9902298391845871,0.9931490147935854,0.9959171767829884,0.9981701708765025},  //sr_age_29_to_30_m
      {0.9901086211948877,0.9930254235146663,0.9956383326768878,0.9981121053556616},  //sr_age_30_to_31_m
      {0.9899865056412346,0.9928998606150842,0.9953277520197682,0.9980421576736066},  //sr_age_31_to_32_m
      {0.9898580110984266,0.9927682084200365,0.9949833679599409,0.9979577419217323},  //sr_age_32_to_33_m
      {0.9897177595998958,0.9926263053141606,0.9946032056951939,0.9978561914417476},  //sr_age_33_to_34_m
      {0.9895604862916040,0.9924699588010064,0.9941853776095279,0.9977347637867390},  //sr_age_34_to_35_m
      {0.9893810456336858,0.9922949559112337,0.9937280785718188,0.9975906450691732},  //sr_age_35_to_36_m
      {0.9891744149806305,0.9920970715005843,0.9932295814313361,0.9974209537944614},  //sr_age_36_to_37_m
      {0.9889356961781667,0.9918720748616359,0.9926882327296576,0.9972227442600993},  //sr_age_37_to_38_m
      {0.9886601156622630,0.9916157349830332,0.9921024486378225,0.9969930095857368},  //sr_age_38_to_39_m
      {0.9883430234388889,0.9913238247199306,0.9914707111202183,0.9967286844279019},  //sr_age_39_to_40_m
      {0.9879798912331788,0.9909921240861070,0.9907915643217158,0.9964266474238114},  //sr_age_40_to_41_m
      {0.9875663100313918,0.9906164228351350,0.9900636111712873,0.9960837234012427},  //sr_age_41_to_42_m
      {0.9870979871932827,0.9901925224654279,0.9892855101932646,0.9956966853853774},  //sr_age_42_to_43_m
      {0.9865707432631029,0.9897162377576414,0.9884559725161631,0.9952622564286332},  //sr_age_43_to_44_m
      {0.9859805085893681,0.9891833979317884,0.9875737590683829,0.9947771112854468},  //sr_age_44_to_45_m
      {0.9853233198273970,0.9885898474955430,0.9866376779498804,0.9942378779506843},  //sr_age_45_to_46_m
      {0.9845953163908443,0.9879314468410655,0.9856465819690029,0.9936411390775899},  //sr_age_46_to_47_m
      {0.9837927368955894,0.9872040726378191,0.9845993663339394,0.9929834332889246},  //sr_age_47_to_48_m
      {0.9829119156336569,0.9864036180598661,0.9834949664886636,0.9922612563930268},  //sr_age_48_to_49_m
      {0.9819492791030815,0.9855259928789969,0.9823323560837083,0.9914710625149459},  //sr_age_49_to_50_m
      {0.9809013426125585,0.9845671234498030,0.9811105450726466,0.9906092651514427},  //sr_age_50_to_51_m
      {0.9797647069765540,0.9835229526080231,0.9798285779256954,0.9896722381575137},  //sr_age_51_to_52_m
      {0.9785360553090386,0.9823894394993471,0.9784855319523973,0.9886563166711403},  //sr_age_52_to_53_m
      {0.9772121499236154,0.9811625593535152,0.9770805157258688,0.9875577979821213},  //sr_age_53_to_54_m
      {0.9757898293433178,0.9798383032153755,0.9756126676016222,0.9863729423501554},  //sr_age_54_to_55_m
      {0.9742660054223098,0.9784126776427898,0.9740811543244586,0.9850979737767303},  //sr_age_55_to_56_m
      {0.9726376605780993,0.9768817043793484,0.9724851697173855,0.9837290807348504},  //sr_age_56_to_57_m
      {0.9709018451362481,0.9752414200087034,0.9708239334469605,0.9822624168601810},  //sr_age_57_to_58_m
      {0.9690556747843941,0.9734878755959547,0.9690966898598710,0.9806941016068054},  //sr_age_58_to_59_m
      {0.9670963281318922,0.9716171363204831,0.9673027068859281,0.9790202208704324},  //sr_age_59_to_60_m
      {0.9650210443726233,0.9696252811040611,0.9654412750030277,0.9772368275816169},  //sr_age_60_to_61_m
      {0.9628271210508914,0.9675084022371665,0.9635117062599421,0.9753399422712685},  //sr_age_61_to_62_m
      {0.9605119119221992,0.9652626050058177,0.9615133333531238,0.9733255536105196},  //sr_age_62_to_63_m
      {0.9580728249072451,0.9628840073214769,0.9594455087539741,0.9711896189268093},  //sr_age_63_to_64_m
      {0.9555073201370196,0.9603687393545567,0.9573076038832979,0.9689280646978559},  //sr_age_64_to_65_m
      {0.9528129080822882,0.9577129431740600,0.9550990083299009,0.9665367870250530},  //sr_age_65_to_66_m
      {0.9499871477656604,0.9549127723933535,0.9528191291105064,0.9640116520876665},  //sr_age_66_to_67_m
      {0.9470276450528931,0.9519643918231996,0.9504673899683798,0.9613484965790924},  //sr_age_67_to_68_m
      {0.9439320510183857,0.9488639771329296,0.9480432307082274,0.9585431281263268},  //sr_age_68_to_69_m
      {0.9406980603819881,0.9456077145196602,0.9455461065651201,0.9555913256936972},  //sr_age_69_to_70_m
      {0.89344            , 0.89552           , 0.91257          , 0.90976        }  //sr_age_70_to_71_m

    },
    {
        {0.86505            , 0.92803           , 0.96629           , 0.98109           },   // sr_age_0_to_1_f
        {0.9081562050737008,0.9555521163314907,0.9907552313340000,0.9961043772832302},   // sr_age_1_to_2_f
        {0.9578238030789450,0.9786127644607275,0.9963703394456963,0.9979806610154374},   // sr_age_2_to_3_f
        {0.9784596773534491,0.9883475858853754,0.9982718202154376,0.9987938146671025},   // sr_age_3_to_4_f
        {0.9887793147421114,0.9933674146101854,0.9990290206015054,0.9992324465600220},   // sr_age_4_to_5_f
        {0.9942368879512553,0.9961351650670162,0.9993146087836519,0.9994895161031853},   // sr_age_5_to_6_f
        {0.9970799375735027,0.9976642735524139,0.9993815168361380,0.9996438073703978},   // sr_age_6_to_7_f
        {0.9984128389589860,0.9984564699987495,0.9993429828788672,0.9997343146901566},   // sr_age_7_to_8_f
        {0.9988399003912501,0.9987900979770239,0.9992548439975558,0.9997827996161831},   // sr_age_8_to_9_f
        {0.9987163770732554,0.9988318907078512,0.9991460595082120,0.9998024534643036},   // sr_age_9_to_10_f
        {0.9982617683092885,0.9986872984133542,0.9990318471007605,0.9998017707004915},   // sr_age_10_to_11_f
        {0.9976164885146960,0.9984256802364618,0.9989199545155941,0.9997864775180839},   // sr_age_11_to_12_f
        {0.9968724786944675,0.9980939566892770,0.9988138914848568,0.9997605724818496},   // sr_age_12_to_13_f
        {0.9960907599771230,0.9977244813879714,0.9987146947074982,0.9997269242187192},   // sr_age_13_to_14_f
        {0.9953119921602681,0.9973398114138708,0.9986219359464044,0.9996876321970957},   // sr_age_14_to_15_f
        {0.9945630776361999,0.9969557189397564,0.9985343182646105,0.9996442534465921},   // sr_age_15_to_16_f
        {0.9938614279921860,0.9965831587567090,0.9984500382619774,0.9995979497936753},   // sr_age_16_to_17_f
        {0.9932177967261315,0.9962295916063871,0.9983670105781560,0.9995495860791219},   // sr_age_17_to_18_f
        {0.9926382040097933,0.9958998967698133,0.9982830089265122,0.9994997971092284},   // sr_age_18_to_19_f
        {0.9921252706600540,0.9955970152208580,0.9981957553154848,0.9994490340715465},   // sr_age_19_to_20_f
        {0.9916791585042201,0.9953224116057031,0.9981029764717670,0.9993975971117047},   // sr_age_20_to_21_f
        {0.9912982430428142,0.9950764117123078,0.9980024391747222,0.9993456583686047},   // sr_age_21_to_22_f
        {0.9909796007050450,0.9948584527014228,0.9978919718685121,0.9992932782945257},   // sr_age_22_to_23_f
        {0.9907193656173628,0.9946672711496689,0.9977694772715749,0.9992404171605777},   // sr_age_23_to_24_f
        {0.9905129932209533,0.9945010460696974,0.9976329390544236,0.9991869430507443},   // sr_age_24_to_25_f
        {0.9903554565445210,0.9943575088754815,0.9974804246100132,0.9991326372542462},   // sr_age_25_to_26_f
        {0.9902413932374412,0.9942340287696588,0.9973100852651168,0.9990771977016086},   // sr_age_26_to_27_f
        {0.9901652162378608,0.9941276796437163,0.9971201548383639,0.9990202409091096},   // sr_age_27_to_28_f
        {0.9901211973431856,0.9940352929247899,0.9969089471567056,0.9989613027706798},   // sr_age_28_to_29_f
        {0.9901035304281682,0.9939534996356570,0.9966748529448773,0.9988998384478203},   // sr_age_29_to_30_f
        {0.9901063792699266,0.9938787641010900,0.9964163363688302,0.9988352215448245},   // sr_age_30_to_31_f
        {0.9901239136593410,0.9938074111315949,0.9961319314228855,0.9987667427107948},   // sr_age_31_to_32_f
        {0.9901503365524525,0.9937356480754103,0.9958202382877218,0.9986936077764405},   // sr_age_32_to_33_f
        {0.9901799043371171,0.9936595828044505,0.9954799197430583,0.9986149355088312},   // sr_age_33_to_34_f
        {0.9902069417910826,0.9935752384575639,0.9951096976889907,0.9985297550487454},   // sr_age_34_to_35_f
        {0.9902258529350804,0.9934785655818921,0.9947083498092381,0.9984370030812703},   // sr_age_35_to_36_f
        {0.9902311287059318,0.9933654521746696,0.9942747063952430,0.9983355207796552},   // sr_age_36_to_37_f
        {0.9902173521638663,0.9932317320218327,0.9938076473402618,0.9982240505542702},   // sr_age_37_to_38_f
        {0.9901792017880310,0.9930731916481538,0.9933060993058658,0.9981012326321822},   // sr_age_38_to_39_f
        {0.9901114532918420,0.9928855761301988,0.9927690330588205,0.9979656014879553},   // sr_age_39_to_40_f
        {0.9900089802952734,0.9926645939738959,0.9921954609733514,0.9978155821424189},   // sr_age_40_to_41_f
        {0.9898667541186364,0.9924059212196196,0.9915844346919819,0.9976494863430883},   // sr_age_41_to_42_f
        {0.9896798429055698,0.9921052049068310,0.9909350429370423,0.9974655086375135},   // sr_age_42_to_43_f
        {0.9894434102386994,0.9917580660058900,0.9902464094644039,0.9972617223488843},   // sr_age_43_to_44_f
        {0.9891527133770385,0.9913601019051188,0.9895176911508218,0.9970360754616716},   // sr_age_44_to_45_f
        {0.9888031012167237,0.9909068885254080,0.9887480762063228,0.9967863864238140},   // sr_age_45_to_46_f
        {0.9883900120553615,0.9903939821220380,0.9879367825033258,0.9965103398709515},   // sr_age_46_to_47_f
        {0.9879089712230921,0.9898169208231119,0.9870830560145090,0.9962054822773616},   // sr_age_47_to_48_f
        {0.9873555886301749,0.9891712259455757,0.9861861693518498,0.9958692175375679},   // sr_age_48_to_49_f
        {0.9867255562699775,0.9884524031230452,0.9852454203996881,0.9954988024820316},   // sr_age_49_to_50_f
        {0.9860146457079280,0.9876559432739521,0.9842601310351267,0.9950913423298652},   // sr_age_50_to_51_f
        {0.9852187055798857,0.9867773234340148,0.9832296459295086,0.9946437860811165},   // sr_age_51_to_52_f
        {0.9843336591182968,0.9858120074731224,0.9821533314251671,0.9941529218508458},   // sr_age_52_to_53_f
        {0.9833555017198208,0.9847554467136043,0.9810305744820460,0.9936153721469468},   // sr_age_53_to_54_f
        {0.9822802985648462,0.9836030804642409,0.9798607816891959,0.9930275890934356},   // sr_age_54_to_55_f
        {0.9811041822965157,0.9823503364821550,0.9786433783365174,0.9923858496007252},   // sr_age_55_to_56_f
        {0.9798233507646855,0.9809926313728440,0.9773778075424766,0.9916862504842524},   // sr_age_56_to_57_f
        {0.9784340648381887,0.9795253709372087,0.9760635294338484,0.9909247035326701},   // sr_age_57_to_58_f
        {0.9769326462881133,0.9779439504729603,0.9747000203738313,0.9900969305267080},   // sr_age_58_to_59_f
        {0.9753154757426393,0.9762437550368175,0.9732867722351768,0.9891984582096893},   // sr_age_59_to_60_f
        {0.9735789907142610,0.9744201596729967,0.9718232917152199,0.9882246132106139},   // sr_age_60_to_61_f
        {0.9717196836985281,0.9724685296125837,0.9703090996899393,0.9871705169206286},   // sr_age_61_to_62_f
        {0.9697341003437000,0.9703842204478774,0.9687437306044056,0.9860310803236498},   // sr_age_62_to_63_f
        {0.9676188376897242,0.9681625782851107,0.9671267318971588,0.9848009987818322},   // sr_age_63_to_64_f
        {0.9653705424751456,0.9657989398785154,0.9654576634562607,0.9834747467765380},   // sr_age_64_to_65_f
        {0.9629859095098829,0.9632886327483238,0.9637360971049267,0.9820465726054076},   // sr_age_65_to_66_f
        {0.9604616801119630,0.9606269752848611,0.9619616161148059,0.9805104930360943},   // sr_age_66_to_67_f
        {0.9577946406061649,0.9578092768406776,0.9601338147451153,0.9788602879171933},   // sr_age_67_to_68_f
        {0.9549816208822661,0.9548308378123267,0.9582522978059733,0.9770894947468616},   // sr_age_68_to_69_f
        {0.9520194930107844,0.9516869497132533,0.9563166802443952,0.9751914031995963},   // sr_age_69_to_70_f
        {0.90554             , 0.90126           , 0.92315          , 0.92428       }   // sr_age_70_to_71_f
        } };
   // Inputs
   discrete LAWM.Utilities.Interfaces.RealInput lifeExpectancy_prev_year annotation( Placement(visible = true, transformation(origin = {-60, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
   // Outputs
   discrete LAWM.Utilities.Interfaces.RealOutput survivalRateByAgeBySex[71,2] annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Auxs:
  protected
    discrete Integer i;
    discrete Integer r_X_point;
    discrete Integer l_X_point;
    discrete Real y_1;
    discrete Real y_0;
    discrete Real x;
    discrete Real x_0;
    discrete Real x_1;

  algorithm
  // IMPORTANT:
  // 1) We use "algorithm" instead of "equation" because for now it will be enough. The code should be adapted to equation in the future
  // 2) We don't use "Piecewise" because in the original Fortran code the position in the X grid was chosen only from the males X grid. This means that the female values depend on the male values
  //    instead of their own. In the future, this should be fixed so females depend on females

    r_X_point := 1;
    i := 1;
    for i in 1:4 loop
    //  Find where the life expectancy fits in the male X values of the interpolation table
      if lifeExpectancy_prev_year < LiEx_Xs_perSex[i,1] then
        r_X_point := i;
        break;
      else
        r_X_point := r_X_point +1;
      end if;
    end for;
    if r_X_point > 3 then
      r_X_point := 4;  // 4 will be the max right point.
    end if;
    l_X_point := r_X_point -1; // lifeExpectancy_prev_year lies between l_X_point and r_X_point positions of the first dimension of _LiEx_Xs_perSex
    for i_sex in 1:2 loop
      for age_to_reach in 1:71 loop // age_to_reach will be the probability of people of age age_to_reach-1 reaching age age_to_reach
        // Linearly interpolate using the values that sorround the found X
        y_1 := survRate_Ys[i_sex,age_to_reach,r_X_point];
        y_0 := survRate_Ys[i_sex,age_to_reach,l_X_point];
        x   := lifeExpectancy_prev_year;
        x_0 := LiEx_Xs_perSex[l_X_point,i_sex];
        x_1 := LiEx_Xs_perSex[r_X_point,i_sex];
        // Linear Interpolation:
        survivalRateByAgeBySex[age_to_reach,i_sex] := (y_1-y_0)*(x-x_0)/(x_1-x_0)+y_0;

        if survivalRateByAgeBySex[age_to_reach,i_sex] > 1 then
          survivalRateByAgeBySex[age_to_reach,i_sex] := 0.99971;
        end if;
      end for;
    end for;
  end SurvivalRates;

  block AgePyramid
   // agePyram(1) = pop ages 1 to 6
   // agePyram(2) = pop ages 7 to 18
   // agePyram(3) = pop ages 11 to 70
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput populationByAgeBySex[70,2] annotation( Placement(visible = true, transformation(origin = {-60, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput agePyramid[3] annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
      agePyramid[1] = sum(populationByAgeBySex[age,1] +  populationByAgeBySex[age,2] for age in 1:6);
      agePyramid[2] = sum(populationByAgeBySex[age,1] +  populationByAgeBySex[age,2] for age in 7:18);
      agePyramid[3] = sum(populationByAgeBySex[age,1] +  populationByAgeBySex[age,2] for age in 11:70);
  end AgePyramid;

  block PeoplePerFamily
    // Parameters
     // houserPerCapita is a "capped variable" in the code but not in the output. That is, it has a max value for its uses in the code but its calculated value is writen to file.
     // We put the max value here until we decide where it's the right place to put it
    parameter Real maxHousesPerCapitaPercentage = 25;
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput crudeBirthRate_prev_year            annotation ( Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput crudeDeathRate                      annotation ( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput childMortality                      annotation ( Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput urbanPopulationPercentage_prev_year annotation ( Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput housesPerCapitaPercentage_prev_year annotation ( Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput peoplePerFamily                    annotation ( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
          peoplePerFamily = 0.02325 * crudeBirthRate_prev_year - 0.0767 * crudeDeathRate - 0.0012 * childMortality - 0.008668 * urbanPopulationPercentage_prev_year - 0.06036 * min(housesPerCapitaPercentage_prev_year,maxHousesPerCapitaPercentage) + 5.9756;
  end PeoplePerFamily;

  block LifeExpectancy
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput enrolmentPercentage annotation( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput crudeBirthRate_prev_year annotation( Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput agrLabForcePerc annotation( Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput lifeExpectancy annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
    discrete Real aux1,aux2,aux3,aux4;
  equation
    aux1 =-0.052492531*enrolmentPercentage^2.5693255;
    aux2 =+0.054749165*enrolmentPercentage^2.5607114;
    aux3 =-0.006852093*crudeBirthRate_prev_year^1.8622645;
    aux4 =-0.096324172*agrLabForcePerc^1.1816027;
    lifeExpectancy = aux1 + aux2 + aux3 + aux4 + 55.153412;
  end LifeExpectancy;

  block UrbanPopulation
    //Parameters
    parameter Real cultivatedArableLand1960= 0.6144; // We have to put a default value or openmodelica gets buggy and returns random values
    parameter Real initialUrbanPopPercentage;
    //Inputs
    discrete LAWM.Utilities.Interfaces.RealInput population annotation( Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.IntegerInput yearCounter annotation( Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    //Ouputs
    discrete LAWM.Utilities.Interfaces.RealOutput urbanPopulation annotation( Placement(visible = true, transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput urbanPopulationPercentage annotation( Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
  // Auxs
    discrete Real urbanPopPerc_base;
  equation
  // Projection and first year of optim:
      urbanPopPerc_base = initialUrbanPopPercentage + cultivatedArableLand1960 * (yearCounter-1);
      urbanPopulation = 0.01 * urbanPopPerc_base * population;
  // Every year:
      urbanPopulationPercentage = if urbanPopPerc_base <= 100 then urbanPopPerc_base else 100;
  end UrbanPopulation;

  block CrudeBirthRate
  // Parameters
    // houserPerCapita is a "capped variable" in the code but not in the output. That is, it has a max value for its uses in the code but its calculated value is writen to file.
    // We put the max value here until we decide where it's the right place to put it
    parameter Real maxHousesPerCapitaPercentage = 25;
  // Inputs
    input Real caloriesPerDayPerPerson;
    input Real secondaryLaborForcePercentage_aux; // this value corresponds to "maximum value of secondary labor force percentage in the past"
    input Real enrolmentPercentage;
    input Real lifeExpectancy;
    input Real housesPerCapitaPercentage;
  // Outputs
    output Real crudeBirthRate;
  equation
    crudeBirthRate   = -0.39895642E-12*caloriesPerDayPerPerson^3.725411 -0.16189216*secondaryLaborForcePercentage_aux^1.251819 -0.17435076*enrolmentPercentage^0.838319 +0.36618269E3*lifeExpectancy^(-0.695212) -0.62262631*min(housesPerCapitaPercentage,maxHousesPerCapitaPercentage)^0.981753+29.0057;
  end CrudeBirthRate;

  block Demography
    // Parameters
    parameter Real maleNewbornProbability;
    parameter Real maxHousesPerCapitaPercentage;
    parameter Real cultivatedArableLand1960;
    parameter Real initialUrbanPopPercentage;
    //Components
    LAWM.Demography.Demography.AgeStructureAndMortalities age_struct_and_morts(maleNewbornProbability = maleNewbornProbability);
    LAWM.Demography.Demography.WomenFertility women_fert();
    LAWM.Demography.Demography.SurvivalRates surv_rates();
    LAWM.Demography.Demography.AgePyramid age_pyram();
    LAWM.Demography.Demography.PeoplePerFamily people_per_fam(maxHousesPerCapitaPercentage);
    LAWM.Demography.Demography.LifeExpectancy life_expect();
    LAWM.Demography.Demography.UrbanPopulation urban_pop(cultivatedArableLand1960=cultivatedArableLand1960, initialUrbanPopPercentage = initialUrbanPopPercentage);
    LAWM.Demography.Demography.CrudeBirthRate crude_birth_r(maxHousesPerCapitaPercentage);
    // Inputs
    discrete LAWM.Utilities.Interfaces.IntegerInput yearCounter                       annotation ( Placement(visible = true, transformation(origin = {-110, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput enrolmentPercentage                  annotation ( Placement(visible = true, transformation(origin = {-110, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput agrLabForcePerc                      annotation ( Placement(visible = true, transformation(origin = {-110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput caloriesPerDayPerPerson              annotation ( Placement(visible = true, transformation(origin = {-110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput crudeBirthRate_prev_year             annotation ( Placement(visible = true, transformation(origin = {-110, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput urbanPopulationPercentage_prev_year  annotation ( Placement(visible = true, transformation(origin = {-110, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput housesPerCapitaPercentage_prev_year  annotation ( Placement(visible = true, transformation(origin = {-110, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput secondaryLaborForcePercentage_aux    annotation ( Placement(visible = true, transformation(origin = {-110, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput housesPerCapitaPercentage            annotation ( Placement(visible = true, transformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput lifeExpectancy_prev_year             annotation ( Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation_prev_year            annotation ( Placement(visible = true, transformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput populationByAgeBySex_prev_year[70,2] annotation ( Placement(visible = true, transformation(origin = {-110, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput peoplePerFamily                    annotation ( Placement(visible = true , transformation(origin = {110 , -90.00  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , -90.00   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput lifeExpectancy                     annotation ( Placement(visible = true , transformation(origin = {110 , -60.00  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , -60.00   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput urbanPopulationPercentage          annotation ( Placement(visible = true , transformation(origin = {110 , -30.00  } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , -30.00   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput crudeBirthRate                     annotation ( Placement(visible = true , transformation(origin = {110 , 0.00    } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , 0.00     } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput agePyramid[3]                      annotation ( Placement(visible = true , transformation(origin = {110 , 30.00   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , 30.00    } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput populationByAgeBySex[70,2]         annotation ( Placement(visible = true , transformation(origin = {110 , 60.00   } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , 60.00    } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealOutput totalPopulation                    annotation ( Placement(visible = true , transformation(origin = {110 , 90      } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {110 , 90       } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
  equation
  
// People per family
  // Inputs
  people_per_fam.crudeBirthRate_prev_year            = crudeBirthRate_prev_year;
  people_per_fam.crudeDeathRate                      = age_struct_and_morts.crudeDeathRate_this_year;
  people_per_fam.childMortality                      = age_struct_and_morts.childMortality_this_year;
  people_per_fam.urbanPopulationPercentage_prev_year = urbanPopulationPercentage_prev_year;
  people_per_fam.housesPerCapitaPercentage_prev_year = housesPerCapitaPercentage_prev_year;
  // Outputs
  peoplePerFamily = people_per_fam.peoplePerFamily;
  
// Life expectancy
  // Inputs
  life_expect.enrolmentPercentage      = enrolmentPercentage;
  life_expect.crudeBirthRate_prev_year = crudeBirthRate_prev_year;
  life_expect.agrLabForcePerc          = agrLabForcePerc;
  // Outputs
  lifeExpectancy = life_expect.lifeExpectancy;
  
// Urban population
  // Inputs
  urban_pop.population                = age_struct_and_morts.totalPopulation_this_year;
  urban_pop.yearCounter               = yearCounter;
  // Outputs
  urbanPopulationPercentage = urban_pop.urbanPopulationPercentage;
  
// Birth Rate
  // Inputs
  crude_birth_r.caloriesPerDayPerPerson           = caloriesPerDayPerPerson;
  crude_birth_r.secondaryLaborForcePercentage_aux = secondaryLaborForcePercentage_aux;
  crude_birth_r.enrolmentPercentage               = enrolmentPercentage;
  crude_birth_r.lifeExpectancy                    = life_expect.lifeExpectancy;
  crude_birth_r.housesPerCapitaPercentage         = housesPerCapitaPercentage;
  // Outputs
  crudeBirthRate     = crude_birth_r.crudeBirthRate;

// Survival rates
  // Inputs
  surv_rates.lifeExpectancy_prev_year = lifeExpectancy_prev_year;
// Women fertility
  // Inputs
  women_fert.populationByAgeBySex_prev_year = populationByAgeBySex_prev_year;
  women_fert.totalPopulation_prev_year      = totalPopulation_prev_year;
  women_fert.crudeBirthRate_prev_year       = crudeBirthRate_prev_year;
// Age pyramid
  // Inputs
  age_pyram.populationByAgeBySex = age_struct_and_morts.populationByAgeBySex_this_year;
  // Outputs
  agePyramid =  age_pyram.agePyramid;

// Age Structures and Mortalities
  //Inputs
  age_struct_and_morts.totalPopulation_prev_year                = totalPopulation_prev_year;
  age_struct_and_morts.populationByAgeBySex_prev_year           = populationByAgeBySex_prev_year;
  age_struct_and_morts.survivalRateByAgeBySex_this_year         = surv_rates.survivalRateByAgeBySex;
  age_struct_and_morts.fertilityOfWomenBetween16and50_this_year = women_fert.fertilityOfWomenBetween16and50;
  //Outputs
  populationByAgeBySex = age_struct_and_morts.populationByAgeBySex_this_year;
  totalPopulation      = age_struct_and_morts.totalPopulation_this_year;
  end Demography;



  // // Auxs:
  function CHMORAux_NewtonRaphson
    input  Real X_initial;
    input  Real survivalRate;
    output Real X_final;
  protected
    // Auxs:
    Real X;
    Real D;
  algorithm
     // First aproximation
    assert(not X_initial==0, "Error inside 'CHMORAux_NewtonRaphson'. X_initial shouldn't be 0. X_initial = "+String(X_initial)+ ", survivalRate= "+String(survivalRate));
     X := X_initial;
     D := newXEstimate(X,survivalRate);
     // Successive aproximations
     while noEvent(abs(D - X) > 0.00001) loop
       D := newXEstimate(X,survivalRate);
       X := D;
     end while;
     X_final := X;
  end CHMORAux_NewtonRaphson;

  function newXEstimate
    input  Real X;
    input  Real X_factor;
    output Real D;
  protected
  // Auxs
    Real A;
    Real B;
    Real C;
  algorithm
    A := exp(-X);
    B := 1 - A - X * X_factor;
    C := A * (X + 1) - 1;
    assert(not C==0, "Error inside 'newXEstimate'. C shouldn't be 0. C = "+String(C)+ ", A= "+String(A)+ ", X= "+String(X));
    D := X * (1 - B / C);
  end newXEstimate;
end Demography;
