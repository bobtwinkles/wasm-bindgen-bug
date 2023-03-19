use sycamore::builder::prelude::*;
use sycamore::prelude::*;

fn main() {
    println!("Hello, world!");

    sycamore::render(|cx| {
        // Delete any of the attrs to get a working build
        div()
            .attr("a-0", "b")
            .attr("a-1", "b")
            .attr("a-2", "b")
            .attr("a-3", "b")
            .attr("a-4", "b")
            .attr("a-5", "b")
            .attr("a-6", "b")
            .attr("a-7", "b")
            .attr("a-8", "b")
            .dyn_c(move || {
                view! {cx, "a" }
            })
            .view(cx)
    })
}
