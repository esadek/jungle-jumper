local utils = require("sprites/utils")

local spikes = {}

function spikes:new()
  local obj = {}
  obj.image = love.graphics.newImage("assets/sprites/spikes.png")
  obj.scale = 2
  obj.speed = 200
  obj.width = obj.image:getWidth() * obj.scale
  obj.height = obj.image:getHeight() * obj.scale
  obj.body = love.physics.newBody(World, love.graphics.getWidth(), love.graphics.getHeight() - 64, "kinematic")
  obj.shape =
    love.physics.newPolygonShape(utils.isoscelesTrapezoidVertices(obj.width * 2 * 0.7, obj.width * 2, obj.height))
  obj.fixture = love.physics.newFixture(obj.body, obj.shape)
  obj.fixture:setUserData("trap")

  self.__index = self
  return setmetatable(obj, self)
end

function spikes:update(dt)
  self.body:setX(self.body:getX() - dt * self.speed)
  if self.body:getX() < -self.width then
    self.body:setX(love.graphics.getWidth())
  end
end

function spikes:draw()
  local x = self.body:getX() - self.width
  local y = self.body:getY() - self.height / 2
  love.graphics.draw(self.image, x, y, nil, self.scale)
  love.graphics.draw(self.image, x + self.width, y, nil, self.scale)
end

return spikes
