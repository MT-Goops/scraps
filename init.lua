local img = "default_mese_crystal_fragment.png"

local tools = {
  axe     = 3,
  pick    = 3,
  shovel  = 1,
  sword   = 2,
}

local extra_tools = {
  hammer  = 4,
  handsaw = 2
}

----------
-- MESE --
----------

local frag = "default:mese_crystal_fragment"

for tool_name, frags in pairs(tools) do
  minetest.register_craft({
    output    = frag.." "..4*frags,
    type      = "cooking",
    cooktime  = frags,
    recipe    = "default:"..tool_name.."_mese",
  })
end

if minetest.get_modpath("glooptest") then
  for tool_name, frags in pairs(extra_tools) do
    minetest.register_craft({
      output    = frag.." "..4*frags,
      type      = "cooking",
      cooktime  = frags,
      recipe    = "glooptest:"..tool_name.."_mese",
    })
  end
end

-------------
-- DIAMOND --
-------------

local shard = "goops_scraps:diamond_shard"

minetest.register_craftitem(shard,
{
  description     = "Diamond shards",
  inventory_image = img.."^[colorize:cyan:255",
})

minetest.register_craft({
  output  = "default:diamond",
  recipe = {{shard,shard,shard},{shard,shard,shard},{shard,shard,shard}}
})

for tool_name, frags in pairs(tools) do
  minetest.register_craft({
    output    = shard.." "..4*frags,
    type      = "cooking",
    cooktime  = frags,
    recipe    = "default:"..tool_name.."_diamond",
  })
end

if minetest.get_modpath("glooptest") then
  for tool_name, frags in pairs(extra_tools) do
    minetest.register_craft({
      output    = shard.." "..4*frags,
      type      = "cooking",
      cooktime  = frags,
      recipe    = "glooptest:"..tool_name.."_diamond",
    })
  end
end

------------
-- METALS --
------------

local metals = {
  bronze  = {
    mod       = "default",
    color     = "#cd7f32"
  },
  steel   = {
    mod       = "default",
    color     = "white",
  },
  alatro  = {
    mod       = "glooptest",
    color     = "#b078df",
  },
  arol    = {
    mod       = "glooptest",
    color     = "#86ff9e",
  },
  mithril = {
    mod       = "moreores",
    color     = "#6075dd",
  },
  silver  = {
    mod       = "moreores",
    color     = "#b7d1d3",
  },
}

for material, T in pairs(metals) do
  if minetest.get_modpath(T.mod) then
    local scrap = "goops_scraps:"..material.."_scrap"

    minetest.register_craftitem(scrap,
    {
      description     = material:gsub("^%l",string.upper).." scraps",
      inventory_image = img.."^[colorize:"..T.color..":255",
    })

    minetest.register_craft({
      output  = T.mod..":"..material.."_ingot",
      recipe = {{scrap,scrap,scrap},{scrap,scrap,scrap},{scrap,scrap,scrap}}
    })

    for tool_name, frags in pairs(tools) do
      minetest.register_craft({
        output    = scrap.." "..4*frags,
        type      = "cooking",
        cooktime  = frags,
        recipe    = T.mod..":"..tool_name.."_"..material,
      })
    end

    if minetest.get_modpath("glooptest") and T.mod~="moreores" then
      for tool_name, frags in pairs(extra_tools) do
        minetest.register_craft({
          output    = scrap.." "..4*frags,
          type      = "cooking",
          cooktime  = frags,
          recipe    = "glooptest:"..tool_name.."_"..material,
        })
      end
    end
  end
end
