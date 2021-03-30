local Basis = require "Basis"
local DataStruct = require "DataStruct"
local Grid = require "Grid"
local Updater = require "Updater"

-- Select resolution
local cells = {12}
local lower = {-6.0}
local upper = {6.0}

-- Select initial conditions
-- 1: Sin function
-- 2: Gaussian
-- 3: Step function
local initFn = 1

-- Select scheme:
-- 1: Naive (no conection between cells)
-- 2: Central flux
-- 3: Upwinding flux
-- 4: 1-cell recovery (no integration by parts)
-- 5: 2-cell recovery (standard recovery DG with IBP)
-- 6: Biased 3-cell recovery
local schemeId = 2

local polyOrder = 1
local cflFrac = 0.9
local cfl = cflFrac*0.5/(2*polyOrder+1)
local tEnd = 12
local a = 1.0
local nFrames = 20 
local periodicDirs = {1, 2}


----------------------
-- Grids and Fields --
----------------------
local grid = Grid.RectCart {
   lower = {lower[1]},
   upper = {upper[1]},
   cells = {cells[1]},
   periodicDirs = periodicDirs,
}

-- basis functions
local basis = Basis.CartModalSerendipity {
   ndim = grid:ndim(),
   polyOrder = polyOrder
}

-- fields
local function getField()
   return DataStruct.Field {
      onGrid = grid,
      numComponents = basis:numBasis(),
      ghost = {2, 2},
      metaData = {
	 polyOrder = basis:polyOrder(),
	 basisType = basis:id(),
      },
   }
end
local f = getField()
local f1 = getField()
local f2 = getField()
local fe = getField()
local fNew = getField()

--------------------
-- Initialization --
--------------------
local projectUpd = Updater.ProjectOnBasis {
   onGrid = grid,
   basis = basis,
      evaluate = function(t, xn) return 0. end,
      onGhosts = false,
}
local initFnSin = function (t, z)
   return math.sin(2*math.pi/(upper[1]-lower[1]) * z[1])
end
local initFnGauss = function (t, z)
   return 1/math.sqrt(2*math.pi)*math.exp(-z[1]^2/2)
end
local initFnStep  = function (t, z)
   if math.abs(z[1]) < 2 then
      return 1.0
   else
      return 0.0
   end
end

if initFn == 1 then
   projectUpd:setFunc(initFnSin)
elseif initFn == 2 then
   projectUpd:setFunc(initFnGauss)
elseif initFn == 3 then
   projectUpd:setFunc(initFnStep)
end
projectUpd:advance(0.0, {}, {f})
f:sync()
f:write("f_0.bp", 0, 0)

