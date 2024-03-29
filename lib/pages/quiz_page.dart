import 'package:flutter/material.dart';
import 'package:QuizEmmsu/UI/answer_button.dart';
import 'package:QuizEmmsu/UI/correct_wrong_overlay.dart';
import 'package:QuizEmmsu/UI/question_text.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';


import './score_page.dart';


class QuizPage extends  StatefulWidget{
  @override 
  State createState()=> new QuizPageState() ;
}


class QuizPageState extends  State<QuizPage> {

  Question currentQuestion ;
  Quiz quiz = new Quiz([
    new Question("Ma jumelle s'appelle coriane ", true),
    new Question("Emmsu c'est mon nom", true),
    new Question("bhent a ete cree en 2015 ", false),
    new Question("coriane prefere les talons", false),
    new Question("bhent est une agence de marketing", false),
  ]) ;
  String questionText ;
  int questionNumber ;
  bool isCorrect ;
  bool overlayShouldBeVisible = false ;

  @override 
  void initState(){
    super.initState();
    currentQuestion = quiz.nextQuestion ;
    questionText = currentQuestion.question ;
    questionNumber = quiz.questionNumber ;
  }
   void handleAnswer(bool answer){
     isCorrect = (currentQuestion.answer == answer) ;
     quiz.answer(isCorrect);
     this.setState((){
       overlayShouldBeVisible = true ;
     }) ;
   }

  @override 
  Widget build(BuildContext context){
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true,() =>handleAnswer(true)), //  true bottom
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false,() =>handleAnswer(false)) // false bottom 
           ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
          isCorrect,
          (){
            if(quiz.length == questionNumber){
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder:(BuildContext context)=>new ScorePage(quiz.score,quiz.length)),(Route route)=>route ==null) ;
              return ;
            }
            currentQuestion = quiz.nextQuestion ;
            this.setState((){
              overlayShouldBeVisible = false ;
              questionText = currentQuestion.question ;
              questionNumber = quiz.questionNumber ;
            }) ;
          }
          ) : new Container() 
      ],
    );
  }
} 