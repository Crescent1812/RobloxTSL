std = "lua51"

globals = {
    -- Roblox + Luau
    "game", "workspace", "script", "shared", "plugin",
    "Enum", "Instance",
    "Color3", "Vector3", "Vector2", "UDim", "UDim2",
    "CFrame", "BrickColor", "Rect",
    "task", "utf8", "typeof", "print", "warn", "assert",
}

read_globals = {
    -- RobloxTSL runtime
    "TS",
    "Promise",
    "Symbol",
    "Map", "Set",
    "WeakMap", "WeakSet",
    "Error",

    -- Your custom constructor-like globals
    "new",
    "function",
}

ignore = {
    "212", -- unused argument
}

exclude_files = {
    "out/**",
    "node_modules/**",
}