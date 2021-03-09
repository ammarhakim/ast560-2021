-- Gkyl ------------------------------------------------------------------------
local Moments = require ("App.PlasmaOnCartGrid").Moments()
local Burgers = require "Eq.Burgers"

-- create app
burgersApp = Moments.App {
   logToFile = true,

   tEnd = 0.5, -- end time
   nFrame = 10, -- number of output frame
   lower = {0.0}, -- lower left corner
   upper = {1.0}, -- upper right corner
   cells = {512}, -- number of cells
   cfl = 0.9, -- CFL number
   timeStepper = "fvDimSplit",
   periodicDirs = { },
   
   fluid = Moments.Species {
      charge = 0.0, mass = 1.0,

      equation = Burgers { },
      -- initial conditions
      init = function (t, xn)
	 local x, xc = xn[1], 0.25
	 local u = 0.5
	 if x > xc then
	    u = 1.0
	 end
	 return u
      end,
      evolve = true, -- evolve species?

      bcx = { Moments.Species.bcCopy, Moments.Species.bcCopy }, -- boundary conditions in X
   },
}
-- run appication
burgersApp:run()
