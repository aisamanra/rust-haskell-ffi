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

This of course requires GHC and a reasonably recent version of rustc
installed. This version has been tested with GHC versions `7.8.4` and
`7.10.1`, and the following rustc versions:

    1.0.0 (a59de37e9 2015-05-13) (built 2015-05-14)

All the examples here I release into the public domain.
