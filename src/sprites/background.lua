local background = {}

function background:new()
  local images = {}
  for i = 1, 5 do
    images[i] = love.graphics.newImage("assets/sprites/background/" .. i .. ".png")
  end

  local obj = {
    images = images,
    imageWidth = images[1]:getWidth(),
    scale = 2,
    xPositions = { 0, 0, 0, 0, 0 },
  }

  self.__index = self
  return setmetatable(obj, self)
end

function background:update(dt)
  for i = 2, #self.images do
    self.xPositions[i] = self.xPositions[i] - dt * 10 * i
    if math.abs(self.xPositions[i]) > self.imageWidth * self.scale then
      self.xPositions[i] = 0
    end
  end
end

function background:draw()
  love.graphics.draw(self.images[1], self.xPositions[1], 0, nil, self.scale)
  for i = 1, #self.images do
    love.graphics.draw(self.images[i], self.xPositions[i], 0, nil, self.scale)
    love.graphics.draw(self.images[i], self.xPositions[i] + self.imageWidth * self.scale, 0, nil, self.scale)
  end
end

return background
