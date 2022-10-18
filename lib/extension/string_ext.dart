extension StringExt on String {
  String toLowerCastUnderScore() => toLowerCase().replaceAll(" ", "_");
}
