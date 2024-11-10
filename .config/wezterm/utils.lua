local M = {}

function M.merge_keybindings(config, new_keys)
	local lookup = {}
	for i, existing in ipairs(config.keys) do
		lookup[existing.key .. existing.mods] = i
	end

	for _, new_key in ipairs(new_keys) do
		local id = new_key.key .. new_key.mods
		config.keys[lookup[id] or #config.keys + 1] = new_key
	end
end

return M
