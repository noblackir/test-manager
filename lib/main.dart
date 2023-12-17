import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_manager/auth_page.dart';
import 'package:test_manager/creatingQuestion.dart';
import 'package:test_manager/creatingTest.dart';
import 'package:test_manager/testList.dart';
import 'package:test_manager/userStatistic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
      home: Main()
  ));
}

class Main extends StatefulWidget {
  const Main({super.key});
  @override
  State<Main> createState() => _MainState();
}



class _MainState extends State<Main> {
  int index = 0;
  bool isAdmin = false;
  bool gotRole = false;

  @override
  void initState() {
    super.initState();
  }

  final screens = [
    const UserStatistic(),
    const CreatingTest(),
    const TestList(),
    // const CreatingQuestion("")
  ];

  @override
  Widget build(BuildContext context){
    if (!gotRole){
      gotRole = true;
      getRole();
    }
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: signOutUser,
                icon: Icon(Icons.logout, size: 30,),
                color: Colors.red[600],

            )
          ],
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.blueAccent,
          height: 55,
          selectedIndex: index,
          onDestinationSelected: (index) =>
              setState(() => this.index = index),
          destinations: [
            const NavigationDestination(
                icon: Icon(Icons.info_outline, color: Colors.white),
                label: 'Statistic'),
            Visibility(
              child:
              NavigationDestination(
                  icon: Icon(Icons.add, color: Colors.white),
                  label: 'New test'),
              visible: isAdmin,
            ),
            NavigationDestination(
                icon: Icon(Icons.table_chart_sharp, color: Colors.white),
                label: 'Tests'),
          ],
        ),
      );
    } else {
      return AuthPage();
    }
  }

  void signOutUser() {
    setState(() {
      FirebaseAuth.instance.signOut();
    });
  }

  Future<bool> getRole() async{
    var response = await Dio().get("http://192.168.1.15:8080/lowUser/${FirebaseAuth.instance.currentUser?.email}");
    setState(() {
      if (response.toString() == "ADMIN"){
        isAdmin = true;
      } else {
        isAdmin = false;
      }
      print(response.toString());
      print(isAdmin);
    });

    return isAdmin;
  }
}

