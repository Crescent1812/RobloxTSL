local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Path = require(script.Parent.Path)
local Wrap = require(script.Parent.Wrap)
local LibService = {}
LibService.__index = LibService

export type LibService = typeof(setmetatable({}, LibService))

type lib<LC, LP> = {
	Library: LC,
	LibraryParent: LP,
}

type GetLibSerivce<S> = {
    Service: S
}

local libServiceWrappper = Wrap.new({
	WrapComponent = {
		function()
			print("libservice wrapper initalized")
		end,
	},
})

local libserv_COMPONENT = Wrap.new({
	WrapComponent = {
		function<LC, LP>(Library: LC, LibraryParent: LP): lib<LC, LP>
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
})

function LibService.GetLibService<S>(GetLibService: GetLibSerivce<S>): GetLibSerivce<S>
	return GetLibService
end

--[[
    ==[[ Merging LibService Libraries
    local MergedKits = Wrap.WrapKit(libServiceWrappper, libserv_COMPONENT)
    ==]]
--]]

return LibService