local function forwardEuler(dt, fIn, fOut)
   local dv = grid:dx(1)
   local localRange = fIn:localRange()
   local indexer = fIn:genIndexer()
   local idxsLL, idxsL, idxsR = {}, {}, {}

   for idxs in localRange:colMajorIter() do
      idxsLL[1] = idxs[1]-2
      idxsL[1] = idxs[1]-1
      idxsR[1] = idxs[1]+1

      local fC = fIn:get(indexer(idxs))
      local fLL = fIn:get(indexer(idxsLL))
      local fL = fIn:get(indexer(idxsL))
      local fR = fIn:get(indexer(idxsR))
      local fO = fOut:get(indexer(idxs))

      if schemeId == 1 then  -- Naive
         fO[1] = fC[1] + -(3.464101615137754*fC[2]*a*dt)/dv
         fO[2] = fC[2] + 0.0
      elseif schemeId == 2 then  -- Central
         fO[1] = fC[1] + (0.5*(1.732050807568877*fR[2]+1.732050807568877*fL[2]-3.464101615137754*fC[2]-1.0*fR[1]+fL[1])*a*dt)/dv
         fO[2] = fC[2] + (0.5*(3.0*fR[2]-3.0*fL[2]-1.732050807568877*fR[1]-1.732050807568877*fL[1]+3.464101615137754*fC[1])*a*dt)/dv
      elseif schemeId == 3 then  -- Upwinding
         fO[1] = fC[1] + (1.732050807568877*fL[2]-1.732050807568877*fC[2]+fL[1]-1.0*fC[1])*a*dt/dv
         fO[2] = fC[2] + -(3.0*fL[2]+3.0*fC[2]+1.732050807568877*fL[1]-1.732050807568877*fC[1])*a*dt/dv
      elseif schemeId == 4 then  -- Recovery 1-cell ("volume" update)
         fO[1] = fC[1] + (0.1666666666666667*(3.464101615137754*fR[2]+3.464101615137754*fL[2]-6.928203230275509*fC[2]-3.0*fR[1]+3.0*fL[1])*a*dt)/dv
         fO[2] = fC[2] + (0.2886751345948129*(3.464101615137754*fR[2]-3.464101615137754*fL[2]-3.0*fR[1]-3.0*fL[1]+6.0*fC[1])*a*dt)/dv
      elseif schemeId == 5 then  -- Recovery 2-cell (volume + surface updates)
         fO[1] = fC[1] + dt*((0.5773502691896258*fR[2]*a)/dv+(0.5773502691896258*fL[2]*a)/dv-(1.154700538379252*fC[2]*a)/dv-(0.5*fR[1]*a)/dv+(0.5*fL[1]*a)/dv)
         fO[2] = fC[2] + dt*((fR[2]*a)/dv-(1.0*fL[2]*a)/dv-(0.8660254037844386*fR[1]*a)/dv-(0.8660254037844386*fL[1]*a)/dv+(1.732050807568877*fC[1]*a)/dv)
      elseif schemeId == 6 then  -- Recovery 3-cell (volume + surface updates)
         fO[1] = fC[1] + dt*((0.2993668062464727*fR[2]*a)/dv+(0.1336458956457467*fLL[2]*a)/dv+(1.15470053837925*fL[2]*a)/dv-(1.587713240271471*fC[2]*a)/dv-(0.2962962962962963*fR[1]*a)/dv+(0.1203703703703704*fLL[1]*a)/dv+(0.462962962962963*fL[1]*a)/dv-(0.287037037037037*fC[1]*a)/dv)
         fO[2] = fC[2] + dt*((0.5185185185185185*fR[2]*a)/dv-(0.2314814814814815*fLL[2]*a)/dv-(2.462962962962963*fL[2]*a)/dv-(1.712962962962963*fC[2]*a)/dv-(0.5132002392796675*fR[1]*a)/dv-(0.2084875972073649*fLL[1]*a)/dv-(1.21885056828921*fL[1]*a)/dv+(1.940538404776242*fC[1]*a)/dv)
      end
   end
end

local function rk3(dt, fIn, fOut)
   -- Stage 1
   forwardEuler(dt, fIn, f1)
   f1:sync()

   -- Stage 2
   forwardEuler(dt, f1, fe)
   f2:combine(3.0/4.0, fIn, 1.0/4.0, fe)
   f2:sync()

   -- Stage 3
   forwardEuler(dt, f2, fe)
   fOut:combine(1.0/3.0, fIn, 2.0/3.0, fe)
   fOut:sync()
end

-- run simulation with RK3
local main = function ()
   local tCurr = 0.0
   local step = 1
   local dt = cfl*grid:dx(1)

   local frameInt = tEnd/nFrames
   local nextFrame = 1
   local isDone = false

   while not isDone do
      if (tCurr+dt >= tEnd) then
	 isDone = true
	 dt = tEnd-tCurr
      end
      print(string.format("Step %d at time %g with dt %g ...", step, tCurr, dt))
      rk3(dt, f, fNew)
      f:copy(fNew)

      tCurr = tCurr+dt
      if tCurr >= nextFrame*frameInt or math.abs(tCurr-nextFrame*frameInt) < 1e-10 then
	 f:write(string.format("f_%d.bp", nextFrame), tCurr, nextFrame)
	 nextFrame = nextFrame+1
      end
      step = step+1
   end
end

main()
