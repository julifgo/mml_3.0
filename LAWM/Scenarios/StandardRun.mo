within LAWM.Scenarios;

model StandardRun
  LAWM.Regions.Standard.Developed.DevelopedRegion developed;
  LAWM.Regions.Standard.LatinAmerica.LatinAmericaRegion latin_america;
  LAWM.Regions.Standard.Africa.AfricaRegion africa;
  LAWM.Regions.Standard.Asia.AsiaRegion asia;
  annotation(
    experiment(StartTime = 1960, StopTime = 1999, Tolerance = 0.001, Interval = 1));
end StandardRun;
