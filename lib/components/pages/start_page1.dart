import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage1 extends HookWidget{
  const StartPage1({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'tuskMum',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.orbitron(
                            color: Colors.blueGrey,
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image.asset("images/top.jpeg",scale: 1,),
                      ),
                    ]
                  ),
                ),
              Text(
                '本アプリは今までにない\nよりシンプルなカレンダーアプリ',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Row(
                      children: [
                        Image.asset("images/swipe.png", scale: 3,),
                        Text(
                          "左にスワイプして開始",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.orbitron(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}