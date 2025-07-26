local function drawBackground()
  love.graphics.setColor(0, 0, 0, 0.6)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(1, 1, 1, 1)
end

local function drawText(largeText, smallText)
  local largeTextX = (love.graphics.getWidth() / 2) - (LargeFont:getWidth(largeText) / 2)
  local largeTextY = (love.graphics.getHeight() / 2) - LargeFont:getHeight()
  local smallTextX = (love.graphics.getWidth() / 2) - (Font:getWidth(smallText) / 2)
  local smallTextY = (love.graphics.getHeight() / 2) + Font:getHeight()

  love.graphics.setFont(LargeFont)
  love.graphics.print(largeText, largeTextX, largeTextY)
  love.graphics.setFont(Font)
  love.graphics.print(smallText, smallTextX, smallTextY)
end

local function drawScreen(largeText, smallText)
  drawBackground()
  drawText(largeText, smallText)
end

local screens = {}

function screens.welcome()
  local largeText = "Jungle Jumper"
  local smallText = "Press SPACE to start"
  drawScreen(largeText, smallText)
end

function screens.gameOver()
  local largeText = "Game Over"
  local smallText = "Press SPACE to restart"
  drawScreen(largeText, smallText)
end

return screens
