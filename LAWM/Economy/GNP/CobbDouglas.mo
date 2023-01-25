within LAWM.Economy.GNP;
block CobbDouglas
    // Input vars:
    discrete LAWM.Utilities.Interfaces.RealInput salaries annotation( Placement(visible = true, transformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput capital annotation( Placement(visible = true, transformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput alfa annotation( Placement(visible = true, transformation(origin = {-62, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-62, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

    // Output vars
    discrete LAWM.Utilities.Interfaces.RealOutput production annotation( Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

 equation
    production = (salaries^alfa) * (capital^(1-alfa)); // Cobb Douglas
end CobbDouglas;
