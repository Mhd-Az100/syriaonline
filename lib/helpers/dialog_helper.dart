import '../dialogs/rate_dialog.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static rate(context) =>
      showDialog(context: context, builder: (context) => RateDialog());
}
