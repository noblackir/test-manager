import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              SizedBox(height: 150),
              Text("Sign up", style: TextStyle(fontSize: 30)),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter email',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter password',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: ()=>{
                  signUpUser()
                },
                child: const Text("Registration"),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Go to login"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser() async{
    setState(() async {
      if(passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
        Dio().post("http://192.168.1.15:8080/lowUser", data: {'login': emailController.text, 'password': passwordController.text});
      } else {
        print("diff pass");
      }
    });
  }
}