within LAWM.Regions.StandardLAM;
package LatinAmerica

block LatinAmericaRegion
  extends LAWM.Regions.Base.Region(redeclare RegionInitsLatinAmerica inits);
  extends LAWM.Regions.Base.Region(redeclare RegionParametersLatinAmerica params);
end LatinAmericaRegion;

  record RegionInitsLatinAmerica
    extends LAWM.Regions.Base.RegionInits(
    capProportionPerSectorProjection_init = {0.15000001E+00, 0.30000001E+00, 0.20000000E-01, 0.41000000E+00, 0.12000000E+00},
    gnpPerCapita_init                     = 0.37183728E+03,
    laborForceProportionsPerSector_init   = {0.15899999E+00, 0.99999997E-04, 0.40000002E-02, 0.13990000E+00, 0.26000001E-01},
    gnpProportionsPerSector_init          = {0.21200000E+00, 0.81000000E-01, 0.28999999E-01, 0.49599999E+00, 0.18200000E+00},
    totalGNP_init                         = 0.77509108E+11,
    populationByAge_males_init            = {0.36582260E+07 , 0.35492608E+07 , 0.34455558E+07 , 0.33456085E+07 , 0.32501700E+07 , 0.31569858E+07 , 0.30690622E+07 , 0.29826415E+07 , 0.28984752E+07 , 0.28173150E+07 , 0.29465702E+07 , 0.26572488E+07 , 0.25805972E+07 , 0.25039460E+07 , 0.24272945E+07 , 0.23694302E+07 , 0.22830095E+07 , 0.21928315E+07 , 0.21011502E+07 , 0.20087178E+07 , 0.18967465E+07 , 0.18170892E+07 , 0.17441952E+07 , 0.16780646E+07 , 0.16171944E+07 , 0.15645905E+07 , 0.15104836E+07 , 0.14601341E+07 , 0.14127906E+07 , 0.13692045E+07 , 0.13301274E+07 , 0.12887958E+07 , 0.12497185E+07 , 0.12121442E+07 , 0.11768245E+07 , 0.11377474E+07 , 0.11076880E+07 , 0.10806345E+07 , 0.10550840E+07 , 0.10310366E+07 , 0.10152554E+07 , 0.98895344E+06 , 0.96190000E+06 , 0.93484656E+06 , 0.90553869E+06 , 0.88073969E+06 , 0.84842588E+06 , 0.81460906E+06 , 0.78004075E+06 , 0.74472100E+06 , 0.69888050E+06 , 0.67182700E+06 , 0.64928250E+06 , 0.62748944E+06 , 0.60870238E+06 , 0.60344194E+06 , 0.58089744E+06 , 0.55534694E+06 , 0.52754200E+06 , 0.49973712E+06 , 0.47193219E+06 , 0.44337578E+06 , 0.41557088E+06 , 0.39077188E+06 , 0.36597288E+06 , 0.35019172E+06 , 0.33516203E+06 , 0.31787788E+06 , 0.29984225E+06 , 0.22439322E+07 },
    populationByAge_females_init          = {0.35154440E+07 , 0.34124905E+07 , 0.33140460E+07 , 0.32216135E+07 , 0.31314355E+07 , 0.30457662E+07 , 0.29646058E+07 , 0.28849485E+07 , 0.28090485E+07 , 0.27346518E+07 , 0.26580002E+07 , 0.25896152E+07 , 0.25227330E+07 , 0.24558510E+07 , 0.23912232E+07 , 0.23453828E+07 , 0.22672282E+07 , 0.21845650E+07 , 0.20981445E+07 , 0.20102208E+07 , 0.19050129E+07 , 0.18261070E+07 , 0.17524615E+07 , 0.16848280E+07 , 0.16217032E+07 , 0.15615845E+07 , 0.15074776E+07 , 0.14571282E+07 , 0.14090332E+07 , 0.13654471E+07 , 0.13271214E+07 , 0.12872928E+07 , 0.12489670E+07 , 0.12128958E+07 , 0.11783275E+07 , 0.11437592E+07 , 0.11144514E+07 , 0.10866464E+07 , 0.10603445E+07 , 0.10347940E+07 , 0.10145039E+07 , 0.98895344E+06 , 0.96340300E+06 , 0.93710100E+06 , 0.91079906E+06 , 0.89126050E+06 , 0.85969812E+06 , 0.82738431E+06 , 0.79356750E+06 , 0.75975069E+06 , 0.71315869E+06 , 0.68760819E+06 , 0.66581512E+06 , 0.64627656E+06 , 0.62899244E+06 , 0.61772012E+06 , 0.60494494E+06 , 0.58089744E+06 , 0.56211031E+06 , 0.52754200E+06 , 0.50048859E+06 , 0.47268369E+06 , 0.44638172E+06 , 0.42083125E+06 , 0.39678375E+06 , 0.37724516E+06 , 0.36071250E+06 , 0.34868875E+06 , 0.33516203E+06 , 0.27489298E+07 },
    laborForceProportion_init             = 0.32900000E+00,
    housesPerCapitaPercentage_init        = 0.83171062E+01,
    gnpPerSector_init                     = {0.16431930E+11, 0.62782377E+10, 0.22477640E+10, 0.38444515E+11, 0.14106658E+11},
    totalPopulation_init                  = 0.20844899E+09,
    crudeBirthRate_init                   = 0.37913315E+02,
    capDistributionPerSector_init         = {0.33885043E+11, 0.67770085E+11, 0.45180058E+10, 0.92619112E+11, 0.27108033E+11},
    totalCapital_init                     = 0.22590028E+12,
    lifeExpectancy_init                   = 0.55604649E+02,
    urbanPopulationPercentage_init        = 0.48599998E+02,
    crudeDeathRate_init                   = 0.14700000E+02,
    childMortality_init                   = 0.11500000E+03,
    caloriesPerDayPerPerson_init          = 0.24402400E+04,
    secondaryLaborForcePercentage_init    = 0.85305004E+01,
    enrolmentPercentage_init              = 0.48200001E+02,
    costFirstThreeSectors_init            = {0.88504101E-04, 0.36213101E+03, 0.74571289E+02},
    caloriesProduced_init                 = 0.18566293E+15,
    proteinsPerDayPerPerson_init          = 0.60299995E+02,
    exceedingCaloriesPerDayPerPerson_init = 0,
    matriculationPercentage_init          = 0.14460364E+02,
    availableEducationSlots_init          = 0.30142484E+08,
    peoplePerFamily_init                  = 0.46683092E+01,
    urbanPopulation_init                  = 0.10130621E+09,
    agePyramid_init                       = {0.40046604E+08, 0.62536276E+08, 0.14524165E+09},
    houses_init                           = 0.17336924E+08,
    housesPerFamily_init                  = 0.38826823E+00
    );
  end RegionInitsLatinAmerica;

  record RegionParametersLatinAmerica
    extends LAWM.Regions.Base.RegionParameters(
      cultivatedArableLand1960                       = 0.8163,
      avgSalaryPerSector                             = {0.38002536E+03, 0.56379542E-06, 0.24202200E+04, 0.74538226E+03, 0.12750272E+04},
      gammaPerSector                                 = {1.01, 1.01, 1.005, 1.01, 1.015},
      regressionPhaseYears                           = 11,
      alfa1_perSector                                = { 0.73131714 , 0.080965971 , 0.86619573 , 0.60661415 , 0.47788233},
      alfa2_perSector                                = { 0.55494173 , 0.071115419 , 0.67600076 , 0.37111348 , 0.48994921},
      FRS4SE                                         = 0.42391,
      laborForceVariationInProjectivePhase           = -0.00077,
      foodSectorLaborForceVariationInProjectivePhase = 0.002845,
      capitalDeteriorationRatioPerSector             = {0.60000002E-01, 0.13200001E-01, 0.13200001E-01, 0.38823530E-01, 0.55000003E-01},
      tradeBalanceFoodSector                         = 0.17301674E+08,
      tradeBalanceOtherGoodsSector                   = -0.69054910E+07,
      tradeBalanceCapitalSector                      = -0.47728860E+08,
      capProportionPerSectorProjection_init          = {0.15    ,   0.30   ,  0.02    ,  0.41    ,  0.12},
      maxEnrolmentPercentage                         = 98,
      maxMatriculationPercentage                     = 98,
      maxCaloriesPerDayPerPerson                     = 3000,
      proteinsPerCalorie                             = 2.4710683E-02,
      tech_progr_year_start                          = 1970.9, // (it should start at year 1971 but in Modelica we have to put something smaller) This year is hardcoded in the Fortran code as "KOUNT > 11". It's the starting year to take into account the technological progress when calculating GNP
      maxPopDensityPerHa                             = 150000,
      maxHousesPerCapitaPercentage                   = 25,
      maleNewbornProbability                         = 0.5122
    );
  end RegionParametersLatinAmerica;


end LatinAmerica;
