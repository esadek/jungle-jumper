local ground = {}

function ground:new()
  local obj = {}
  obj.x = 0
  obj.scale = 2
  obj.speed = 200
  obj.image = love.graphics.newImage("assets/sprites/ground.png")
  obj.width = obj.image:getWidth() * obj.scale
  obj.height = obj.image:getHeight() * obj.scale
  obj.body = love.physics.newBody(
    World,
    love.graphics.getWidth() / 2,
    (love.graphics.getHeight() - obj.height / 2) + (obj.height / 8),
    "static"
  )
  obj.shape = love.physics.newRectangleShape(love.graphics.getWidth(), obj.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape)
  obj.fixture:setFriction(0)
  obj.fixture:setUserData("ground")

  self.__index = self
  return setmetatable(obj, self)
end

function ground:update(dt)
  self.x = self.x - dt * self.speed
  if math.abs(self.x) > self.width then
    self.x = 0
  end
end

function ground:draw()
  for i = 0, love.graphics.getWidth() / self.width + 1 do
    local x = self.x + i * self.width
    local y = love.graphics.getHeight() - self.height
    love.graphics.draw(self.image, x, y, nil, self.scale)
  end
end

return ground
