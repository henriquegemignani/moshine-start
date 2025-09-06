local utils = require("__any-planet-start__.utils")

---Places `new` at the same place as `old` in the technology tree, including all prerequisities.
---@param old string
---@param new string
local function replace_technology_in_tree(old, new)
    local old_tech = assert(data.raw["technology"][old], "Could not find technology " .. old)
    local new_tech = assert(data.raw["technology"][new], "Could not find technology " .. new)

    for _, tech in pairs(data.raw["technology"]) do
        if tech.prerequisites then
            for i = #tech.prerequisites, 1, -1 do
                if tech.prerequisites[i] == old then
                    tech.prerequisites[i] = new
                end
            end
        end
    end

    new_tech.prerequisites = table.deepcopy(old_tech.prerequisites or {})
end

---Places `new` at the same place as `old` in the technology tree, including all prerequisities.
---@param old string
---@param new string
local function move_recipes_to(old, new, recipes)
    utils.remove_recipes(old, recipes)
    utils.add_recipes(new, recipes)
end

local function table_find(t, pred)
    for _, v in pairs(t) do
        if pred(v) then
            return v
        end
    end
    return nil
end

-- Easy to access coal for powering early game
table.insert(data.raw["simple-entity"]["moshine-huge-volcanic-rock"].minable.results, {
    type = "item", name = "coal", amount_min = 6, amount_max = 10
})

-- Automated stone, for easy furnaces, military/production science, concrete without foundry
-- Mines faster, to make early game less miserable.
data.raw["resource"]["multi-ore"].minable.mining_time = 1
table.insert(data.raw["resource"]["multi-ore"].minable.results, {
    type = "item",
    name = "stone",
    amount = 1,
    probability = 5 / 100,
})
table_find(
    data.raw["resource"]["multi-ore"].minable.results,
    function(result) return result.name == "copper-ore" end
).probability = 10/100

-- Make electric poles buildable without wood
data.raw["recipe"]["small-electric-pole"].ingredients[1].name = "iron-plate"

-- Mine big rock, get steam power
utils.set_trigger("steam-power", {
    type = "mine-entity",
    entity = "moshine-huge-volcanic-rock"
})

require("prototypes.steam-hammer")
utils.add_prerequisites("automation-science-pack", { "moshine-start-steam-hammer" })

-- Boiler is not unlocked in Steam power
data:extend { {
    type = "technology",
    name = "moshine-start-boiler",
    icon = "__moshine-start__/graphics/icons/oil-boiler-technology.png",
    icon_size = 1024,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "boiler"
        },
    },
    unit = {
        count = 150,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "space-science-pack",      1 },
        },
        time = 30,
    },
    prerequisites = { "space-science-pack" },
} }
utils.insert_recipe("steam-power", "moshine-start-steam-extractor", 3)
utils.remove_recipes("steam-power", { "boiler", "offshore-pump" })
utils.add_prerequisites("heating-tower", { "moshine-start-boiler" })

-- Petroleum Synthesis replaces Oil Processing
data:extend { {
    type = "technology",
    name = "moshine-start-petroleum-synthesis",
    icon = "__Moshine-assets__/graphics/icons/petroleum-from-sand-sulfur-steam-carbon.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "petroleum-from-sand-sulfur-steam-carbon"
        },
    },
    unit = {
        count = 150,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
        },
        time = 30,
    },
} }
move_recipes_to("oil-processing", "moshine-start-petroleum-synthesis",
    { "oil-refinery", "chemical-plant", "solid-fuel-from-petroleum-gas" })
replace_technology_in_tree("oil-processing", "moshine-start-petroleum-synthesis")
utils.set_prerequisites("moshine-start-petroleum-synthesis", { "fluid-handling" })

-- Coal Liquefaction replaces Advanced oil processing
replace_technology_in_tree("advanced-oil-processing", "coal-liquefaction")
utils.set_unit("coal-liquefaction", {
    count = 75,
    ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
    },
    time = 30,
})

--
utils.insert_recipe("coal-liquefaction", "simple-coal-liquefaction", 1)
utils.add_recipes("coal-liquefaction", { "steam-condensation" })
move_recipes_to("advanced-oil-processing", "coal-liquefaction",
    { "heavy-oil-cracking", "light-oil-cracking", "solid-fuel-from-heavy-oil", "solid-fuel-from-light-oil" })
utils.remove_recipes("calcite-processing", { "simple-coal-liquefaction", "steam-condensation" })

-- Move oil processing to Nauvis
utils.set_prerequisites("oil-processing", { "planet-discovery-nauvis" })
utils.set_prerequisites("advanced-oil-processing", { "oil-processing" })
utils.set_unit("advanced-oil-processing", {
    count = 500,
    ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "space-science-pack",      1 },
    },
    time = 30,
})

-- Iron ore for concrete
data:extend { {
    type = "recipe",
    name = "moshine-start-molten-iron-cooling",
    category = "chemistry-or-cryogenics",
    subgroup = "fluid-recipes",
    enabled = false,
    auto_recycle = false,
    allow_productivity = false,
    always_show_products = true,
    show_amount_in_title = false,
    allow_decomposition = false,
    allow_quality = false,
    icons = {
        {
            icon = data.raw["item"]["iron-ore"].icon,
        },
        {
            icon = "__space-age__/graphics/icons/casting-iron.png",
            scale = 0.32,
            shift = { 10, -10 },
        },
    },
    ingredients = {
        { type = "fluid", name = "water", amount = 100 },
        { type = "fluid", name = "molten-iron", amount = 25 },
    },
    energy_required = 1,
    results = {
        { type = "item", name = "iron-ore", amount = 1 }
    },
}  --[[@as data.RecipePrototype]]}
utils.add_recipes("concrete", {"moshine-start-molten-iron-cooling"})
utils.add_prerequisites("concrete", {"moshine-start-petroleum-synthesis"})

-- Fix dependencies of early moshine tech
utils.set_prerequisites("moshine-tech-magnet", { "electromagnetic-plant" })
utils.set_prerequisites("moshine-tech-silicon", { "moshine-start-petroleum-synthesis" })
utils.set_prerequisites("moshine-tech-silicon-carbide", { "moshine-tech-silicon", "sulfur-processing", "space-science-pack" })
utils.set_prerequisites("moshine-tech-glass", { "moshine-tech-silicon", "moshine-tech-supercomputer" })
utils.add_recipes("moshine-tech-silicon-carbide", {"carbon"})

--- Move unlocks from Planet discovery to appropriate places
utils.remove_recipes("planet-discovery-moshine",
    { "moshine-start-steam-extractor", "petroleum-from-sand-sulfur-steam-carbon", "concrete-from-molten-iron-and-sand" })
utils.add_recipes("foundry", { "concrete-from-molten-iron-and-sand" })
