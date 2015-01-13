# Rust-Haskell FFI Example

This contains a single Haskell file and two Rust libraries which it wraps.
The first Rust library is contained in `fact.rs` and implements a simple
factorial, which is easier to wrap; the second is contained in `point.rs`
and demonstrates allocating memory in Rust, passing it to Haskell, using
wrapped Rust functions to manipulate it, and finally allowing Haskell's
GC to call back into Rust to free it.

This of course requires GHC and a reasonably recent version of rustc
installed. This has been tested with GHC versions `7.8.{2,3,4}` and rustc
version `1.0.0-nightly (4bed1e8c0 2015-01-12 000:21:32 +0000)`.
