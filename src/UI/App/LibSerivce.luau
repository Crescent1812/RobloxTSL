local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Path = require(script.Parent.Path)
local Wrap = require(script.Parent.Wrap)
local LibService = {}
LibService.__index = LibService

export type LibService = typeof(setmetatable({
	WrapService = Wrap.new({
		WrapComponent = {
			function(LibService: LibService): LibService
				print("Creating LibService instance")
				local self = setmetatable({}, LibService)
				return self
			end,
		},
	}),
}, LibService))

local libserv_COMPONENT = Wrap.new({
	WrapComponent = {
		function(): LibService
			print("Creating LibService instance")
			local self = setmetatable({}, LibService)
			local Folder = Path.newInstance(Instance.new("Folder"))
			local RobloxTSL =
				Path.getInstance(ReplicatedStorage.RobloxTSL or ReplicatedStorage:WaitForChild("RobloxTSL"))
			for i, v in pairs(ReplicatedStorage:GetDescendants()) do
				if v.Name == "Packages" and v:IsA("Folder") then
					print("Found RobloxTSL Packages folder")
				end
			end
			Folder.Name = "Libraries"
			Folder.Parent = ReplicatedStorage

			return self
		end,
	},

	Binding = Wrap.new({
		WrapComponent = {
			function() end,
		},
	}),
})

function LibService.GetLibService(): LibService
	return libserv_COMPONENT
end

return LibService
