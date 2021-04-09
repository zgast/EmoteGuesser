class guessed_counter implements Function {
  static var count = 0;

  call(bool plus, bool reset) {
    if (plus) {
      count++;
    } else if (reset) {
      count = 0;
    }
    return count;
  }
}
