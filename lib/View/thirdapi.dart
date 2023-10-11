import 'dart:convert';

import 'package:f1/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThirdApi extends StatefulWidget {
  const ThirdApi({super.key});

  @override
  State<ThirdApi> createState() => _ThirdApiState();
}

class _ThirdApiState extends State<ThirdApi> {

  List<UserModel> userList = [];
  // in this the future model is made by the json to dart plugin and in the 4th api we will make it manually if complex jason cannot be made by the plugins.
  Future<List<UserModel>> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        //print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Api'),
      ),
      body: Column(
        children: [
          Expanded( 
              child:FutureBuilder(
                future: getUserApi(),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                  if(!snapshot.hasData){
                    return const CircularProgressIndicator();
                  }else{
                    return ListView.builder(
                        itemCount:userList.length,
                        itemBuilder: (context, index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                  ReusableRow(title: 'username', value: snapshot.data![index].username.toString()),
                                  ReusableRow(title: 'email', value: snapshot.data![index].email.toString()),
                                  //ReusableRow(title: 'address', value: '${snapshot.data![index].address!.city}\nl at${snapshot.data![index].address!.geo!.lat}'),
                                  ReusableRow(title: 'address', value: '${snapshot.data![index].address!.city}\n lat${snapshot.data![index].address!.geo!.lat}\n lng${snapshot.data![index].address!.geo!.lng}'),
                                  //ReusableRow(title: 'address', value: snapshot.data![index].address!.city.toString()+'\n lat'+snapshot.data![index].address!.geo!.lat.toString())
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
          ),
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
