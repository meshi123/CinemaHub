class Ticker {
  Stream<void> tick({Duration? duration}) async* {
    duration ??= const Duration(seconds: 1);

    yield null; // Trigger the callback immediately

    await for (var _ in Stream.periodic(
      duration,
      (x) => x + 1,
    )) {
      yield null; // Emit a value for each tick
    }
  }
}
