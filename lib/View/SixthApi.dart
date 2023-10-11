import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

// sign up and login page with push api

class SixthApi extends StatefulWidget {
  const SixthApi({super.key});

  @override
  State<SixthApi> createState() => _SixthApiState();
}

class _SixthApiState extends State<SixthApi> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async{
    try{
      Response response = await post(
         Uri.parse('https://reqres.in/api/register'),
        //Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        data;
        //print(data);
        //print(data['token']);
        //print('Account Created Successfully');
      }else{
        //print('failed');
      }
    }catch(e){
      //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sixth api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(),passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text('Signup')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
