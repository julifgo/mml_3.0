within LAWM.Regions.StandardAsia;
package Asia

  block AsiaRegion
    extends LAWM.Regions.Base.Region;
    RegionInitsAsia inits(number_of_sectors=number_of_sectors);
    RegionParametersAsia params(number_of_sectors=number_of_sectors);
  end AsiaRegion;

  record RegionInitsAsia
    extends LAWM.Regions.Base.RegionInits(
    capProportionPerSectorProjection_init = {0.20000000E+00, 0.34999999E+00, 0.20000000E-01, 0.37000000E+00, 0.59999999E-01},
    gnpPerCapita_init                     = 0.89722771E+02,
    laborForceProportionsPerSector_init   = {0.32200000E+00, 0.99999997E-04, 0.20000001E-02, 0.94899997E-01, 0.14000000E-01},
    gnpProportionsPerSector_init          = {0.27200001E+00, 0.48999999E-01, 0.22000000E-01, 0.49700001E+00, 0.16000000E+00},
    totalGNP_init                         = 0.13852900E+12,
    populationByAge_males_init            = {0.24703836E+08 , 0.23880136E+08 , 0.23108166E+08 , 0.22385538E+08 , 0.21709864E+08 , 0.21077964E+08 , 0.20489834E+08 , 0.20099074E+08 , 0.19428176E+08 , 0.18949874E+08 , 0.18438940E+08 , 0.18052160E+08 , 0.17698008E+08 , 0.17370120E+08 , 0.17056558E+08 , 0.16875900E+08 , 0.16505832E+08 , 0.16110297E+08 , 0.15690091E+08 , 0.15251580E+08 , 0.14832170E+08 , 0.14352275E+08 , 0.13864422E+08 , 0.13375773E+08 , 0.12893490E+08 , 0.12302177E+08 , 0.11913009E+08 , 0.11570000E+08 , 0.11265987E+08 , 0.10996991E+08 , 0.10774950E+08 , 0.10545747E+08 , 0.10332460E+08 , 0.10130315E+08 , 0.99353330E+07 , 0.97801430E+07 , 0.95740190E+07 , 0.93615290E+07 , 0.91434670E+07 , 0.89190390E+07 , 0.86938140E+07 , 0.84574480E+07 , 0.82171030E+07 , 0.79719825E+07 , 0.77252705E+07 , 0.74761710E+07 , 0.72270715E+07 , 0.69771760E+07 , 0.67280765E+07 , 0.64821605E+07 , 0.62298775E+07 , 0.59966945E+07 , 0.57682870E+07 , 0.55454505E+07 , 0.53297760E+07 , 0.50878390E+07 , 0.48976320E+07 , 0.47185670E+07 , 0.45442770E+07 , 0.43723745E+07 , 0.41980840E+07 , 0.40237940E+07 , 0.38399538E+07 , 0.36441758E+07 , 0.34348685E+07 , 0.32064608E+07 , 0.29581570E+07 , 0.26835905E+07 , 0.23811692E+07 , 0.19030254E+08},
    populationByAge_females_init          = {0.23738474E+08 , 0.22960138E+08 , 0.22222390E+08 , 0.21524432E+08 , 0.20865474E+08 , 0.20243918E+08 , 0.19658176E+08 , 0.19109042E+08 , 0.18594130E+08 , 0.18112644E+08 , 0.17564306E+08 , 0.17191056E+08 , 0.16859984E+08 , 0.16558358E+08 , 0.16274241E+08 , 0.16171577E+08 , 0.15808672E+08 , 0.15407566E+08 , 0.14975422E+08 , 0.14519402E+08 , 0.14043487E+08 , 0.13565184E+08 , 0.13085289E+08 , 0.12612557E+08 , 0.12151762E+08 , 0.11578754E+08 , 0.11225398E+08 , 0.10920590E+08 , 0.10656369E+08 , 0.10424778E+08 , 0.10278343E+08 , 0.10061873E+08 , 0.98485860E+07 , 0.96360950E+07 , 0.94236050E+07 , 0.92365810E+07 , 0.90089690E+07 , 0.87741950E+07 , 0.85338500E+07 , 0.82911165E+07 , 0.80340585E+07 , 0.77953050E+07 , 0.75613265E+07 , 0.73305315E+07 , 0.71029195E+07 , 0.68800830E+07 , 0.66620215E+07 , 0.64479390E+07 , 0.62394275E+07 , 0.60364870E+07 , 0.58287710E+07 , 0.56401560E+07 , 0.54594990E+07 , 0.52836170E+07 , 0.51141020E+07 , 0.49310575E+07 , 0.47758680E+07 , 0.46294325E+07 , 0.44845885E+07 , 0.43389490E+07 , 0.41909215E+07 , 0.40365275E+07 , 0.38709918E+07 , 0.36696428E+07 , 0.35033112E+07 , 0.32932080E+07 , 0.30616170E+07 , 0.28061508E+07 , 0.25236255E+07 , 0.22125296E+08},
    laborForceProportion_init             = 0.43300000E+00,
    housesPerCapitaPercentage_init        = 0.74350142E+01,
    gnpPerSector_init                     = {0.37679890E+11, 0.67879209E+10, 0.30476380E+10, 0.68848910E+11, 0.22164640E+11},
    totalPopulation_init                  = 0.15439670E+10,
    crudeBirthRate_init                   = 0.43900597E+02,
    capDistributionPerSector_init         = {0.99740877E+11, 0.17454653E+12, 0.99740877E+10, 0.18452062E+12, 0.29922263E+11},
    totalCapital_init                     = 0.49870438E+12,
    lifeExpectancy_init                   = 0.48242577E+02,
    urbanPopulationPercentage_init        = 0.17580000E+02,
    crudeDeathRate_init                   = 0.17299999E+02,
    childMortality_init                   = 0.14800000E+03,
    caloriesPerDayPerPerson_init          = 0.19848400E+04,
    secondaryLaborForcePercentage_init    = 0.55956235E+01,
    enrolmentPercentage_init              = 0.32320000E+02,
    costFirstThreeSectors_init            = {0.33686298e-04, 0.59131233e+02, 0.22219410e+02},
    caloriesProduced_init                 = 0.11185525E+16,
    proteinsPerDayPerPerson_init          = 0.51139999E+02,
    exceedingCaloriesPerDayPerPerson_init = 0,
    matriculationPercentage_init          = 0.88836794E+01,
    availableEducationSlots_init          = 0.13716107E+09,
    peoplePerFamily_init                  = 0.48906178E+01,
    urbanPopulation_init                  = 0.27142938E+09,
    agePyramid_init                       = {0.26842032E+09, 0.42438451E+09, 0.11211059E+10},
    houses_init                           = 0.11479417E+09,
    housesPerFamily_init                  = 0.36361814E+00
    );
  end RegionInitsAsia;

  record RegionParametersAsia
    extends LAWM.Regions.Base.RegionParameters(
      cultivatedArableLand1960                       = 0.4153,
      avgSalaryPerSector                             = {0.54789093E+02, 0.35511174E-17, 0.86513324E+03, 0.31413409E+03, 0.95128668E+03},
      gammaPerSector                                 = {1.01, 1.01, 1.005, 1.01, 1.015},
      regressionPhaseYears                           = 11,
      alfa1_perSector                                = { 0.75       , 0.06        , 0.9        , 0.71       , 0.8       },
      alfa2_perSector                                = { 0.59261094 , 0.053853922 , 0.92789418 , 0.59588381 , 0.70495253},
      FRS4SE                                         = 0.44211,
      laborForceVariationInProjectivePhase           = -0.0005575,
      foodSectorLaborForceVariationInProjectivePhase = 0.0045,
      capitalDeteriorationRatioPerSector             = {0.55000003E-01, 0.13200001E-01, 0.13200001E-01, 0.36666669E-01, 0.50769232E-01},
      tradeBalanceFoodSector                         = -0.16407470E+08,
      tradeBalanceOtherGoodsSector                   = -0.87177938E+06,
      tradeBalanceCapitalSector                      = -0.27340819E+09,
      capProportionPerSectorProjection_init          = {0.20    ,   0.35   ,  0.02    ,  0.37    ,  0.06},
      maxEnrolmentPercentage                         = 98,
      maxMatriculationPercentage                     = 98,
      maxCaloriesPerDayPerPerson                     = 3000,
      proteinsPerCalorie                             = 2.5765302E-02,
      tech_progr_year_start                          = 1970.9, // (it should start at year 1971 but in Modelica we have to put something smaller) This year is hardcoded in the Fortran code as "KOUNT > 11". It's the starting year to take into account the technological progress when calculating GNP
      maxPopDensityPerHa                             = 150000,
      maxHousesPerCapitaPercentage                   = 25,
      maleNewbornProbability                         = 0.5122
    );
  end RegionParametersAsia;

end Asia;
