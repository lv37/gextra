import gleam/bit_array
import gleam/float
import gleam/int
import gleam/io
import gleam/result
import gleam/string

pub fn try_lazy_replace(
  r: Result(a, b),
  cb: fn(a) -> Result(c, e),
  err: fn(b) -> d,
  err2: fn(e) -> d,
) -> Result(c, d) {
  case r {
    Ok(ok) -> {
      case cb(ok) {
        Ok(ok) -> Ok(ok)
        Error(e) ->
          e
          |> err2
          |> Error
      }
    }
    Error(e) ->
      e
      |> err
      |> Error
  }
}

pub fn try_replace(
  r: Result(a, b),
  cb: fn(a) -> Result(c, e),
  err: d,
) -> Result(c, d) {
  try_lazy_replace(r, cb, fn(_) { err }, fn(_) { err })
}

pub fn use_try_replace(a, err) {
  pipe(a, fn(b, c) { try_replace(b, c, err) })
}

pub fn use_try_lazy_replace(r: Result(a, b), err: fn(b) -> d, err2: fn(c) -> d) {
  pipe(r, fn(r, c) { try_lazy_replace(r, c, err, err2) })
}



pub fn use_lazy_unwrap(a) {
  pipe(a, result.lazy_unwrap)
}

pub fn use_try_recover(a) {
  pipe(a, result.try_recover)
}

pub fn pipe(a, func) {
  func(a, _)
}

pub fn assert_ok(r: Result(a, b)) {
  let assert Ok(k) = r
  k
}

pub fn defer(defered) {
  fn(scope) {
    let ret = scope()
    defered(ret)
    ret
  }
}

pub fn try_if(
  condition: Bool,
  if_cb: fn() -> a,
  else_cb: fn() -> b,
) -> Result(a, b) {
  case condition {
    True -> if_cb() |> Ok
    False -> else_cb() |> Error
  }
}

pub fn try_if_pipe(
  condition: Bool,
  if_cb: fn() -> a,
) -> fn(fn() -> b) -> Result(a, b) {
  case condition {
    True -> fn(_) { if_cb() |> Ok }
    False -> fn(else_cb) { else_cb() |> Error }
  }
}

pub fn if_pipe(condition: Bool, if_cb: fn() -> a) {
  case condition {
    True -> fn(_) { if_cb() }
    False -> fn(else_cb) { else_cb() }
  }
}

fn if_else(condition: Bool, if_cb: fn() -> a, else_cb: fn() -> a) {
  case condition {
    True -> if_cb()
    False -> else_cb()
  }
}

fn iff(condition: Bool, if_cb: fn() -> a, rest_cb: fn() -> a) {
  case condition {
    True -> {
      if_cb()
      Nil
    }
    _ -> Nil
  }
  rest_cb()
}

fn do_fori(n: Int, acc: a, cb: fn(a, Int) -> a, i: Int) -> a {
  case i < n {
    True ->
      cb(acc, i)
      |> do_fori(n, _, cb, i + 1)
    False -> acc
  }
}

pub fn fori(n, acc, cb) {
  do_fori(n, acc, cb, 0)
}

pub fn random_base64(len: Int) -> String {
  fori(len / 12 + 1, "", fn(s, _) {
    int.random(1_899_113_155_438_425_819) + 131_621_703_842_267_136
    |> int.to_base36
    |> string.append(s)
  })
  |> string.slice(0, len)
}
