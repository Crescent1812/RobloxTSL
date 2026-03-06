pub static ROBLOX: &[&str] = &[
    "game", "workspace", "script", "Enum", "Instance",
    "Color3", "Vector3", "UDim2", "CFrame",
];

pub static ROBLOX_TSL: &[&str] = &[
    "TS", "Promise", "Symbol",
    "Map", "Set", "WeakMap", "WeakSet",
    "Error",
    "new",
];

pub fn get_std(name: &str) -> Option<&'static [&'static str]> {
    match name {
        "roblox" => Some(ROBLOX),
        "RobloxTSL" => Some(ROBLOX_TSL),
        _ => None,
    }
}