/// Map a boolean value to one of two values.
///
/// ## Example
///
/// ```gleam
/// let assert 1 = bool.map(True, 1, 2)
/// let assert 2 = bool.map(False, 1, 2)
/// ```
pub fn map(condition cond: Bool, true true: a, false false: a) -> a {
  case cond {
    True -> true
    False -> false
  }
}

/// Map a boolean value to the result of one of two functions.
/// The function corresponding to the boolean value will be called, and the other will not.
///
/// ## Example
///
/// ```gleam
/// let assert 1 = bool.lazy_map(True, fn() { 1 }, fn() { 2 })
/// let assert 2 = bool.lazy_map(False, fn() { 1 }, fn() { 2 })
/// ```
@deprecated("Use stdlib bool.lazy_guard()")
pub fn lazy_map(condition: Bool, if_cb: fn() -> a, else_cb: fn() -> a) -> a {
  case condition {
    True -> if_cb()
    False -> else_cb()
  }
}
