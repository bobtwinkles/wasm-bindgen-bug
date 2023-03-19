#!/usr/bin/env bash

cargo build --target=wasm32-unknown-unknown --bin good
cargo build --target=wasm32-unknown-unknown --bin bad

wasm-bindgen \
  --target=web \
  --out-dir=./target/wasm-bindgen/debug/ \
  --out-name=wasm-bindgen-bug-good \
  ./target/wasm32-unknown-unknown/debug/good.wasm

wasm-bindgen \
  --target=web \
  --out-dir=./target/wasm-bindgen/debug/ \
  --out-name=wasm-bindgen-bug-bad \
  ./target/wasm32-unknown-unknown/debug/bad.wasm
