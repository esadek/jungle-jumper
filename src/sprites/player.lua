local animation = require("sprites/animation")
local utils = require("sprites/utils")

local player = {}

function player:new()
  local frameWidth, frameHeight = 23, 34
  local animationDuration = 0.8
  local imageBasePath = "assets/sprites/player/"

  local obj = {}
  obj.scale = 2
  obj.jumpVelocity = -400
  obj.width = frameWidth * obj.scale
  obj.height = frameHeight * obj.scale
  obj.animations = {
    running = animation:new(
      love.graphics.newImage(imageBasePath .. "run.png"),
      frameWidth,
      frameHeight,
      animationDuration
    ),
    jumping = love.graphics.newImage(imageBasePath .. "jump.png"),
    falling = love.graphics.newImage(imageBasePath .. "fall.png"),
  }
  obj.body = love.physics.newBody(World, 100, love.graphics.getHeight() - 120, "dynamic")
  obj.shape = love.physics.newPolygonShape(utils.octagonVertices(obj.height / 2, 0.5))
  obj.fixture = love.physics.newFixture(obj.body, obj.shape)
  obj.body:setFixedRotation(true)
  obj.fixture:setFriction(0)
  obj.fixture:setUserData("player")

  self.__index = self
  return setmetatable(obj, self)
end

function player:update(dt)
  self.animations.running:update(dt)
  if love.keyboard.isDown("up", "space") then
    local _, velocityY = self.body:getLinearVelocity()
    if velocityY < 0.1 and velocityY > -0.1 then
      self.body:setLinearVelocity(0, self.jumpVelocity)
    end
  end
end

function player:draw()
  local x = self.body:getX() - self.width / 2
  local y = self.body:getY() - self.height / 2
  local _, velocityY = self.body:getLinearVelocity()

  if velocityY < -0.1 then
    love.graphics.draw(self.animations.jumping, x, y, nil, self.scale)
  elseif velocityY > 0.1 then
    love.graphics.draw(self.animations.falling, x, y, nil, self.scale)
  else
    self.animations.running:draw(x, y, self.scale)
  end
end

return player
