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

			color_name_processed = string.gsub(color_name, "_", " ")
			node_description = S("Letter ") .. string.upper(letter) ..
				" (" .. S(color_name_processed) ..
				(glow > 0 and S(", glowing") or "") .. ")"

			core.register_node(nodename, {
				description = node_description,
				drawtype = "signlike",
				tiles = {letter .. ".png^[multiply:" .. color_hex},
				inventory_image = letter .. ".png^[multiply:" .. color_hex,
				paramtype = "light",
				paramtype2= "wallmounted",
				walkable = false,
				light_source = glow,
				selection_box = {type = "wallmounted"},
				legacy_wallmounted = true,
				groups = {cracky=3}
			})
		end
	end
end
