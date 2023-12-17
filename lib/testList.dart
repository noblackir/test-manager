import 'dart:convert';
import 'dart:ffi';


import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
      home: TestList()
  ));
}

class TestList extends StatefulWidget {
  const TestList({super.key});

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {

  var jsonTests = [];
  var jsonTypes = [];

  var lichnostnye = [];
  var temperament = [];
  var trevozhnost = [];
  var sovmestimost = [];
  var sostoyanie = [];


  get type_id => null;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(
        children: [
          Center(child: Text('Тест на состояние', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 5),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.white38,
                                    width: 18.0
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black38)] // Make rounded corner of border
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child:
                                      Text(sostoyanie[index]['title'].toString(), style: TextStyle(fontSize: 22)),
                                  ),
                                ),
                                Container(
                                  width: 100.0,
                                  child: FloatingActionButton.extended(
                                    backgroundColor: Color.fromARGB(
                                        255, 255, 77, 77),
                                    heroTag: null,
                                      onPressed: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => PassingTest(sostoyanie[index]['id'].toString())));
                                      },
                                                                                                        // ПЕРЕХОД НА ПРОХОЖДЕНИЕ ТЕСТА
                                      label: Text('Пройти'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ]),
              );
            },
            itemCount: sostoyanie.length,
          ),




          const SizedBox(height: 45),
          Center(child: Text('Тест на тревожность', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 5),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.white38,
                                width: 18.0
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black38)] // Make rounded corner of border
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child:
                                Text(trevozhnost[index]['title'].toString(), style: TextStyle(fontSize: 22)),
                              ),
                            ),
                            Container(
                              width: 100.0,
                              child: FloatingActionButton.extended(
                                backgroundColor: Color.fromARGB(
                                    255, 255, 77, 77),
                                heroTag: null,
                                onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => PassingTest(trevozhnost[index]['id'].toString())));
                                },
                                // ПЕРЕХОД НА ПРОХОЖДЕНИЕ ТЕСТА
                                label: Text('Пройти'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              );
            },
            itemCount: trevozhnost.length,
          ),



          const SizedBox(height: 45),
          Center(child: Text('Тесты на совместимость', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 5),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.white38,
                                width: 18.0
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black38)] // Make rounded corner of border
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child:
                                Text(sovmestimost[index]['title'].toString(), style: TextStyle(fontSize: 22)),
                              ),
                            ),
                            Container(
                              width: 100.0,
                              child: FloatingActionButton.extended(
                                backgroundColor: Color.fromARGB(
                                    255, 255, 77, 77),
                                heroTag: null,
                                onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => PassingTest(sovmestimost[index]['id'].toString())));
                                },
                                // ПЕРЕХОД НА ПРОХОЖДЕНИЕ ТЕСТА
                                label: Text('Пройти'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              );
            },
            itemCount: sovmestimost.length,
          ),





          const SizedBox(height: 45),
          Center(child: Text('Тесты на темперамент', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 5),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.white38,
                                width: 18.0
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black38)] // Make rounded corner of border
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child:
                                Text(lichnostnye[index]['title'].toString(), style: TextStyle(fontSize: 22)),
                              ),
                            ),
                            Container(
                              width: 100.0,
                              child: FloatingActionButton.extended(
                                backgroundColor: Color.fromARGB(
                                    255, 255, 77, 77),
                                heroTag: null,
                                onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => PassingTest(lichnostnye[index]['id'].toString())));
                                },
                                // ПЕРЕХОД НА ПРОХОЖДЕНИЕ ТЕСТА
                                label: Text('Пройти'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              );
            },
            itemCount: lichnostnye.length,
          ),



        ],
      ),
    );
  }




  // ------------------------------------------------
  // ------------------------------------------------
  //            ДАННЫЕ ПО ТЕСТАМ И ТИПАМ
  // ------------------------------------------------
  // ------------------------------------------------
  Future<void> getData() async {

    var response = await Dio().get("http://192.168.1.15:8080/test");
    var responseType = await Dio().get("http://192.168.1.15:8080/type");

    setState(() {
      jsonTests = response.data as List;
      for(var index = 0; index < jsonTests.length; index++) {
        print(jsonTests[index]['id'].toString());
        switch (jsonTests[index]['type']['title']) {
          case 'личностный':
            lichnostnye.add(jsonTests[index]);
            break;
          case 'тревожность':
            trevozhnost.add(jsonTests[index]);
            break;
          case 'темперамент':
            temperament.add(jsonTests[index]);
          case 'совместимость':
            sovmestimost.add(jsonTests[index]);
          case 'состояние':
            sostoyanie.add(jsonTests[index]);
            break;
        }
        jsonTypes = responseType.data as List;
      }
    });
  }
}






