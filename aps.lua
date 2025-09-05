local utils = require("__any-planet-start__.utils")

-- Easy to access coal for powering early game
table.insert(data.raw["simple-entity"]["moshine-huge-volcanic-rock"].minable.results, {
    type = "item", name = "coal", amount_min = 2, amount_max = 4
})

-- Automated stone, for easy furnaces, military/production science, concrete without foundry
table.insert(data.raw["resource"]["multi-ore"].minable.results, {
    type = "item",
    name = "stone",
    amount = 1,
    probability = 5 / 100,
})
-- A way to make concrete without the foundry too -> solved by having stone

-- Make electric poles buildable without wood
data.raw["recipe"]["small-electric-pole"].ingredients[1].name = "iron-plate"

-- TODO: Adjust simple and regular coal liquefaction to be unlocked via research 