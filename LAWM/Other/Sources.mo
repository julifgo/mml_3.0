within LAWM.Other;
package Sources

model DiscreteTimeSource
  // Parameters
  parameter Integer startTime;
  // Outputs
  discrete LAWM.Utilities.Interfaces.IntegerOutput discreteTime annotation( Placement(visible = true, transformation(origin = {56, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {56, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  discreteTime = startTime;
equation
  when sample(startTime,1) then
    discreteTime = integer(time);
  end when;
end DiscreteTimeSource;

end Sources;
