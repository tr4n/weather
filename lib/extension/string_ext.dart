extension StringExt on String {
  String toLowerCastUnderScore() => toLowerCase().replaceAll(" ", "_");

  String takeLast(int n) => length < n || n <= 0 ? this : substring(length - n);

  String take(int n) => length < n || n <= 0 ? this : substring(0, length - n);
}
