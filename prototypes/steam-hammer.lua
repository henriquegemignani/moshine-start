---@type data.RecipeCategory
local recipe_category = {
    type = "recipe-category",
    name = "moshine-start-steam-hammer"
}

---@type data.RecipePrototype
local iron_recipe = {
    type = "recipe",
    name = "moshine-start-press-molten-iron",
    energy_required = 3.2,
    enabled = false,
    category = "moshine-start-steam-hammer",
    icons = {
        {
            icon = "__space-age__/graphics/icons/casting-iron.png",
        },
        {
            icon = "__moshine-start__/graphics/icons/metal-press-machine.png",
            scale = 0.32,
            shift = { 10, -10 },
        },
    },
    ingredients =
    {
        { type = "fluid", name = "molten-iron", amount = 20 },
    },
    results = { { type = "item", name = "iron-plate", amount = 1 } },
}

---@type data.ItemPrototype
local item = {
    type = "item",
    name = "moshine-start-steam-hammer",
    icon = "__moshine-start__/graphics/icons/metal-press-machine.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[assembling-machine-1]",
    place_result = "moshine-start-steam-hammer",
    stack_size = 25
}

---@type data.RecipePrototype
local entity_recipe = {
    type = "recipe",
    name = "moshine-start-steam-hammer",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
        { type = "item", name = "iron-plate",      amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 8 }
    },
    results = { { type = "item", name = "moshine-start-steam-hammer", amount = 1 } },
}

---@type data.AssemblingMachinePrototype
local entity = {
    type = "assembling-machine",
    name = "moshine-start-steam-hammer",
    icon = "__moshine-start__/graphics/icons/metal-press-machine.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "moshine-start-steam-hammer" },
    max_health = 240,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",

    scale_entity_info_icon = true,
    collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    alert_icon_shift = util.by_pixel(-3, -12),

    fixed_recipe = iron_recipe.name,

    energy_usage = "300kW",
    energy_source = {
        type = "fluid",
        maximum_temperature = 165,
        scale_fluid_usage = true,
        effectivity = 0.35,
        fluid_box = {
            production_type = "input",
            filter = "steam",
            volume = 50,
            pipe_connections = {
                { flow_direction = "input-output", direction = defines.direction.east, position = { 1, 0 } },
                { flow_direction = "input-output", direction = defines.direction.west, position = { -1, 0 } }
            },
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
        }
    },

    fluid_boxes = {
        {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections = {
                { flow_direction = "input-output", direction = defines.direction.north, position = { 0, -1 } },
                { flow_direction = "input-output", direction = defines.direction.south, position = { 0, 1 } },
            },
        },
    },

    graphics_set = {
        animation = {
            layers = {
                {
                    filename = "__moshine-start__/graphics/entity/metal-press-machine.png",
                    priority = "high",
                    width = 1620 / 9,
                    height = 480 / 2,
                    frame_count = 18,
                    line_length = 9,
                    shift = util.by_pixel(0, -16),
                    scale = 0.55,
                },
                {
                    filename = "__moshine-start__/graphics/entity/metal-press-machine-shadow.png",
                    priority = "high",
                    width = 2880 / 9,
                    height = 256 / 2,
                    frame_count = 18,
                    line_length = 9,
                    draw_as_shadow = true,
                    shift = util.by_pixel(39, 13),
                    scale = 0.55,
                }
            }
        },
    },
    crafting_categories = { "moshine-start-steam-hammer" },
    crafting_speed = 1,
    ingredient_count = 1,

    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
        match_speed_to_activity = true,
        sound = {
            {
                filename = "__moshine-start__/sounds/hpmp.ogg",
                volume = 0.3,
                min_speed = 0.1,
                max_speed = 1.4,
            },
        },
        audible_distance_modifier = 0.5,
    },
}

---@type data.TechnologyPrototype
local tech = {
    type = "technology",
    name = "moshine-start-steam-hammer",
    icon_size = 256,
    icon = "__moshine-start__/graphics/icons/hpmp-technology.png",
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = entity_recipe.name,
        },
        {
            type = "unlock-recipe",
            recipe = iron_recipe.name
        }
    },
    prerequisites = { "steam-power" },
    research_trigger = {
        type = "build-entity",
        entity = "moshine-start-steam-extractor"
    },
}

data:extend { item, entity_recipe, entity, tech, recipe_category, iron_recipe }
