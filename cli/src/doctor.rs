use std::path::Path;

pub fn run_doctor() {
    println!("Running cli doctor...");

    if !Path::new("selene.toml").exists() {
        println!("❌ Missing selene.toml");
    } else {
        println!("✔ selene.toml found");
    }

    if !std::path::Path::new("src").exists() {
        println!("❌ Missing src/ folder");
    } else {
        println!("✔ src/ folder exists");
    }

    if !std::path::Path::new("generated_globals.luau").exists() {
        println!("⚠ generated_globals.luau not found (run cli build)");
    } else {
        println!("✔ generated_globals.luau exists");
    }

    println!("Doctor check complete.");
}