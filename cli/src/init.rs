use std::fs;

pub fn run_init() {
    println!("Initializing project...");

    let default_selene = r#"
std = "roblox+RobloxTSL"
"#;

    fs::write("selene.toml", default_selene)
        .expect("Failed to write selene.toml");

    fs::create_dir_all("src").ok();

    println!("Created selene.toml and src/ folder.");
    println!("Project initialized.");
}