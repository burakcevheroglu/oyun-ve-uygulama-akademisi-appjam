String capitalize(String input) {
  return input.split(' ')
      .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
      .join(' ');
}
// strindeki tüm kelimelerin ilk harfini büyük yap