// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FourthApi extends StatefulWidget {
  const FourthApi({super.key});

  @override
  State<FourthApi> createState() => _FourthApiState();
}

class _FourthApiState extends State<FourthApi> {

  var data;
  Future<void> getUserApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forth Api'),
      ),
      body: Column(
        children: [
          Expanded(
              child:FutureBuilder(
                future:getUserApi(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Text('Loading');
                  }else{
                    //return Text(data[0]['name'].toString());
                    return  ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          children: [
                            ReusableRow(title: 'Name', value: data[index]['name'].toString()),
                            ReusableRow(title: 'UserName', value: data[index]['username'].toString()),
                            ReusableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                            ReusableRow(title: 'Geo', value: data[index]['address']['geo'].toString()),
                          ],
                        ),
                      );
                    });
                  }
                },
              )
          )
        ],
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title,required this.value });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}