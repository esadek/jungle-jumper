local score = {}

function score:new()
  local obj = {
    currentScore = 0,
    highScore = 0,
    startTime = nil,
  }

  self.__index = self
  return setmetatable(obj, self)
end

function score:start()
  self.currentScore = 0
  self.startTime = love.timer.getTime()
end

function score:update()
  self.currentScore = math.floor((love.timer.getTime() - self.startTime) * 10)
  if self.currentScore > self.highScore then
    self.highScore = self.currentScore
  end
end

function score:draw()
  local margin = 20

  local x = love.graphics:getWidth() - Font:getWidth(self.currentScore) - margin
  love.graphics.print(self.currentScore, x, margin)

  if self.highScore > 0 then
    love.graphics.print("HI " .. self.highScore, margin, margin)
  end
end

return score
