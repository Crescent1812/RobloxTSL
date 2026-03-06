-- selene_globals.lua
-- One-file solution: reads selene.toml, loads std globals, and enforces them.

-- =========================
-- Utility: read file
-- =========================
local function read_file(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	return content
end

-- =========================
-- Step 1: Parse selene.toml
-- =========================
local function parse_selene_std()
	local toml = read_file("selene.toml")
	if not toml then
		return {}
	end

	-- Extract: std = "roblox+RobloxTSL"
	local std = toml:match('std%s*=%s*"([^"]+)"')
	if not std then
		return {}
	end

	local parts = {}
	for part in std:gmatch("[^+]+") do
		table.insert(parts, part)
	end

	return parts
end

-- =========================
-- Step 2: Define std globals
-- =========================
local selene_stds = {
	roblox = {
		"game",
		"workspace",
		"script",
		"Enum",
		"Instance",
		"Color3",
		"Vector3",
		"UDim2",
		"CFrame",
		"task",
		"typeof",
		"print",
		"warn",
	},

	RobloxTSL = {
		"TS",
		"Promise",
		"Symbol",
		"Map",
		"Set",
		"WeakMap",
		"WeakSet",
		"Error",

		-- IMPORTANT: RobloxTSL allows constructor-like helpers
		"new",
	},
}

-- =========================
-- Step 3: Build allowed globals
-- =========================
local allowed_globals = {}

for _, std in ipairs(parse_selene_std()) do
	local list = selene_stds[std]
	if list then
		for _, g in ipairs(list) do
			allowed_globals[g] = true
		end
	end
end

-- =========================
-- Step 4: Safe global accessor
-- =========================
local function safe_global(name)
	if not allowed_globals[name] then
		error("Global '" .. name .. "' is NOT allowed by selene.toml")
	end
	return _G[name]
end

-- Export
return {
	allowed = allowed_globals,
	safe = safe_global,
}
