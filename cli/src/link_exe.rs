use std::process::Command;
use std::path::PathBuf;
use std::env;

fn main() {
    println!("Running link_exe...");

    // Determine build mode
    let profile = env::var("PROFILE").unwrap_or_else(|_| "release".to_string());

    // Determine target directory
    let mut target_dir = PathBuf::from("target");
    target_dir.push(&profile);

    // Determine library name
    let lib_name = if cfg!(target_os = "windows") {
        "cli_core.lib"
    } else {
        "libcli_core.a"
    };

    let lib_path = target_dir.join(lib_name);

    if !lib_path.exists() {
        eprintln!("❌ Could not find library: {}", lib_path.display());
        eprintln!("Run `cargo build --release` first.");
        return;
    }

    println!("✔ Found library: {}", lib_path.display());

    // Output executable name
    let exe_name = if cfg!(target_os = "windows") {
        "linked_cli.exe"
    } else {
        "linked_cli"
    };

    let exe_path = target_dir.join(exe_name);

    // Build linker command
    let mut cmd = if cfg!(target_os = "windows") {
        let mut c = Command::new("link.exe");
        c.arg(format!("/OUT:{}", exe_path.display()))
         .arg(lib_path.display().to_string());
        c
    } else {
        let mut c = Command::new("cc");
        c.arg("-o")
         .arg(&exe_path)
         .arg(&lib_path);
        c
    };

    println!("🔧 Linking executable...");

    let status = cmd.status().expect("Failed to run linker");

    if status.success() {
        println!("🎉 Successfully linked executable:");
        println!("   {}", exe_path.display());
    } else {
        eprintln!("❌ Linking failed with status: {}", status);
    }
}