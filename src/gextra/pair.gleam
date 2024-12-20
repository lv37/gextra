/// Creates a pair with the given value as the first element and `Nil` as the second.
///
/// ## Example
///
/// ```gleam
/// let assert pair.new1(1) = #(1, Nil)
/// ```
pub fn new1(first: a) -> #(a, Nil) {
  #(first, Nil)
}

/// Creates a pair with `Nil` as the first element and the given value as the second.
///
/// ## Example
///
/// ```gleam
/// let assert pair.new2(1) = #(Nil, 1)
/// ```
pub fn new2(second: a) -> #(Nil, a) {
  #(Nil, second)
}

/// Creates a pair with the given value as both the first and second elements.
///
/// ## Example
///
/// ```gleam
/// let assert pair.twin(1) = #(1, 1)
/// ```
pub fn twin(value: a) -> #(a, a) {
  #(value, value)
}

/// Applies the given function to both elements of the pair.
///
/// ## Example
///
/// ```gleam
/// let p = #(1, 2)
/// let assert pair.map(p, fn(x) { x * 2 }) = #(2, 4)
/// ```
pub fn map(pair: #(a, a), map: fn(a) -> b) -> #(b, b) {
  #(map(pair.0), map(pair.1))
}

/// Creates a new pair with the first element replaced by the given value.
///
/// ## Example
///
/// ```gleam
/// let p = #(1, 2)
/// let assert pair.replace_first(p, 3) = #(3, 2)
/// ```
pub fn replace_first(pair: #(a, b), first: c) -> #(c, b) {
  #(first, pair.1)
}

/// Creates a new pair with the second element replaced by the given value.
///
/// ## Example
///
/// ```gleam
/// let p = #(1, 2)
/// let assert pair.replace_second(p, 3) = #(1, 3)
/// ```
pub fn replace_second(pair: #(a, b), second: c) -> #(a, c) {
  #(pair.0, second)
}
