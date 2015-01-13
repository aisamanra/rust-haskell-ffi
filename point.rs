#![crate_type = "lib"]
#![feature(trace_macros)]

// The println! macro depends on thread-local storage, which Haskell/C
// have probably not initialized. (Or, rather, the std::io interface
// does, which means that instead I print using this small helper
// function instead
fn print_safe(s: &str) {
    std::io::stdio::stdout().write(s.as_bytes());
}

// We aren't exposing the internals of this, so I don't bother giving it
// a C representation.
pub struct Point {
    x: u64,
    y: u64,
}

// Rust-land functions...
impl Point {
    fn new(x: u64, y: u64) -> Point {
        Point { x: x, y: y }
    }

    fn add_mut(&mut self, p: &Point) {
        self.x = self.x + p.x;
        self.y = self.y + p.y;
    }
}

// What we're doing here is a little bit unsafe---by exposing
// these elsewhere, we effectively transfer the 'ownership' out
// of Rust-land. In this case, we'll have a corresponding free
// function which takes ownership back again.
#[no_mangle]
pub extern fn mk_point(x: u64, y: u64) -> Box<Point> {
    Box::new(Point::new(x, y))
}

// We free something in Rust by… taking ownership of it and doing nothing.
#[no_mangle]
pub extern fn free_point(_: Box<Point>) {}

// Wrap our add_mut method for exporting.
#[no_mangle]
pub extern fn add_point(p1: &mut Point, p2: &Point) {
    p1.add_mut(p2);
}

// Wrap our print method for exporting.
#[no_mangle]
pub extern fn print_point(p: &Point) {
    print_safe(format!("Point(x={}, y={})\n", p.x, p.y).as_slice());
}
