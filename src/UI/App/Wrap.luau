local Wrap = {}
Wrap.__index = {
    function(__index): ()
        print(__index)
    end
}

Wrap.__index[1]("Wrap Initalized __Index")

type WrapTSL<W> = {
	WrapComponent: W,
}

type WrapTSLBinding<B> = {
	Bindings: B,
}

type WrapKitStore<K, L> = {
	Kit1: K,
	Kit2: L,
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

function Wrap.WrapKit<K, L>(Kit1: K, Kit2: L): WrapKitStore<K, L>
	return { Kit1 = Kit1, Kit2 = Kit2 }
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
