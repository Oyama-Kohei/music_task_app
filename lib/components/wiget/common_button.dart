import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';

class CommonButton extends StatelessWidget{

  //todo: これだとだめなのか？finalでの記載が必要な理由は？
  // var text;
  // var onPressed;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.padding,
    this.isStartButton = false,
    this.useIcon = false
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool isStartButton;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor:
              isStartButton ? CommonColors.primaryColor : Colors.white,
            shape: const StadiumBorder(),
            side: const BorderSide(
              color: CommonColors.primaryColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: useIcon,
                //戻るボタンとか
                child: const Icon(Icons.arrow_forward,
                color: Colors.transparent)
              ),
              Expanded(
                child: AutoSizeText(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isStartButton
                        ? Colors.white
                        :CommonColors.primaryColor,
                  ),
                ),
              ),
              Visibility(
                visible: useIcon,
                child: Icon(
                  Icons.arrow_forward,
                  color: isStartButton
                      ? Colors.white
                      :CommonColors.primaryColor,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
