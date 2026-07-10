local letters = {}

for i = string.byte("a"), string.byte("z") do
	table.insert(letters, string.char(i))
end

local colors = {
	white = "#ffffff",
	grey = "#808080",
	dark_grey = "#696969",
	black = "#000000",
	violet = "#ee82ee",
	blue = "#0000ff",
	cyan = "#00ffff",
	dark_green = "#006400",
	green = "#008000",
	yellow = "#ffff00",
	brown = "#a52a2a",
	orange = "#ffa500",
	red = "#ff0000",
	magenta = "#ff00ff",
	pink = "#ffc0cb"
}

local S = core.get_translator("signlike_letters")

for _, letter in ipairs(letters) do
	for color_name, color_hex in pairs(colors) do
		for _, glow in ipairs({0, 14}) do
			local nodename = "signlike_letters:" .. letter .. "_" .. color_name
			if glow > 0 then
				nodename = nodename .. "_glow"
			end

			local groups = {cracky = 3}
			if glow > 0 then
				groups.not_in_creative_inventory = 1
			end

			color_name_processed = string.gsub(color_name, "_", " ")

			core.register_node(nodename, {
				description = S("Letter ") .. string.upper(letter) ..
					" (" .. S(color_name_processed) .. ")",
				drawtype = "signlike",
				tiles = {letter .. ".png^[multiply:" .. color_hex},
				inventory_image = letter .. ".png^[multiply:" .. color_hex,
				paramtype = "light",
				paramtype2= "wallmounted",
				walkable = false,
				light_source = glow,
				selection_box = {type = "wallmounted"},
				legacy_wallmounted = true,
				groups = groups,
				on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
					local new_name
					if node.name:find("_glow") then
						new_name = node.name:gsub("_glow", "")
					else
						new_name = node.name .. "_glow"
					end

					core.swap_node(pos, {name = new_name, param2 = node.param2})
				end
			})
		end
	end
end
