import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAnswer{
  no,
  yes,
}

class DialogUtil {

  static Future<DialogAnswer?> showPreventPopErrorDialog({
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
        child: CupertinoAlertDialog(
          title: title == null ? null : Text(title),
          content: content == null ? null : Text(content),
          actions: actions ?? <Widget>[
            TextButton(
              child: const Text(
                "OK",
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
}