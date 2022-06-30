extension StringFormatting on String {
  String formatPhoneNumber() {
    if (this.contains('+84')) return this.replaceAll('+84', '0');
    return this;
  }
}
