import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';


void main() {
  runApp(const MaterialApp(
      home: UserStatistic()
  ));
}

class UserStatistic extends StatefulWidget {
  const UserStatistic({super.key});

  @override
  State<UserStatistic> createState() => _UserStatisticState();
}

class _UserStatisticState extends State<UserStatistic> {
  bool isLoading = true;

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
      body:
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text("Личностные показатели", style: TextStyle(fontSize: 24)),
              Row(
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 200),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.6,
                      child: Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: PieChart(
                              swapAnimationCurve: Curves.easeIn,
                              swapAnimationDuration: const Duration(seconds: 1),
                              PieChartData(
                                  sections: [
                                    if (jsonMapPoints["холерик"] != null)
                                    PieChartSectionData(
                                      value: jsonMapPoints["холерик"].toDouble(),
                                      color: Color.fromARGB(255, 255, 195, 0),
                                    ),
                                    if (jsonMapPoints["меланхолик"] != null)
                                    PieChartSectionData(
                                      value: jsonMapPoints["меланхолик"].toDouble(),
                                      color: Color.fromARGB(255, 255, 58, 242),
                                    ),
                                    if (jsonMapPoints["флегматик"] != null)
                                    PieChartSectionData(
                                      value: jsonMapPoints["флегматик"].toDouble(),
                                      color: Color.fromARGB(255, 0, 255, 42),
                                    ),
                                    if (jsonMapPoints["сангвинник"] != null)
                                    PieChartSectionData(
                                      value: jsonMapPoints["сангвинник"].toDouble(),
                                      color: Color.fromARGB(255, 33, 150, 243),
                                    )
                                  ]
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (jsonMapPoints["холерик"] != null || jsonMapPoints["меланхолик"] != null || jsonMapPoints["флегматик"] != null || jsonMapPoints["сангвинник"] != null)
                  // ИНДИКАТОРЫ ДИАГРАММЫ
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Indicator(
                          color: Color.fromARGB(255, 255, 195, 0),
                          text: 'Холерик',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color.fromARGB(255, 255, 58, 242),
                          text: 'Меланхолик',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color.fromARGB(255, 0, 255, 42),
                          text: 'Флегматик',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color.fromARGB(255, 33, 150, 243),
                          text: 'Сангвинник',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left:24,top:0,right:24,bottom:0),
                child: Column(
                  children: [
                    if (jsonMapPoints["холерик"] != null)
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: const Column(
                          children: [
                            Text("ХОЛЕРИК", textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                            SizedBox(height: 5),
                            Text("сильный, неуравновешенный, подвижный, с преобладанием возбуждения («безудержный»)", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                          ],
                        )),
                    SizedBox(height: 10),
                    if (jsonMapPoints["меланхолик"] != null)
                      Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: const Column(
                      children: [
                        Text("МЕЛАНХОЛИК", textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                        SizedBox(height: 5),
                        Text("слабый, неуравновешенный, малоподвижный («слабый»)", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                      ],
                      )),
                    SizedBox(height: 10),
                    if (jsonMapPoints["флегматик"] != null)
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: const Column(
                            children: [
                              Text("ФЛЕГМАТИК", textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                              SizedBox(height: 5),
                              Text("сильный, уравновешенный, инертный (малоподвижный) («спокойный»)", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                            ],
                          )),
                    SizedBox(height: 10),
                    if (jsonMapPoints["сангвинник"] != null)
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: const Column(
                            children: [
                              Text("САНГВИНИК", textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                              SizedBox(height: 5),
                              Text("сильный, уравновешенный, подвижный («живой»)", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                            ],
                          )),
                  ],
                ),
              ),






              const SizedBox(height: 40),
              Text("Показатели совместимости с коллективом", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 12),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 200),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.6,
                    child: Visibility(
                      visible: true,
                      child: PieChart(
                          PieChartData(
                              sections: [
                                if (jsonMapPoints["совместим"] != null)
                                PieChartSectionData(
                                  value: jsonMapPoints["совместим"].toDouble(),
                                  color: Colors.blueAccent,
                                ),
                                if (jsonMapPoints["несовместим"] != null)
                                PieChartSectionData(
                                  value: jsonMapPoints["несовместим"].toDouble(),
                                  color: Colors.redAccent,
                                ),
                              ]
                          )
                      ),
                    ),
                  ),
                ),
                // ИНДИКАТОРЫ ДИАГРАММЫ
                if (jsonMapPoints["совместим"] != null || jsonMapPoints["несовместим"] != null)
                const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Colors.blueAccent,
                        text: 'Совместим',
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.red,
                        text: 'Несовместим',
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 28,
                ),
              ],),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left:24,top:0,right:24,bottom:0),
                child: Column(
                  children: [
                    if (jsonMapPoints["совместим"] != null)
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: const Column(
                            children: [
                              Text("СОВМЕСТИМ", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text("Вы прекрасно ладите со своим коллективом!", textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                            ],
                          )),
                    SizedBox(height: 10),
                    if (jsonMapPoints["несовместим"] != null)
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: const Column(
                            children: [
                              Text("НЕСОВМЕСТИМ", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text("Ваше окружение коллег вам не подходит", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                            ],
                          )),
                    SizedBox(height: 10),
                            ],
                          )),




              SizedBox(height: 40),
              Text("Показатели тревожности", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
              SizedBox(height: 10),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 8),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 230),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.7,
                    child: Visibility(
                      visible: (jsonMapPoints["тревожность"] != null),
                      child:
                      BarChart(BarChartData(
                          borderData: FlBorderData(
                              border: const Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              )),
                          // add bars
                          barGroups: [
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(toY: 20, width: 10, color: Color.fromARGB(255, 255, 71, 71)),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(toY: 15, width: 10, color: Color.fromARGB(200, 255, 147, 24)),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(toY: 7, width: 10, color: Color.fromARGB(200, 0, 240, 14)),
                            ]),
                            BarChartGroupData(x: 4, barRods: [
                              BarChartRodData(toY: 15, width: 10, color: Color.fromARGB(200, 0, 159, 245)),
                            ]),
                          ])),
                    ),
                    ),
                  ),

                // ИНДИКАТОРЫ ДИАГРАММЫ
                if (jsonMapPoints["тревожность"] != null)
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: Color.fromARGB(255, 255, 71, 71),
                          text: 'Высокая \n тревожность',
                          isSquare: false,
                        ),
                        SizedBox(height: 5),
                        Indicator(
                          color: Color.fromARGB(200, 255, 147, 24),
                          text: 'Средняя \n тревожность',
                          isSquare: false,
                        ),
                        SizedBox(height: 5),
                        Indicator(
                          color: Color.fromARGB(200, 0, 240, 14),
                          text: 'Низкая \n тревожность',
                          isSquare: false,
                        ),
                        SizedBox(height: 5),
                        Indicator(
                          color: Color.fromARGB(200, 0, 159, 245),
                          text: 'Ваш уровень \n тревоги',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  width: 28,
                ),
              ],),

              Padding(
                  padding: EdgeInsets.only(left:24,top:0,right:24,bottom:0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      if (jsonMapPoints["тревожность"] != null)
                        Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: const Column(
                              children: [
                                Text("Низкий уровень тревожности – от 0 до 7 баллов", textAlign: TextAlign.center),
                              ],
                            )),
                      SizedBox(height: 10),
                      if (jsonMapPoints["тревожность"] != null)
                        Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: const Column(
                              children: [
                                Text("Средний уровень тревожности – от 8 до 15 баллов", textAlign: TextAlign.center),
                              ],
                            )),
                      SizedBox(height: 10),
                      if (jsonMapPoints["тревожность"] != null)
                        Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: const Column(
                              children: [
                                Text("Высокий уровень тревожности – от 16 до 20 балла", textAlign: TextAlign.center),
                              ],
                            )),
                      SizedBox(height: 10),
                    ],
                  )),





              SizedBox(height: 40),
              Text("Состояние личности", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
              SizedBox(height: 20),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 12),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 200),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.6,
                    child: Visibility(
                      visible: true,
                      child: PieChart(
                          PieChartData(
                              sections: [
                                if (jsonMapPoints["удовлетворен"] != null)
                                  PieChartSectionData(
                                    value: jsonMapPoints["удовлетворен"].toDouble(),
                                    color: Colors.greenAccent,
                                  ),
                                if (jsonMapPoints["неудовлетворен"] != null)
                                  PieChartSectionData(
                                    value: jsonMapPoints["неудовлетворен"].toDouble(),
                                    color: Colors.orangeAccent,
                                  ),
                                if (jsonMapPoints["проблемы"] != null)
                                  PieChartSectionData(
                                    value: jsonMapPoints["проблемы"].toDouble(),
                                    color: Colors.redAccent,
                                  ),
                              ]
                          )
                      ),
                    ),
                  ),
                ),
                // ИНДИКАТОРЫ ДИАГРАММЫ
                if (jsonMapPoints["удовлетворен"] != null || jsonMapPoints["неудовлетворен"] != null || jsonMapPoints["проблемы"] != null)
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: Colors.greenAccent,
                          text: 'Удовлетворен \n жизнью',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Indicator(
                          color: Colors.orangeAccent,
                          text: 'Неудовлетворен \n жизнью',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Indicator(
                          color: Colors.redAccent,
                          text: 'Сильные \n проблемы',
                          isSquare: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  width: 28,
                ),
              ],),

              Padding(
                  padding: EdgeInsets.only(left:24,top:0,right:24,bottom:0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      if (jsonMapPoints["удовлетворен"] != null || jsonMapPoints["неудовлетворен"] != null || jsonMapPoints["проблемы"] != null)
                        Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: const Column(
                              children: [
                                Text("Оценка показателей теста производится самостоятельно", textAlign: TextAlign.center),
                              ],
                            )),
                      SizedBox(height: 15),
                    ],
                  )
              ),
            ],
          ),
        )
      );
    }
  }

  Map<String, dynamic> jsonMapPoints = {};
  Future<void> getData() async {
    var mapPoints = await Dio().get("http://192.168.1.15:8080/characteristic/${FirebaseAuth.instance.currentUser?.email}");
    setState(() {
      isLoading = false;
      jsonMapPoints = mapPoints.data as Map<String, dynamic>;
    });
  }

}


