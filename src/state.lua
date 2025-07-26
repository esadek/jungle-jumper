local score = require("score")
local screens = require("screens")
local sprites = require("sprites/sprites")

local state = {}

function state:new()
  local obj = {
    currentState = "welcome",
    sprites = sprites:new(),
    score = score:new(),
  }

  self.__index = self
  return setmetatable(obj, self)
end

function state:set(newState)
  self.currentState = newState
end

function state:resetWorld()
  local bodies = World:getBodies()
  for _, body in ipairs(bodies) do
    body:destroy()
  end

  self.sprites:reset()
end

function state:update(dt)
  if self.currentState == "welcome" then
    if love.keyboard.isDown("up", "space") then
      self:set("game")
      self.score:start()
    end
  elseif self.currentState == "game" then
    World:update(dt)
    self.sprites:update(dt)
    self.score:update(dt)
  elseif self.currentState == "game over" then
    if love.keyboard.isDown("up", "space") then
      self:set("game")
      self.score:start()
      self:resetWorld()
    end
  end
end

function state:draw()
  self.sprites:draw()

  if self.currentState == "welcome" then
    screens.welcome()
  elseif self.currentState == "game" then
    self.score:draw()
  elseif self.currentState == "game over" then
    self.score:draw()
    screens.gameOver()
  end
end

return state
