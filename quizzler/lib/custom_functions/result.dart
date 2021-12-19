String getEmoji(int val) {
  String path = 'assets/svg/';
  if (val >= 80) {
    return '${path + 'lovely.svg'}';
  } else if (val >= 60) {
    return '${path + 'not_bad.svg'}';
  } else if (val >= 40) {
    return '${path + 'tooth_crunch.svg'}';
  } else if (val >= 20) {
    return '${path + 'cry.svg'}';
  } else {
    return '${path + 'total_fail.svg'}';
  }
}
