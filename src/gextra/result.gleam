import gextra/function

/// Applies one of two functions depending on whether the result is Ok or Error.
/// If the result is Ok, the `val` function is applied to the value.
/// If the result is Error, the `err` function is applied to the error.
///
/// ## Example
///
/// ```gleam
/// let assert Ok(0) = lazy_map_both(
///   Ok(1),
///   fn(x) { x + 1 },
///   fn(x) { x - 1 },
/// )
///
/// let assert Error(2) = lazy_map_both(
///   Error(1),
///   fn(x) { x + 1 },
///   fn(x) { x - 1 },
/// )
/// ```
pub fn lazy_map_both(
  over r: Result(a, b),
  err err: fn(b) -> c,
  val val: fn(a) -> d,
) -> Result(d, c) {
  case r {
    Ok(v) -> val(v) |> Ok
    Error(e) -> err(e) |> Error
  }
}

/// Applies one of two functions depending on whether the result is Ok or Error.
/// If the result is Ok, the `val` function is applied to the value.
/// If the result is Error, the `err` function is applied to the error.
/// This function differs from `lazy_map_both` in that the `val` function returns a `Result`.
///
/// ## Example
/// ```gleam
/// let assert Ok(0) = lazy_try_both(
///     Ok(1), 
///     fn(a) { a - 1 }, 
///     fn(a) { Ok(a + 1) }
/// )
/// 
/// let assert Error(2) = lazy_try_both(
///   Error(1),
///   fn(a) { a - 1 },
///   fn(a) { Ok(a + 1)},
/// )
///
/// ```
pub fn lazy_try_both(
  over r: Result(a, b),
  err err: fn(b) -> c,
  val val: fn(a) -> Result(d, c),
) -> Result(d, c) {
  case r {
    Ok(v) -> val(v)
    Error(e) -> err(e) |> Error
  }
}

pub fn use_lazy_map_both(over r: Result(a, b), err err: fn(b) -> c) {
  function.pipe2(lazy_map_both, r, err)
}

pub fn try_lazy_map_both(over r: Result(a, b), err err: fn(b) -> c) {
  function.pipe2(lazy_try_both, r, err)
}

/// Maps a Result to another Result. If Ok, applies a function to the contained value. If Error, uses provided value.
///
/// ## Example
/// ```gleam
/// use x <- map_both(Ok(1), 2)
/// let assert Ok(1) = x
///
/// use y <- map_both(Error(1), 2)
/// // never reached
/// ```
pub fn map_both(
  over r: Result(a, b),
  err err: c,
  val val: fn(a) -> d,
) -> Result(d, c) {
  case r {
    Ok(v) -> val(v) |> Ok
    Error(_) -> err |> Error
  }
}

/// If Ok, applies a function to the contained value which returns a result. If Error, uses provided value.
///
/// ## Example
/// ```gleam
/// use x <- try_both(Ok(1), 2)
/// let assert Ok(1) = x
///
/// use y <- try_both(Error(1), 2)
/// // never reached
/// ```
pub fn try_both(
  over r: Result(a, b),
  err err: c,
  val val: fn(a) -> Result(d, c),
) -> Result(d, c) {
  case r {
    Ok(v) -> val(v)
    Error(_) -> err |> Error
  }
}

pub fn use_map_both(over r: Result(a, b), err err: c) {
  function.pipe2(map_both, r, err)
}

pub fn try_map_both(over r: Result(a, b), err err: c) {
  function.pipe2(try_both, r, err)
}
