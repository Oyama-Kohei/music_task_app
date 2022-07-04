import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAnswer{
  no,
  yes,
}

class DialogUtil {

  static Future<DialogAnswer?> showPreventPopDialog({
    required BuildContext context,
    String? title,
    String? content,
    List<Widget>? actions,
    Function()? onPressed,
  }) {
    return showDialog<DialogAnswer?>(
      context: context,
      builder: (context) =>
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: title == null ? null : Text(title),
          content: content == null ? null : Text(content),
          actions: actions ?? <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: onPressed ?? () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )
    );
  }
  static Future<dynamic> showPreventPopErrorDialog({
    required BuildContext context,
    String? title,
    String? content,
    List<Widget>? actions,
    Function()? onPressed,}) {
    return showPreventPopDialog(
      context: context,
      title: title,
      content: content,
      actions: actions,
      onPressed: onPressed,
    );
  }

  static Future<DialogAnswer?> showPreventPopSelectDialog({
    required BuildContext context,
    String? title,
    String? content,
    List<Widget>? actions,
    Function()? onPressed,}) {
    return showPreventPopDialog(
      context: context,
      title: title,
      content: content,
      onPressed: onPressed,
      actions: <Widget>[
        SimpleDialogOption(
          child: const Text(
            "Cancel",
            textAlign: TextAlign.center,
          ),
          onPressed: () => {
            // Navigator.pop(context, DialogAnswer.no)
          },
        ),
        SimpleDialogOption(
          child: const Text(
            "OK",
            textAlign: TextAlign.center,
          ),
          onPressed: () => {
            // Navigator.pop(context, DialogAnswer.yes)
          },
        ),
      ],
    );
  }
}