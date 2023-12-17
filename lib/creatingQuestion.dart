import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_manager/main.dart';

import 'creatingTest.dart';

void main() {
  runApp(const MaterialApp(
      home: CreatingQuestion("Не пришел name_test с прошлой страницы (создания теста)")
  ));
}

class CreatingQuestion extends StatefulWidget {
  const CreatingQuestion(this.test_name, {super.key});
  final String test_name;

  @override
  State<CreatingQuestion> createState() => _CreatingQuestionState(test_name);
}

class _CreatingQuestionState extends State<CreatingQuestion> {

  final String test_name;
  _CreatingQuestionState(this.test_name);

  List _contactTypes = [];
  String ?_currentContactType;
  List<DropdownMenuItem<String>> ?_dropDownMenuItems;
  Map<String, String> index_currentType = {};

  int score = 0;
  String criteria = '';
  String answerText = '';
  String questionText = '';


  int question_counter = 0;
  Map<int, int> questions_answers = {};
  Map<int, TextEditingController> questionControllers = <int, TextEditingController> {};
  Map<String, TextEditingController> answerControllers = <String, TextEditingController> {};
  bool visibilityChanger = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // void getData(){
  //   var response = await Dio().get("http://192.168.1.15:8080/criterion");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Создание вопросов", textAlign: TextAlign.center)),
        backgroundColor: Colors.black45,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
          padding: const EdgeInsets.only(top: 30,  bottom: 20, left: 20, right: 20),
          child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int myindex){
                    return
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: questionControllers[myindex],
                                onFieldSubmitted: (text) {
                                  Dio().post("http://192.168.1.15:8080/question/$test_name", data: {'text': text});        // TODO ПЕРЕДАЧА НАЗВАНИЯ ТЕСТА
                                  questionText = text;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Введите вопрос №${myindex + 1}',
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index){
                                  return
                                    Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white38,
                                                  width: 18.0
                                              ),
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              boxShadow: [const BoxShadow(blurRadius: 5,color: Colors.black38)] // Make rounded corner of border
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Card(
                                                      child: ListTile(
                                                        title: TextFormField(
                                                          onFieldSubmitted: (text){
                                                            answerText = text;
                                                          },
                                                          decoration: InputDecoration(
                                                            labelText: 'Введите ответ №${index + 1}'
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              Visibility(
                                                visible: true,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: DropdownButtonFormField(
                                                        value:  index_currentType["${index}_${myindex}"],
                                                        items: _dropDownMenuItems,
                                                        onChanged: (value) {
                                                          index_currentType["${index}_${myindex}"] = value!;
                                                          criteria = value;
                                                          print("${index}_${myindex}");
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                        TextFormField(
                                                          onFieldSubmitted: (text){

                                                            print(questionText);
                                                            Dio().post("http://192.168.1.15:8080/answer?answer_text=$answerText&criterion_title=$criteria&criterion_score=$text", data: questionText);
                                                          },
                                                          decoration: const InputDecoration(
                                                              labelText: 'Балл'
                                                          ),
                                                        ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                  ],
                                          ),
                                        ),
                                      ],
                                    );
                                },
                                itemCount: questions_answers[myindex],
                            ),
                            const SizedBox(height: 10),
                            FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    questions_answers.update(
                                      myindex,
                                          (value) => ++value,
                                      ifAbsent: () => 1,
                                    );
                                    print(questions_answers);
                                  });
                                },
                                backgroundColor: Colors.green,
                                child: const Text('+ ответ', textAlign: TextAlign.center, textScaleFactor: 0.9)),
                            const SizedBox(height: 25),
                          ],
                        ),
                      );
                  },
                  itemCount: question_counter,
          ),
        ),

      ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              questions_answers[questions_answers.length] = 2;
              question_counter++;
              questionControllers[questions_answers.length] = new TextEditingController();
            });
          },
          splashColor: Colors.grey,
          backgroundColor: Colors.red,
          child: const Text('+ Вопрос', textScaleFactor: 0.7)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat
    );
  }

  Future<void> getData() async {
    var response = await Dio().get("http://192.168.1.15:8080/test/criteria/$test_name");            // TODO ПЕРЕДАЧА ID ТЕСТА
    var jsonTypes = response.data as List;
    setState(() {
      for (int i = 0; i < jsonTypes.length; i++) {
        _contactTypes.add(jsonTypes[i]["title"]);
      }

      List<DropdownMenuItem<String>> items = [];
      for (String city in _contactTypes) {
        items.add(DropdownMenuItem(value: city, child: Text(city)));
        _dropDownMenuItems = items;
        _currentContactType = null;
      }});
  }

  void changedDropDownItem(String? selectedCity) {
    setState(() {
      _currentContactType = selectedCity;
    });
  }
}


