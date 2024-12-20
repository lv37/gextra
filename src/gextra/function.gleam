/// Allows piping into a two argument function in a use statement.
///
/// ## Example
///
/// ```gleam
/// fn main() {
///   use n <- 32
///     |> int.div(2)
///     |> pipe(result.map)
///   let assert 16 = n
/// }
/// ```
pub fn pipe1(func, a) {
  func(a, _)
}

/// Allows piping into a three argument function in a use statement.
pub fn pipe2(func, a, b) {
  func(a, b, _)
}

/// Allows piping into a four argument function in a use statement.
pub fn pipe3(func, a, b, c) {
  func(a, b, c, _)
}

/// Allows piping into a five argument function in a use statement.
pub fn pipe4(func, a, b, c, d) {
  func(a, b, c, d, _)
}

/// Allows piping into a six argument function in a use statement.
pub fn pipe5(func, a, b, c, d, e) {
  func(a, b, c, d, e, _)
}

/// Allows piping into a seven argument function in a use statement.
pub fn pipe6(func, a, b, c, d, e, f) {
  func(a, b, c, d, e, f, _)
}

/// Allows piping into an eight argument function in a use statement.
pub fn pipe7(func, a, b, c, d, e, f, g) {
  func(a, b, c, d, e, f, g, _)
}

/// Allows piping into a nine argument function in a use statement.
pub fn pipe8(func, a, b, c, d, e, f, g, h) {
  func(a, b, c, d, e, f, g, h, _)
}

pub fn hole(func, a) {
  func(a, _)
}

pub fn hole2(func, a) {
  fn(b, c) { func(a, b, c) }
}

pub fn hole3(func, a) {
  fn(b, c, d) { func(a, b, c, d) }
}

pub fn hole4(func, a) {
  fn(b, c, d, e) { func(a, b, c, d, e) }
}

pub fn hole5(func, a) {
  fn(b, c, d, e, f) { func(a, b, c, d, e, f) }
}

pub fn hole6(func, a) {
  fn(b, c, d, e, f, g) { func(a, b, c, d, e, f, g) }
}

pub fn hole7(func, a) {
  fn(b, c, d, e, f, g, h) { func(a, b, c, d, e, f, g, h) }
}

pub fn hole8(func, a) {
  fn(b, c, d, e, f, g, h, i) { func(a, b, c, d, e, f, g, h, i) }
}
