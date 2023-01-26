within LAWM.Regions.StandardAfrica;
package Africa

  block AfricaRegion
    extends LAWM.Regions.Base.Region(redeclare RegionInitsAfrica inits);
    extends LAWM.Regions.Base.Region(redeclare RegionParametersAfrica params);
  end AfricaRegion;

  record RegionInitsAfrica
    extends LAWM.Regions.Base.RegionInits(
    capProportionPerSectorProjection_init = {0.18000001E+00, 0.33000001E+00, 0.20000000E-01, 0.41999999E+00, 0.50000001E-01},
    gnpPerCapita_init                     = 0.13688628E+03,
    laborForceProportionsPerSector_init   = {0.29499999E+00, 0.99999997E-04, 0.20000001E-02, 0.80899999E-01, 0.89999996E-02},
    gnpProportionsPerSector_init          = {0.26400000E+00, 0.66000000E-01, 0.23000000E-01, 0.49599999E+00, 0.15099999E+00},
    totalGNP_init                         = 0.35180184E+11,
    populationByAge_males_init            = {0.48707890E+07 , 0.47034485E+07 , 0.45454475E+07 , 0.43897815E+07 , 0.42356720E+07 , 0.40838975E+07 , 0.39360150E+07 , 0.37889105E+07 , 0.36456978E+07 , 0.35063768E+07 , 0.33701690E+07 , 0.32378528E+07 , 0.31094285E+07 , 0.29856740E+07 , 0.28658110E+07 , 0.27506182E+07 , 0.26416520E+07 , 0.25373558E+07 , 0.24392862E+07 , 0.23482218E+07 , 0.22470388E+07 , 0.21746540E+07 , 0.21108310E+07 , 0.20524562E+07 , 0.20003081E+07 , 0.19707316E+07 , 0.19162485E+07 , 0.18602088E+07 , 0.18049472E+07 , 0.17481292E+07 , 0.16796361E+07 , 0.16306014E+07 , 0.15846799E+07 , 0.15426501E+07 , 0.15013986E+07 , 0.14772704E+07 , 0.14290139E+07 , 0.13784225E+07 , 0.13262744E+07 , 0.12741262E+07 , 0.12025199E+07 , 0.11604900E+07 , 0.11215735E+07 , 0.10873270E+07 , 0.10546371E+07 , 0.10390706E+07 , 0.10017108E+07 , 0.96201588E+06 , 0.92154275E+06 , 0.88029125E+06 , 0.83125644E+06 , 0.79156162E+06 , 0.75342344E+06 , 0.71762025E+06 , 0.68259544E+06 , 0.64912725E+06 , 0.61643738E+06 , 0.58452581E+06 , 0.55417100E+06 , 0.52459444E+06 , 0.49579622E+06 , 0.46777634E+06 , 0.44131312E+06 , 0.41484991E+06 , 0.38994334E+06 , 0.36425844E+06 , 0.34168688E+06 , 0.31833697E+06 , 0.29576541E+06 , 0.24050398E+07},
    populationByAge_females_init          = {0.48303160E+07 , 0.46785415E+07 , 0.45236540E+07 , 0.43672095E+07 , 0.42092085E+07 , 0.40519860E+07 , 0.38963200E+07 , 0.37429890E+07 , 0.35927712E+07 , 0.34456670E+07 , 0.32931142E+07 , 0.31615765E+07 , 0.30393788E+07 , 0.29241858E+07 , 0.28167762E+07 , 0.27140368E+07 , 0.26229722E+07 , 0.25373558E+07 , 0.24579662E+07 , 0.23848032E+07 , 0.23116402E+07 , 0.22517088E+07 , 0.21956690E+07 , 0.21435208E+07 , 0.20937078E+07 , 0.20649095E+07 , 0.20088698E+07 , 0.19497168E+07 , 0.19660616E+07 , 0.18251839E+07 , 0.17489075E+07 , 0.16936461E+07 , 0.16414980E+07 , 0.15924632E+07 , 0.15449851E+07 , 0.15122952E+07 , 0.14609255E+07 , 0.14087774E+07 , 0.13566292E+07 , 0.13013678E+07 , 0.12367664E+07 , 0.11908449E+07 , 0.11480368E+07 , 0.11083420E+07 , 0.10709821E+07 , 0.10421839E+07 , 0.10040458E+07 , 0.96668588E+06 , 0.92776938E+06 , 0.88885288E+06 , 0.84993638E+06 , 0.81179819E+06 , 0.77599500E+06 , 0.73863519E+06 , 0.70283200E+06 , 0.66391550E+06 , 0.63278231E+06 , 0.60476244E+06 , 0.57829919E+06 , 0.55183600E+06 , 0.52692944E+06 , 0.50280119E+06 , 0.47867297E+06 , 0.45376641E+06 , 0.42730319E+06 , 0.40083997E+06 , 0.37204175E+06 , 0.34168688E+06 , 0.30821869E+06 , 0.25591490E+07},
    laborForceProportion_init             = 0.38699999E+00,
    housesPerCapitaPercentage_init        = 0.76557946E+01,
    gnpPerSector_init                     = {0.92875684E+10, 0.23218921E+10, 0.80914419E+09, 0.17449372E+11, 0.53122074E+10},
    totalPopulation_init                  = 0.25700301E+09,
    crudeBirthRate_init                   = 0.46345051E+02,
    capDistributionPerSector_init         = {0.22163517E+11, 0.40633115E+11, 0.24626130E+10, 0.51714871E+11, 0.61565327E+10},
    totalCapital_init                     = 0.12313065E+12,
    lifeExpectancy_init                   = 0.43819736E+02,
    urbanPopulationPercentage_init        = 0.20940001E+02,
    crudeDeathRate_init                   = 0.20600000E+02,
    childMortality_init                   = 0.19600000E+03,
    caloriesPerDayPerPerson_init          = 0.22677900E+04,
    secondaryLaborForcePercentage_init    = 0.34968090E+01,
    enrolmentPercentage_init              = 0.23680000E+02,
    costFirstThreeSectors_init            = {0.43658427E-04, 0.11800858E+03, 0.44864403E+02},
    caloriesProduced_init                 = 0.21273255E+15,
    proteinsPerDayPerPerson_init          = 0.51209999E+02,
    exceedingCaloriesPerDayPerPerson_init = 0,
    matriculationPercentage_init          = 0.70175552E+01,
    availableEducationSlots_init          = 0.18035328E+08,
    peoplePerFamily_init                  = 0.45942907E+01,
    urbanPopulation_init                  = 0.53816428E+08,
    agePyramid_init                       = {0.53489952E+08, 0.76162704E+08, 0.17395829E+09},
    houses_init                           = 0.19675622E+08,
    housesPerFamily_init                  = 0.35172945E+00
    );
  end RegionInitsAfrica;

  record RegionParametersAfrica
    extends LAWM.Regions.Base.RegionParameters(
      cultivatedArableLand1960                       = 0.416,
      avgSalaryPerSector                             = {0.91670395E+02, 0.30313833E-14, 0.13910734E+04, 0.53848315E+03, 0.22134995E+04},
      gammaPerSector                                 = {1.01, 1.01, 1.005, 1.01, 1.015},
      regressionPhaseYears                           = 11,
      alfa1_perSector                                = { 0.75       , 0.06        , 0.9        , 0.71       , 0.8       },
      alfa2_perSector                                = { 0.57       , 0.049281012 , 0.73300882 , 0.40234387 , 0.90568067},
      FRS4SE                                         = 0.32099,
      laborForceVariationInProjectivePhase           = -0.001195,
      foodSectorLaborForceVariationInProjectivePhase = 0.0019014,
      capitalDeteriorationRatioPerSector             = {0.55000003E-01, 0.13200001E-01, 0.13200001E-01, 0.36666669E-01, 0.50769232E-01},
      tradeBalanceFoodSector                         = 0.49673378E+06,
      tradeBalanceOtherGoodsSector                   = -0.79179545E+07,
      tradeBalanceCapitalSector                      = -0.13191340E+09,
      capProportionPerSectorProjection_init          = {0.18    ,   0.33   ,  0.02    ,  0.42    ,  0.05},
      maxEnrolmentPercentage                         = 98,
      maxMatriculationPercentage                     = 98,
      maxCaloriesPerDayPerPerson                     = 3000,
      proteinsPerCalorie                             = 2.2581454E-02,
      tech_progr_year_start                          = 1970.9, // (it should start at year 1971 but in Modelica we have to put something smaller) This year is hardcoded in the Fortran code as "KOUNT > 11". It's the starting year to take into account the technological progress when calculating GNP
      maxPopDensityPerHa                             = 150000,
      maxHousesPerCapitaPercentage                   = 25,
      maleNewbornProbability                         = 0.5122
    );
  end RegionParametersAfrica;

end Africa;
