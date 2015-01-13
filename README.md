# Rust-Haskell FFI Example

This contains a single Haskell file and two Rust libraries which it wraps.
The first Rust library is contained in `fact.rs` and implements a simple
factorial, which is easier to wrap; the second is contained in `point.rs`
and demonstrates allocating memory in Rust, passing it to Haskell, using
wrapped Rust functions to manipulate it, and finally allowing Haskell's
GC to call back into Rust to free it.

The Rust code  currently makes use of some unstable items. I will attempt
to update these if changes occur.

This of course requires GHC and a reasonably recent version of rustc
installed. This version has been tested with GHC versions `7.8.{2,3,4}`
and the following rustc versions:

    1.0.0-dev (b5571ed71 2015-01-09 17:35:11 +0000)
    1.0.0-nightly (4bed1e8c0 2015-01-12 000:21:32 +0000)
