local has_telescope, _ = pcall(require, 'telescope')
local previewers = require('easypick.previewers')
local actions = require "easypick.actions"
local pick = require "easypick.pick"

if not has_telescope then
	error('This plugin requires nvim-telescope/telescope.nvim')
end

local setup = function(args)
	local pickers = args.pickers
	local picker_names = {}
	for _, value in pairs(pickers) do
		table.insert(picker_names, value.name)
	end
	local command_opts = {
		nargs = "*",
		complete = function()
			-- return completion candidates as a list-like table
			return picker_names
		end
	}
	vim.api.nvim_create_user_command('Easypick', function(opts) pick.one(opts.args, pickers) end, command_opts)
end

return {
	setup = setup,
	previewers = previewers,
	actions = actions
}
