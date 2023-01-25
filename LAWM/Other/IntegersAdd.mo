within LAWM.Other;
model IntegersAdd
  // Inputs
  discrete LAWM.Utilities.Interfaces.IntegerInput u1 annotation( Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  discrete LAWM.Utilities.Interfaces.IntegerInput u2 annotation( Placement(visible = true, transformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  // Outputs
  discrete LAWM.Utilities.Interfaces.IntegerOutput y annotation( Placement(visible = true, transformation(origin = {33, 29}, extent = {{-23, -23}, {23, 23}}, rotation = 0), iconTransformation(origin = {33, 29}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  parameter Integer k1;
  parameter Integer k2;
  annotation( uses(Modelica(version = "3.2.2")), Diagram(graphics = {Rectangle(origin = {-25, 29}, extent = {{-35, 51}, {35, -51}})}));
equation
  y = k1*u1+k2*u2;
end IntegersAdd;
