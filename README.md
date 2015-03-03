# Rust-Haskell FFI Example

A lot of Haskell people I've talked to are excited about the prospect of
using Rust as a replacement for C in certain speed-critical or low-level
parts of their application. To that end, and in light of the recent
(as of this writing) Rust 1.0 alpha release, I've shown here a small
example of calling Rust from Haskell.

This contains a single Haskell file and two Rust libraries which Haskell
can call out to.
The first Rust library is contained in `fact.rs` and implements a simple
factorial, which is easier to wrap; the second is contained in `point.rs`
and demonstrates allocating memory in Rust, passing it to Haskell, using
wrapped Rust functions to manipulate it, and finally allowing Haskell's
GC to call back into Rust to free it.

The Rust code  currently makes use of some unstable items. I will attempt
to update these if changes occur. Additionally, some Rust language items
are not usable, e.g. the traditional `println!` interface requires some
initialization on the part of Rust which is never performed, so the
`point.rs` file provides its own `print_safe` function instead, which
goes directly through `stdout()`.

This of course requires GHC and a reasonably recent version of rustc
installed. This version has been tested with GHC versions `7.8.{2,3,4}`
and the following rustc versions:

    1.0.0-dev (14f0942a4 2015-03-03) (built 2015-03-03)

All the examples here I release into the public domain.
