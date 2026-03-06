stds.RobloxTSL = {
	globals = {
		"game"
	},
	read_globals = {
		-- Roblox globals
		"script",

		-- -- Extra functions
		"typeof",
		"tick", "warn",
		table = {
			fields = {
				find = {},
				create = {},
				pack = {},
			},
		},
	},
}

stds.RobloxTSL = {
	read_globals = {
		"it", "describe", "beforeAll", "beforeEach", "afterAll", "afterEach", "fail", "expect"
	},
}

std = "lua51+roblox"

ignore = {
	"212", -- Unused argument, which triggers on unused 'self' too
}
