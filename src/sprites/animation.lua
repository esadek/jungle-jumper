local animation = {}

function animation:new(image, width, height, duration)
  local obj = {
    spriteSheet = image,
    quads = {},
    duration = duration or 1,
    currentTime = 0,
  }

  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      table.insert(obj.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end

  self.__index = self
  return setmetatable(obj, self)
end

function animation:update(dt)
  self.currentTime = self.currentTime + dt
  if self.currentTime >= self.duration then
    self.currentTime = self.currentTime - self.duration
  end
end

function animation:draw(x, y, sx)
  local spriteNum = math.floor(self.currentTime / self.duration * #self.quads) + 1
  love.graphics.draw(self.spriteSheet, self.quads[spriteNum], x, y, 0, sx or 1)
end

return animation
