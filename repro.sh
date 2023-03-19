#!/usr/bin/env bash

cargo build --target=wasm32-unknown-unknown
wasm-bindgen --target=web --out-dir=./target/wasm-bindgen/debug/ --out-name=wasm-bindgen-bug ./target/wasm32-unknown-unknown/debug/wasm-bindgen-bug.wasm
