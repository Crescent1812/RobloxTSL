use ::std::{env, fs, thread, time::{Duration, SystemTime}};



mod std;
mod inject;
mod mutation;
mod init;
mod doctor;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: cli <build|watch|init|doctor>");
        return;
    }

    match args[1].as_str() {
        "build" => run_build(),
        "watch" => run_watch(),
        "init" => init::run_init(),
        "doctor" => doctor::run_doctor(),
        _ => eprintln!("Unknown command: {}", args[1]),
    }
}

fn run_build() {
    println!("Running cli build...");

    let content = fs::read_to_string("selene.toml")
        .expect("Could not read selene.toml");

    let parsed: toml::Value = toml::from_str(&content)
        .expect("Invalid selene.toml format");

    let std_field = parsed["std"].as_str().unwrap();
    let parts: Vec<String> = std_field
        .split('+')
        .map(|s| s.to_string())
        .collect();

    inject::generate_globals(&parts);
    mutation::mutate_luau_source("src");

    println!("Build complete.");
}

fn run_watch() {
    println!("Watching selene.toml for changes...");

    let path = "selene.toml";
    let mut last_modified = fs::metadata(path)
        .and_then(|m| m.modified())
        .unwrap_or(SystemTime::now());

    loop {
        thread::sleep(Duration::from_secs(1));

        let modified = match fs::metadata(path).and_then(|m| m.modified()) {
            Ok(time) => time,
            Err(_) => continue,
        };

        if modified > last_modified {
            println!("Detected change in selene.toml — rebuilding...");
            last_modified = modified;
            run_build();
        }
    }
}