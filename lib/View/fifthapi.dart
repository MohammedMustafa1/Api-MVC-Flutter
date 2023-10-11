import 'dart:convert';
import 'package:f1/Models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class FifthApi extends StatefulWidget {
  const FifthApi({super.key});

  @override
  State<FifthApi> createState() => _FifthApiState();
}

class _FifthApiState extends State<FifthApi> {

  Future<ProductsModel> getProductsApi ()async{
    final response = await http.get(Uri.parse('https://webhook.site/5bbc9963-40e0-4685-9305-596fc64053c3'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }
  int data = 0;
  Future MyIcon() async => Icon(data == 1? Icons.favorite : Icons.favorite_outline);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fifth Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ProductsModel>(
                  future: getProductsApi(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                  subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*.3,
                                  width: MediaQuery.of(context).size.width*1,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data![index].images!.length,
                                      itemBuilder: (context,positioned){
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*.15,
                                        width: MediaQuery.of(context).size.width*.5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data!.data![index].images![positioned].url.toString()),
                                          )
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    data =1;
                                    setState(() {
                                      MyIcon();
                                    });
                                  },
                                    onDoubleTap: (){
                                      data =0;
                                      setState(() {
                                        MyIcon();
                                      });
                                    },
                                    child: Icon(data == 1? Icons.favorite : Icons.favorite_outline)
                                ),
                                // child: Icon(snapshot.data!.data![index].inWishlist == true? Icons.favorite : Icons.favorite_outline)),
                              ],
                            );
                          }
                      );
                    }else{
                      return const Text('Loading');
                    }
              },
            ))
          ],
        ),
      ),
    );
  }
}





