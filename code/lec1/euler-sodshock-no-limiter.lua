-- Gkyl ------------------------------------------------------------------------
local Moments = require("App.PlasmaOnCartGrid").Moments()
local Euler = require "Eq.Euler"

gasGamma = 1.4 -- gas adiabatic constant
   
-- create app
eulerApp = Moments.App {
   logToFile = true,

   tEnd = 0.4, -- end time
   nFrame = 1, -- number of output frame
   lower = {-1.0}, -- lower left corner
   upper = {1.0}, -- upper right corner
   cells = {100}, -- number of cells
   cflFrac = 0.95, -- CFL fraction
   timeStepper = "fvDimSplit",
   
   -- decomposition stuff
   decompCuts = {1}, -- cuts in each direction
   useShared = false, -- if to use shared memory

   -- electrons
   fluid = Moments.Species {
      charge = 0.0, mass = 1.0,

      equation = Euler { gasGamma = gasGamma },
      -- initial conditions
      init = function (t, xn)
	 local xs = 0.0
	 local rhol, ul, pl = 1.0, 0.0, 1.0
	 local rhor, ur, pr = 0.125, 0.0, 0.1

	 local rho, u, press = rhor, ur, pr
	 if xn[1]<xs then
	    rho, u, press = rhol, ul, pl
	 end
	 return rho, rho*u, 0.0, 0.0, press/(gasGamma-1) + 0.5*rho*u*u
      end,
      limiter = "no-limiter",
      evolve = true, -- evolve species?

      bcx = { Moments.Species.bcCopy, Moments.Species.bcCopy }, -- boundary conditions in X
   },   
}
-- run application
eulerApp:run()