// Прохождение теста
class PassingTest extends StatefulWidget {

  const PassingTest(this.testId, {super.key});
  final String testId;

  @override
  State<PassingTest> createState() => _PassingTestState(testId);
}

class _PassingTestState extends State<PassingTest> {

  final String testId;
  _PassingTestState(this.testId);

  bool isLoading = true;
  var index = 1;
  var questionsCount = 0;
  var answerInQuestionCount = 0;
  Map<String, int> answerScore = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading){
      return const Center(
          child: CircularProgressIndicator());
    } else {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Passing test"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 130),
            Text(questionList[questionsCount]['text'].toString(), style: TextStyle(fontSize: 28), textAlign: TextAlign.center),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(14.0),

                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Text(questionList[questionsCount]['answers'][index]['text'].toString(), style: TextStyle(fontSize: 24), textAlign: TextAlign.center)),
                                ],
                              )),
                            onTap: () =>{
                              answerScore[questionList[questionsCount]['answers'][index]['criterion']['title']] =
                              answerScore[questionList[questionsCount]['answers'][index]['criterion']['title']]! + questionList[questionsCount]['answers'][index]['criterionScore'] as int,
                              setState(() {
                                if (questionsCount < jsonQuestions.length - 1)
                                  questionsCount++;
                                else {
                                  Navigator.pop(context,true);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(const Duration(seconds: 2), () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return const AlertDialog(
                                          title: Text('Тест пройден'),
                                        );
                                      }
                                  );
                                  Dio().post("http://192.168.1.15:8080/characteristic/$testId?user_login=${FirebaseAuth.instance.currentUser?.email}", data: answerScore);
                                }
                              }),
                            }
                        ),
                      );
                      },
                      itemCount: counterAnswers[questionsCount + 1],
                  ),
            )
          ],
        ),
      ),
    );
    }
  }



  // - - - - - - - - - - - - - -
  // - - - - - - - - - - - - - -
  // Получение вопросов и ответов
  // - - - - - - - - - - - - - -
  // - - - - - - - - - - - - - -

  var jsonQuestions = [];
  var questionList = [];
  var answers = [];
  Map<int, int> counterAnswers = {};
  Future<void> getData() async {
    var questions = await Dio().get("http://192.168.1.15:8080/question/$testId");
    setState(() {
      jsonQuestions = questions.data as List;
      for(var index = 0; index < jsonQuestions.length; index++) {
        try {
          for(var a = 0; a < 20; a++){
            answers.add(jsonQuestions[index]['answers'][a]);
            counterAnswers[index + 1] = a + 1;
          }
        } catch (e, s) {
          //print(s);
        }
        questionList.add(jsonQuestions[index]);
      }
      });


    // - - - - - - - - - - - - - -
    // - - - - - - - - - - - - - -
    //    ПОИСК КРИТЕРИЕВ ТЕСТА
    // - - - - - - - - - - - - - -
    // - - - - - - - - - - - - - -
    var jsonCriterions = [];
    var criterions = await Dio().get("http://192.168.1.15:8080/test/$testId");
    answerScore.clear();
    setState(() {
      isLoading = false;
      jsonCriterions = criterions.data as List;
      for(var index = 0; index < jsonCriterions.length; index++) {
        answerScore[jsonCriterions[index]['title']] = 0;
      }
    });

  }
}






