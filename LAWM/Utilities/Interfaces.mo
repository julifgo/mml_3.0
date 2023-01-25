within LAWM.Utilities;
package Interfaces
// Real connectors
   connector RealOutput = output Real "'output Real' as connector" annotation (
     defaultComponentName="y",
     Icon(
       coordinateSystem(preserveAspectRatio=true,
         extent={{-100.0,-100.0},{100.0,100.0}}),
         graphics={
       Polygon(
         lineColor={0,0,127},
         fillColor={255,255,255},
         fillPattern=FillPattern.Solid,
         points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
     Diagram(
       coordinateSystem(initialScale = 0.1),
         graphics={Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(origin = {22, -22}, lineColor = {0, 0, 127}, extent = {{0, 0}, {0, 50}}, textString = "%name", horizontalAlignment = TextAlignment.Left)}),
     Documentation(info="<html>
   <p>
   Connector with one output signal of type Real.
   </p>
   </html>"));

  connector RealInput = input Real "'input Real' as connector" annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(initialScale = 0.2),
        graphics={Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(origin = {-12, -70}, lineColor = {0, 0, 127}, extent = {{-10, 60}, {-10, 85}}, textString = "%name", horizontalAlignment = TextAlignment.Right)}),
    Documentation(info="<html>
  <p>
  Connector with one input signal of type Real.
  </p>
  </html>"));

// Integer connectors
  connector IntegerInput = input Integer "'input Integer' as connector"
    annotation (
    defaultComponentName="u",
    Icon(graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        initialScale = 0.2), graphics={Polygon(lineColor = {255, 127, 0}, fillColor = {255, 127, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(origin = {-12, -70}, lineColor = {255, 127, 0}, extent = {{-10, 85}, {-10, 60}}, textString = "%name", horizontalAlignment = TextAlignment.Right)}),
    Documentation(info="<html>
  <p>
  Connector with one input signal of type Integer.
  </p>
  </html>"));

  connector IntegerOutput = output Integer "'output Integer' as connector"
    annotation (
    defaultComponentName="y",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        initialScale = 0.1), graphics={Polygon(lineColor = {255, 127, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(origin = {-8, -82},lineColor = {255, 127, 0}, extent = {{30, 110}, {30, 60}}, textString = "%name", horizontalAlignment = TextAlignment.Left)}),
    Documentation(info="<html>
  <p>
  Connector with one output signal of type Integer.
  </p>
  </html>"));

end Interfaces;