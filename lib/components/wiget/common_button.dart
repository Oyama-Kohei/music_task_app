import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.padding,
      // this.isStartButton = false,
      this.useIcon = false})
      : super(key: key);

  final String text;
  final GestureTapCallback onPressed;
  final EdgeInsetsGeometry padding;
  // final bool isStartButton;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black54,
              shape: const StadiumBorder(),
              side: const BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                    visible: useIcon,
                    //戻るボタン
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.transparent)),
                Expanded(
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // color: isStartButton
                      //     ? Colors.white
                      //     :CommonColors.primaryColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: useIcon,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
