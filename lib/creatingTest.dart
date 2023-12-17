import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'creatingQuestion.dart';

void main() {
  runApp(const MaterialApp(
      home: CreatingTest()
  ));
}

class CreatingTest extends StatefulWidget {
  const CreatingTest({super.key});

  @override
  State<CreatingTest> createState() => _CreatingTestState();
}

class _CreatingTestState extends State<CreatingTest> {
  final testNameController = TextEditingController();
  int _count = 0;
  List list = [];
  int test_id = -1;
  String testName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos = List.generate(_count, (int i) => ContactRow(testName));
    return Scaffold(
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: LayoutBuilder(builder: (context, constraint) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    TextFormField(
                      controller: testNameController,
                      onFieldSubmitted: (text) {
                        setState(() {
                          Dio().post("http://192.168.1.15:8080/test", data: {'title': text});
                          testName = text;
                          _count ++;
                        });
                        },
                      decoration: const InputDecoration(
                        labelText: 'Название теста',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    const Text("Тип теста"),
                    DropdownButtonFormField(
                      value: _currentContactType,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Container(
                      height: 230.0,
                      child: ListView(
                        children: _contatos,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addNewContactRow,
                      child: Text("Add Criteria")
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: ()=>{
                        goPush(),
                      },
                      child: Text("Go to questions"),
                    ),
                  ],
                ),
              );
            }),
          ),
        ));
  }

  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
    });
  }

  List _contactTypes = [];
  List<DropdownMenuItem<String>> ?_dropDownMenuItems;
  String ?_currentContactType;

  Future<void> getData() async {
    var response = await Dio().get("http://192.168.1.15:8080/type");
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
    Dio().post("http://192.168.1.15:8080/test/$testName/type/$_currentContactType");
  }

  goPush() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreatingQuestion(testName))).then((_) => setState(() {
            testNameController.text = "";
            _currentContactType = null;
            _count = 0;
          }));

    });
  }
}

class ContactRow extends StatefulWidget {
  final String testName;
  const ContactRow(this.testName, {super.key});

  @override
  State<StatefulWidget> createState() => _ContactRow(testName);
}
class _ContactRow extends State<ContactRow> {
  final String testName;
  _ContactRow(this.testName);

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110.0,
        padding: const EdgeInsets.all(5.0),
        child: Column(children: <Widget>[
          const Text("Критерий теста"),
          DropdownButtonFormField(
            value: _currentContactType,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
          ),
        ]));
  }


  List _contactTypes = [];
  List<DropdownMenuItem<String>> ?_dropDownMenuItems;
  String ?_currentContactType;
  Future<void> getData() async {
    var response = await Dio().get("http://192.168.1.15:8080/criterion");
    var jsonCriterions = response.data as List;
    setState(() {
      for (int i = 0; i < jsonCriterions.length; i++) {
        _contactTypes.add(jsonCriterions[i]["title"]);
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
    Dio().post("http://192.168.1.15:8080/test/$testName/$_currentContactType");
    print(testName);
  }
}


