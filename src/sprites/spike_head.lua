local animation = require("sprites/animation")
local utils = require("sprites/utils")

local spikeHead = {}

function spikeHead:new()
  local frameWidth, frameHeight = 43, 43
  local animationDuration = 2

  local obj = {}
  obj.baseY = love.graphics.getHeight() / 2
  obj.scale = 2
  obj.speed = 300
  obj.width = frameWidth * obj.scale
  obj.height = frameHeight * obj.scale
  obj.animation =
    animation:new(love.graphics.newImage("assets/sprites/spike_head.png"), frameWidth, frameHeight, animationDuration)
  obj.body = love.physics.newBody(World, love.graphics.getWidth() / 2, obj.baseY, "kinematic")
  obj.shape = love.physics.newPolygonShape(utils.octagonVertices(obj.width / 2))
  obj.fixture = love.physics.newFixture(obj.body, obj.shape)
  obj.fixture:setUserData("trap")

  self.__index = self
  return setmetatable(obj, self)
end

function spikeHead:update(dt)
  self.animation:update(dt)

  self.body:setX(self.body:getX() - dt * self.speed)
  if self.body:getX() < -self.width then
    self.body:setX(love.graphics.getWidth())
  end

  local speed = 6
  local amplitude = 20
  local offset = math.sin(love.timer.getTime() * speed) * amplitude
  self.body:setY(self.baseY + offset)
end

function spikeHead:draw()
  local x = self.body:getX() - self.width / 2
  local y = self.body:getY() - self.height / 2
  self.animation:draw(x, y, self.scale)
end

return spikeHead
