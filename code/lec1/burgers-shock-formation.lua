-- Gkyl ------------------------------------------------------------------------
local Moments = require ("App.PlasmaOnCartGrid").Moments()
local Burgers = require "Eq.Burgers"

-- create app
burgersApp = Moments.App {
   logToFile = true,

   tEnd = 0.2, -- end time
   nFrame = 10, -- number of output frame
   lower = {0.0}, -- lower left corner
   upper = {1.0}, -- upper right corner
   cells = {1024}, -- number of cells
   cfl = 0.9, -- CFL number
   timeStepper = "fvDimSplit",
   periodicDirs = { 1 },
   
   fluid = Moments.Species {
      charge = 0.0, mass = 1.0,

      equation = Burgers { },
      -- initial conditions
      init = function (t, xn)
	 return 1.0+math.sin(2*math.pi*xn[1])
      end,
      evolve = true, -- evolve species?
   },
}
-- run appication
burgersApp:run()
