String? firstLetters(String? text) {
  if (text == null) return null;
  List<String> words = text.split(' ');
  String initials = '';

  for (var word in words) {
    if (word.isNotEmpty) {
      initials += word[0];
    }
  }
  return initials;
}
