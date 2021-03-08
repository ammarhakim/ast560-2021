-- Input file for exacteulerrp Tool

lower = -1.0 -- left-edge of domain
upper = 1.0 -- right-edge of domain
location = 0.0 -- location of shock
ncell = 100 -- Number of cells to use
tEnd = 0.4 -- Time at which to compute RP
gasGamma = 1.4 -- Gas adiabatic index

-- left/right states { density, velocity, pressure }
leftState = { 1.0, 0.0, 1.0 }
rightState = { 0.125, 0.0, 0.1 }

