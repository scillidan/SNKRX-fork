local path = ...
if not path:find("init") then
  binser = require(path .. ".binser")
  mlib = require(path .. ".mlib")
  -- if not web then clipper = require(path .. ".clipper") end
  ripple = require(path .. ".ripple")
  steam = {
    init = function() end,
    shutdown = function() end,
    runCallbacks = function() end,
    friends = {
      setRichPresence = function() end
    },
    userStats = {
      requestCurrentStats = function() end,
      setAchievement = function() end,
      storeStats = function() end,
      resetAllStats = function() end
    }
  }
end
