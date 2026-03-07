local Wrap = {}
Wrap.__index = Wrap

type WrapTSL<W> = {
	WrapComponent: W,
}

type WrapTSLBinding<B> = {
	Bindings: B,
}

function Wrap.new<W, E>(WrapComponent: WrapTSL<W>): WrapTSL<W>
	for key, value in pairs(WrapComponent) do
		if type(value) == "function" then
			WrapComponent[key] = function(...)
				print("Before calling the function")
				local result = value(...)
				print("After calling the function")
				return result
			end
		end
	end
	return WrapComponent
end

function Wrap.BindComponent<B>(Bindings: B): WrapTSLBinding<B>
	local self = setmetatable({}, Wrap)
	print("Binding component with provided bindings")
	return {
		WrapComponent = self.WrapComponent,
		Bindings = Bindings,
	}
end

--[[
local w = Wrap.new({
	WrapComponent = {
		function(Name: string): string
			print("This is the original function.")
			return "Hello, " .. Name .. "!"
		end,
	},
})

--]]

return Wrap
