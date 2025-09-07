local planet = data.raw.planet.moshine

for i = #planet.asteroid_spawn_definitions, 1, -1 do
    local def = planet.asteroid_spawn_definitions[i]
    if def.asteroid:sub(-6) ~= "-chunk" then
        table.remove(planet.asteroid_spawn_definitions, i)
    end
end
