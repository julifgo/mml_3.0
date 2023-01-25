within LAWM.Regions.StandardDeveloped;
package Developed

  block DevelopedRegion
    extends LAWM.Regions.Base.Region;
    RegionInitsDeveloped inits(number_of_sectors=number_of_sectors);
    RegionParametersDeveloped params(number_of_sectors=number_of_sectors);
  end DevelopedRegion;

  record RegionInitsDeveloped
    extends LAWM.Regions.Base.RegionInits(
    capProportionPerSectorProjection_init = {0.59999999E-01, 0.28000000E+00, 0.29999999E-01, 0.44000000E+00, 0.19000000E+00},
    gnpPerCapita_init                     = 0.14017849E+04,
    laborForceProportionsPerSector_init   = { 0.12400000E+00, 0.99999997E-04, 0.60000001E-02, 0.24590001E+00, 0.70000000E-01},
    gnpProportionsPerSector_init          = {0.1670e+00, 0.8800E-01, 0.3400E-01, 0.4950e+00, 0.2160e+00},
    totalGNP_init                         = 0.13269156E+13,
    populationByAge_males_init            = {0.76406270E+07 , 0.78861740E+07 , 0.81084205E+07 , 0.83055750E+07 , 0.84785330E+07 , 0.86263990E+07 , 0.87500680E+07 , 0.88486460E+07 , 0.89194420E+07 , 0.89669380E+07 , 0.90153310E+07 , 0.89956150E+07 , 0.89436380E+07 , 0.88665690E+07 , 0.87635110E+07 , 0.85959300E+07 , 0.84740520E+07 , 0.83414210E+07 , 0.81980365E+07 , 0.80403130E+07 , 0.80734705E+07 , 0.77893890E+07 , 0.74622920E+07 , 0.71127910E+07 , 0.67632905E+07 , 0.60015575E+07 , 0.59038765E+07 , 0.59182150E+07 , 0.60150000E+07 , 0.61682425E+07 , 0.67444710E+07 , 0.67543285E+07 , 0.66969745E+07 , 0.65867475E+07 , 0.64424665E+07 , 0.59836345E+07 , 0.59522690E+07 , 0.59692960E+07 , 0.60185845E+07 , 0.60831080E+07 , 0.63689815E+07 , 0.63223815E+07 , 0.62211160E+07 , 0.60696655E+07 , 0.58769920E+07 , 0.57237490E+07 , 0.54450445E+07 , 0.51394555E+07 , 0.48258005E+07 , 0.45184190E+07 , 0.39045522E+07 , 0.38032865E+07 , 0.37934290E+07 , 0.38516790E+07 , 0.39574255E+07 , 0.43176800E+07 , 0.43553190E+07 , 0.43526305E+07 , 0.43149920E+07 , 0.42415070E+07 , 0.41438260E+07 , 0.40210525E+07 , 0.38776675E+07 , 0.37181518E+07 , 0.35478820E+07 , 0.33686510E+07 , 0.31867312E+07 , 0.30057078E+07 , 0.28291650E+07 , 0.24432800E+08},
    populationByAge_females_init          = {0.73198035E+07 , 0.75528040E+07 , 0.77651930E+07 , 0.79551780E+07 , 0.81227590E+07 , 0.82688325E+07 , 0.83880215E+07 , 0.84865990E+07 , 0.85600830E+07 , 0.86093720E+07 , 0.86685180E+07 , 0.86505950E+07 , 0.86030990E+07 , 0.85287180E+07 , 0.84301410E+07 , 0.82607670E+07 , 0.81523325E+07 , 0.80358320E+07 , 0.79112665E+07 , 0.77750505E+07 , 0.78306120E+07 , 0.75716230E+07 , 0.72714110E+07 , 0.69514830E+07 , 0.66288670E+07 , 0.59011880E+07 , 0.58285995E+07 , 0.58635495E+07 , 0.59791535E+07 , 0.61503195E+07 , 0.67677710E+07 , 0.67785250E+07 , 0.67175865E+07 , 0.66010860E+07 , 0.64550125E+07 , 0.59522690E+07 , 0.59486845E+07 , 0.60114155E+07 , 0.61207465E+07 , 0.62578580E+07 , 0.65759935E+07 , 0.66441015E+07 , 0.66682975E+07 , 0.66512710E+07 , 0.65912285E+07 , 0.67202750E+07 , 0.64783125E+07 , 0.61718275E+07 , 0.58277035E+07 , 0.54710330E+07 , 0.46322310E+07 , 0.45488885E+07 , 0.45847350E+07 , 0.47119890E+07 , 0.49028700E+07 , 0.54629680E+07 , 0.55436220E+07 , 0.55624410E+07 , 0.55283870E+07 , 0.54486295E+07 , 0.53348175E+07 , 0.51914325E+07 , 0.50274360E+07 , 0.48544775E+07 , 0.46761425E+07 , 0.45058730E+07 , 0.43463570E+07 , 0.42101415E+07 , 0.41043950E+07 , 0.41238416E+08},
    laborForceProportion_init                  = 0.44600001E+00,
    housesPerCapitaPercentage_init        = 0.17365164E+02,
    gnpPerSector_init                     = {0.22159491E+12, 0.11676858E+12, 0.45115134E+11, 0.65682322E+12, 0.28661380E+12},
    totalPopulation_init                  = 0.94659002E+09,
    crudeBirthRate_init                   = 0.22190907E+02,
    capDistributionPerSector_init         = {0.19203121E+12, 0.89614569E+12, 0.96015606E+11, 0.14082289E+13, 0.60809884E+12},
    totalCapital_init                     = 0.32005203E+13,
    lifeExpectancy_init                   = 0.69437271E+02,
    urbanPopulationPercentage_init        = 0.59139999E+02,
    crudeDeathRate_init                   = 0.14000000E+02,
    childMortality_init                   = 0.26600000E+02,
    caloriesPerDayPerPerson_init          = 0.29804700E+04,
    secondaryLaborForcePercentage_init    = 0.15596418E+02,
    enrolmentPercentage_init              = 0.84820000E+02,
    costFirstThreeSectors_init            = {0.21518909E-03, 0.71037091E+03, 0.25713278E+03},
    caloriesProduced_init                 = 0.10297683E+16,
    proteinsPerDayPerPerson_init          = 0.98653557E+02,
    exceedingCaloriesPerDayPerPerson_init = 0,
    matriculationPercentage_init          = 0.18535439E+02,
    availableEducationSlots_init          = 0.17545461E+09,
    peoplePerFamily_init                  = 0.38250315E+01,
    urbanPopulation_init                  = 0.55981331E+09,
    agePyramid_init                       = {0.96030304E+08, 0.20685523E+09, 0.78103053E+09},
    houses_init                           = 0.16437691E+09,
    housesPerFamily_init                  = 0.66422302E+00
    );
  end RegionInitsDeveloped;

  record RegionParametersDeveloped
    extends LAWM.Regions.Base.RegionParameters(
      cultivatedArableLand1960                       = 0.6144,
      avgSalaryPerSector                             = {0.20769897E+04, 0.13356529E-01, 0.69522163E+04, 0.17681520E+04, 0.26197070E+04},
      gammaPerSector                                 = {1.01, 1.01, 1.005, 1.01, 1.015},
      regressionPhaseYears                           = 11,
      alfa1_perSector                                = { 0.60       , 0.10        , 0.85       , 0.62       , 0.60      },
      alfa2_perSector                                = { 0.58031798 , 0.10004643  , 0.90891399 , 0.41183146 , 0.55655936},
      FRS4SE                                         = 0.34959,
      laborForceVariationInProjectivePhase           = 0.00005,
      foodSectorLaborForceVariationInProjectivePhase = 0.00305,
      capitalDeteriorationRatioPerSector             = {0.66000000E-01, 0.13200001E-01, 0.16500000E-01, 0.44000003E-01, 0.66000000E-01},
      tradeBalanceFoodSector                         = -0.33934300E+07,
      tradeBalanceOtherGoodsSector                   = 0.22193348E+07,
      tradeBalanceCapitalSector                      = 0.27689338E+08,
      capProportionPerSectorProjection_init          = {0.06    ,   0.28   ,  0.03    ,  0.44    ,  0.19},
      maxEnrolmentPercentage                         = 98,
      maxMatriculationPercentage                     = 98,
      maxCaloriesPerDayPerPerson                     = 3200,
      proteinsPerCalorie                             = 0.0331,
      tech_progr_year_start                          = 1970.9, // (it should start at year 1971 but in Modelica we have to put something smaller) This year is hardcoded in the Fortran code as "KOUNT > 11". It's the starting year to take into account the technological progress when calculating GNP
      maxPopDensityPerHa                             = 150000,
      maxHousesPerCapitaPercentage                   = 25,
      maleNewbornProbability                         = 0.5122
    );
  end RegionParametersDeveloped;
end Developed;

