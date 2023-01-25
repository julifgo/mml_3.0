within LAWM.Economy.GNP;
block GNPPerCapita
    // Input vars:
    discrete LAWM.Utilities.Interfaces.RealInput totalGNP annotation( Placement(visible = true, transformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation annotation( Placement(visible = true, transformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Output vars
    discrete LAWM.Utilities.Interfaces.RealOutput gnpPerCapita annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

 equation
    gnpPerCapita = totalGNP / totalPopulation;
end GNPPerCapita;
