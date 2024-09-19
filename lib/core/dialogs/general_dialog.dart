import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomDialog(BuildContext context,
    {required Widget child, bool barrierDismissible = true}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => child,
  );
}
