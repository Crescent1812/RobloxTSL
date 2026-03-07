local Wrap = require(script.Parent.Wrap)
local App = {}
App.__index = App

export type App = typeof(setmetatable({}, App))

local AppService = Wrap.new({
	WrapComponent = {
		function(AppService: App): App
			print("Creating App instance")
			local self = setmetatable({}, App)
			return self
		end,
	},
})

AppService.WrapComponent[1](App, AppService)

return App
