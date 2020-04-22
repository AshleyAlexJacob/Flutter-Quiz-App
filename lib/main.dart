import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'images/logo.png',
        duration: 3000,
        type: AnimatedSplashType.StaticDuration,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xffF6504F),
            title: Center(
                child: Text(
              'Quizzler',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            )),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score_keeper = [];
  void constructAns(int z) {
    setState(() {
      bool ans=quizbrain.lastQuestion();
      if(ans==true){
        Alert(context: context, title: "Quiz Finished", desc: "We are Restarting").show();
        score_keeper.clear();
      }
      else if (z == 1) {
        score_keeper.add(
          Icon(Icons.check, color: Colors.green),
        );
        quizbrain.nextQuestion();
      } else {
        score_keeper.add(
          Icon(
            Icons.close,
            color: mainColor,
          ),
        );
        quizbrain.nextQuestion();

      }
    });
  }

  Color mainColor = Color(0xffF6504F);
  Color n2 = Color(0xff394053);
  QuizBrain quizbrain = QuizBrain();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Question No ${quizbrain.retQuesNo() + 1}',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: mainColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      quizbrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0),
              ),
              textColor: Colors.white,
              splashColor: Colors.green,
              highlightColor: Colors.green,
              color: mainColor,
              //hoverColor: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                InkWell(
                  enableFeedback: false,
                );

                int a = quizbrain.checkAnswer(true);
                constructAns(a);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0),
              ),
              splashColor: Colors.red,
              highlightColor: Colors.red,
              color: mainColor,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                InkWell(
                  enableFeedback: false,
                );
                //The user picked false.
                int b = quizbrain.checkAnswer(true);
                constructAns(b);
              },
            ),
          ),
        ),
        Row(
          children: score_keeper,
        ),
      ],
    );
  }
}
