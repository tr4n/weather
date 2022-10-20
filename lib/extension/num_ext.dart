extension NumberExt on num {
  String shorten() {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return toString().replaceAll(regex, '');
  }
}
