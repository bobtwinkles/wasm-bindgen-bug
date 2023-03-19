use std::marker::PhantomData;

struct NonTrivialDrop {}

impl Drop for NonTrivialDrop {
    fn drop(&mut self) {
    }
}

struct Builder<'a, F: FnOnce() -> String + 'a>(F, PhantomData<&'a ()>, NonTrivialDrop);

impl<'a, F: FnOnce() -> String + 'a> Builder<'a, F> {
    fn new(f: F) -> Self {
        Self(f, PhantomData, NonTrivialDrop {})
    }

    fn map(
        self,
        f: impl FnOnce(&String) + 'a,
    ) -> Builder<'a, impl FnOnce() -> String + 'a> {
        Builder::new(move || {
            let el = (self.0)();
            f(&el);
            el
        })
    }

    fn attr(
        self,
        name: &'a str,
        value: impl AsRef<str> + 'a,
    ) -> Builder<'a, impl FnOnce() -> String + 'a> {
        self.map(move |el| {
            let mut el = el.clone();
            el.push_str(name);
            el.push_str(value.as_ref());
        })
    }
}

fn main() {
    let mut b = Builder::new(|| String::new())
        .attr("a-0", "b")
        .attr("a-1", "b")
        .attr("a-2", "b")
        .attr("a-3", "b")
        .attr("a-4", "b")
        .attr("a-5", "b")
        .attr("a-6", "b")
        .attr("a-7", "b")
        .attr("a-8", "b")
        .attr("a-9", "b");

    unsafe {
        // XXX: this is clearly UB, but the point is to generate a huge symbol name, not to write a
        // working program
        core::ptr::drop_in_place(&mut b);
    }
}
