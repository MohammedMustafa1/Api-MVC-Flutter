import 'dart:convert';
import 'package:f1/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context , snapshot){
                if(!snapshot.hasData){
                  return const Text('Loading');
                }else{
                  return  ListView.builder(
                    itemCount: postList.length,
                      itemBuilder: (context, index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title\n${postList[index].title}'), //interpolation
                              Text('Description\n'+postList[index].body.toString()), //concatination
                            ],
                          ),
                        ),
                      );
                  });
                }
            },),
          ),
        ],
      ),
    );
  }
}
