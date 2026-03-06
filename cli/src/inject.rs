use std::fs;
use crate::std::get_std;

pub fn generate_globals(selene_std: &[String]) {
    let mut allowed = Vec::new();

    for std in selene_std {
        if let Some(list) = get_std(std) {
            allowed.extend(list.iter().copied());
        }
    }

    let mut out = String::from("return {\n");
    for g in allowed {
        out.push_str(&format!("    {} = true,\n", g));
    }
    out.push_str("}\n");

    fs::write("generated_globals.luau", out)
        .expect("Failed to write generated_globals.luau");
}