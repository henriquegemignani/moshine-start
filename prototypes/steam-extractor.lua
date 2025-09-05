local futil = require("util")

---@type data.ItemPrototype
local item = {
  type = "item",
  name = "moshine-start-steam-extractor",
  icon = "__moshine-start__/graphics/icons/gas-extractor.png",
  icon_size = 128,
  subgroup = "extraction-machine",
  order = "b[fluids]-b[gas-extractor]",
  place_result = "moshine-start-steam-extractor",
  stack_size = 20,
}

---@type data.RecipePrototype
local recipe = {
  type = "recipe",
  name = "moshine-start-steam-extractor",
  enabled = false,
  ingredients = {
    { type = "item", name = "iron-plate", amount = 10 },
    { type = "item", name = "pipe",       amount = 10 },
  },
  results = {
    { type = "item", name = "moshine-start-steam-extractor", amount = 1 }
  },
}

---@type data.MiningDrillPrototype
local drill = {
  type = "mining-drill",
  name = "moshine-start-steam-extractor",
  icon = "__moshine-start__/graphics/icons/gas-extractor.png",
  icon_size = 128,
  flags = { "placeable-neutral", "player-creation" },
  minable = { mining_time = 0.5, result = "moshine-start-steam-extractor" },
  resource_categories = { "steam" },
  max_health = 200,
  corpse = "pumpjack-remnants",
  dying_explosion = "pumpjack-explosion",
  collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
  selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
  drawing_box = { { -1.6, -2.5 }, { 1.5, 1.6 } },
  energy_source = {
    type = "burner",
    fuel_categories = { "chemical" },
    effectivity = 1,
    fuel_inventory_size = 1,
    emissions_per_minute = { pollution = 12 },
    light_flicker = { color = { 0, 0, 0 } },
    smoke = {
      {
        name = "smoke",
        frequency = 15,
        height = 4.6,
        starting_vertical_speed = 0.0,
        starting_frame_deviation = 60
      }
    }
  },
  output_fluid_box = {
    volume = 1000,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      {
        direction = defines.direction.north,
        positions = { { 0, -1 }, { 1, 0 }, { 0, 1 }, { -1, 0 } },
        flow_direction = "output"
      }
    }
  },
  energy_usage = "150kW",
  mining_speed = 0.5,
  resource_searching_radius = 0.49,
  vector_to_place_result = { 0, 0 },
  radius_visualisation_picture = {
    filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
    width = 12,
    height = 12
  },
  monitor_visualization_tint = { r = 78, g = 173, b = 255 },
  base_render_layer = "lower-object-above-shadow",
  base_picture = {
    north = {
      filename = "__moshine-start__/graphics/entity/gas-extractor-base-n.png",
      priority = "extra-high",
      width = 175,
      height = 179,
      scale = 0.5,
      shift = futil.by_pixel(0, -4),
    },
    south = {
      filename = "__moshine-start__/graphics/entity/gas-extractor-base-s.png",
      priority = "extra-high",
      width = 175,
      height = 149,
      scale = 0.5,
      shift = futil.by_pixel(0, 13),
    },
    east = {
      filename = "__moshine-start__/graphics/entity/gas-extractor-base-e.png",
      priority = "extra-high",
      width = 207,
      height = 129,
      scale = 0.5,
      shift = futil.by_pixel(8, 8),
    },
    west = {
      filename = "__moshine-start__/graphics/entity/gas-extractor-base-w.png",
      priority = "extra-high",
      width = 207,
      height = 129,
      scale = 0.5,
      shift = futil.by_pixel(-8, 8),
    },
  },
  graphics_set = {
    animation = {
      layers = {
        {
          filename = "__moshine-start__/graphics/entity/gas-extractor-animated.png",
          priority = "extra-high",
          width = 267,
          height = 604,
          scale = 0.33, -- just under 1/3, for height ~200. Check why height is 604 and not 600
          frame_count = 100,
          line_length = 8,
          animation_speed = 0.5,
          shift = futil.by_pixel(0, -60),
        },
        {
          stripes = futil.multiplystripes(100, { {
            filename = "__moshine-start__/graphics/entity/gas-extractor-shadow.png",
            width_in_frames = 1,
            height_in_frames = 1,
          } }),
          priority = "extra-high",
          width = 331,
          height = 64,
          draw_as_shadow = true,
          frame_count = 100,
          animation_speed = 0.5,
          shift = futil.by_pixel(119, 8),
        },
      },
    },
  },
  open_sound = data.raw["mining-drill"]["pumpjack"].open_sound,
  close_sound = data.raw["mining-drill"]["pumpjack"].close_sound,
  working_sound = {
    sound = {
      {
        filename = "__base__/sound/pumpjack.ogg",
        volume = 0.7
      },
    },
    max_sounds_per_type = 3,
    audible_distance_modifier = 0.6,
    fade_in_ticks = 4,
    fade_out_ticks = 10
  },
  fast_replaceable_group = "pumpjack",
}

table.insert(data.raw["technology"]["planet-discovery-moshine"].effects, {
  type = "unlock-recipe",
  recipe = "moshine-start-steam-extractor"
})

data:extend { item, recipe, drill, }
