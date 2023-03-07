
import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';


void showAlertDialog(BuildContext context, String title, String desc,String btnName,String keyToRoute,String data, bool dismiss) {
  _showAlertDialog(context, title, desc, btnName, keyToRoute,data, dismiss);
}

void _showAlertDialog(BuildContext context, String title, String desc, String btnName,String keyToRoute,String data, bool dismiss) {
  showDialog(
    context: context,
    barrierDismissible: dismiss,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        description: desc,
        btnName: btnName,
        keyToRoute: keyToRoute,
        data: data,
      );
    },
  );
}

void showSnackBar(BuildContext context, String message) {
  _showSnackBar(context, message);
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
  );
}
