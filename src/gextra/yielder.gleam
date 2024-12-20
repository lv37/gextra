import gleam/yielder.{type Yielder, Done, Next}

pub fn try_next(it: Yielder(a), cb: fn(a) -> Nil) {
  case yielder.step(it) {
    Next(a, it) -> {
      cb(a)
      it
    }
    Done -> it
  }
}
