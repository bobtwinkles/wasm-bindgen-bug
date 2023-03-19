#!/usr/bin/env bash

cargo clean

cargo build --target=wasm32-unknown-unknown --bin good
cargo build --target=wasm32-unknown-unknown --bin baad

wasm-bindgen \
  --target=web \
  --out-dir=./target/wasm-bindgen/debug/ \
  --out-name=wasm-bindgen-bug-baad \
  ./target/wasm32-unknown-unknown/debug/baad.wasm

wasm-bindgen \
  --target=web \
  --out-dir=./target/wasm-bindgen/debug/ \
  --out-name=wasm-bindgen-bug-good \
  ./target/wasm32-unknown-unknown/debug/good.wasm

echo '--- begin test ---'
echo "--- if you see only a single __wbindgen_start call, that's bad"

grep wbindgen_start ./target/wasm-bindgen/debug/*.js

echo '--- done ---'
