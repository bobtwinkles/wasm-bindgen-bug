Demonstrates a bug in (probably?) `wasm-bindgen` where having too many attributes on a `sycamore::builder::ElementBuilder` will result in a module that `wasm-bindgen` will think doesn't have a `start` section.
Without a `start` section, `__wbindgen_start()` isn't generated so `finalizeInit` in the resulting javascript module will never call the Rust `main`.
To reproduce, use `bash ./repro.sh`. To se it working, edit `src/main.rs` to add fewer attributes to the builder.
