import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage1 extends StatelessWidget{
  const StartPage1({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          // padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:  MainAxisAlignment.center,
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
              Image.asset("images/top.jpeg",scale: 1,),
              Text(
                'welcome tuskmum project',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/swipe.png", scale: 3,),
                  Text(
                    '左にスワイプして開始',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.orbitron(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }
}
