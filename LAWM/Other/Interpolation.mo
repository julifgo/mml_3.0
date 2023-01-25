within LAWM.Other;
package Interpolation
  function Piecewise "Piecewise linear function"
    input Real x "Independent variable";
    input Real x_grid[:] "Independent variable data points";
    input Real y_grid[:] "Dependent variable data points";
    output Real y "Interpolated result";
  protected
    Integer n;
  algorithm
    n:=size(x_grid, 1);
    // Adaptation to allow out of range values
    assert(size(x_grid, 1) == size(y_grid, 1), "Size mismatch");
    if x<x_grid[1] then
        y:=y_grid[1]; // Uses constant value for values outside of range
      //  y := y_grid[1] + (y_grid[2] - y_grid[1])  *((x - x_grid[1]) / (x_grid[2] - x_grid[1]));   // Extrapolates backwards using the first interval
    elseif x>x_grid[n] then
        y:=y_grid[n]; // Uses constant value for values outside of range
     //   y := y_grid[n] + (y_grid[n] - y_grid[n-1])*((x - x_grid[n]) / (x_grid[n] - x_grid[n-1])); // Extrapolates forward using the prev interval
    else
        for i in 1:n - 1 loop
          if x >= x_grid[i] and x <= x_grid[i + 1] then 
            y:=y_grid[i] + (y_grid[i + 1] - y_grid[i]) * (x - x_grid[i]) / (x_grid[i + 1] - x_grid[i]);
          else
          end if;
        end for;
    end if;
  end Piecewise;
end Interpolation;
