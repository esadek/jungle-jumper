local utils = {}

function utils.octagonVertices(radius, scaleX)
  scaleX = scaleX or 1
  local vertices = {}
  for i = 0, 7 do
    local angle = (math.pi / 4) * i + (math.pi / 8)
    local vx = radius * math.cos(angle) * scaleX
    local vy = radius * math.sin(angle)
    table.insert(vertices, vx)
    table.insert(vertices, vy)
  end
  return vertices
end

function utils.isoscelesTrapezoidVertices(topWidth, bottomWidth, height)
  local halfTopWidth = topWidth / 2
  local halfBottomWidth = bottomWidth / 2
  local halfHeight = height / 2
  return {
    -halfBottomWidth,
    halfHeight,
    halfBottomWidth,
    halfHeight,
    halfTopWidth,
    -halfHeight,
    -halfTopWidth,
    -halfHeight,
  }
end

return utils
