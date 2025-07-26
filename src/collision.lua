local collision = {}

function collision.beginContact(a, b, coll)
  local textA = a:getUserData()
  local textB = b:getUserData()
  if (textA == "player" and textB == "trap") or (textB == "player" and textA == "trap") then
    State:set("game over")
  end
end

function collision.endContact(a, b, coll) end

return collision
