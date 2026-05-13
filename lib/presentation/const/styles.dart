

import 'package:flutter/material.dart';

TextStyle? displayBase(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

TextStyle? headline(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle? caption(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}

TextStyle? subhead(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}
