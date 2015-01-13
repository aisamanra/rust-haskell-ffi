#![crate_type = "lib"]

#[no_mangle]
pub extern fn fact(x: u64) -> u64 {
    match x {
        0 => 1,
        _ => x * fact(x-1),
    }
}
