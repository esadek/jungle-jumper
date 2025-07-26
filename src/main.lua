local collision = require("collision")
local state = require("state")

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  Font = love.graphics.newFont("assets/fonts/m6x11.ttf", 32)
  LargeFont = love.graphics.newFont("assets/fonts/m6x11plus.ttf", 72)
  love.graphics.setFont(Font)

  Music = love.audio.newSource("assets/audio/evening_harmony.ogg", "stream")

  local meterScale = 64
  local verticalGravity = 9.81 * meterScale
  love.physics.setMeter(meterScale)
  World = love.physics.newWorld(0, verticalGravity, true)
  World:setCallbacks(collision.beginContact, collision.endContact)

  State = state:new()
end

function love.update(dt)
  State:update(dt)

  if not Music:isPlaying() then
    love.audio.play(Music)
  end
end

function love.draw()
  State:draw()
end
