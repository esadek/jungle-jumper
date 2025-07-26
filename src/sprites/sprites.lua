local background = require("sprites/background")
local ground = require("sprites/ground")
local player = require("sprites/player")
local spikes = require("sprites/spikes")
local spikeHead = require("sprites/spike_head")

local function spritesSequence()
  return {
    background:new(),
    ground:new(),
    spikes:new(),
    spikeHead:new(),
    player:new(),
  }
end

local sprites = {}

function sprites:new()
  local obj = { sequence = spritesSequence() }
  self.__index = self
  return setmetatable(obj, self)
end

function sprites:reset()
  self.sequence = spritesSequence()
end

function sprites:update(dt)
  for _, sprite in ipairs(self.sequence) do
    sprite:update(dt)
  end
end

function sprites:draw()
  for _, sprite in ipairs(self.sequence) do
    sprite:draw()
  end
end

return sprites
