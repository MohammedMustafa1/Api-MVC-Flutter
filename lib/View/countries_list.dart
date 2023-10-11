import 'package:f1/Services/states_services.dart';
import 'package:f1/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> with TickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){setState(() {});},
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 90,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 90,color: Colors.white,),
                                      leading: Container(height: 50,width: 50,color: Colors.white,),
                                    ),
                                  ],
                                ),
                            );
                          });
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases'],
                                      todayRecovery: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      totalRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    //every image has their own url so i used it as a tag so the hero builder do not clas under the same sub tree
                                    leading: Hero(
                                        tag:snapshot.data![index]['countryInfo']['flag'].toString(),
                                        child: Image.network(snapshot.data![index]['countryInfo']['flag'], height: 50, width: 50,),
                                        //Image(image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),height: 50,width: 50,)
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toString().toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases'],
                                      todayRecovery: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      totalRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    //every image has their own url so i used it as a tag so the hero builder do not clas under the same sub tree
                                    leading: Hero(
                                        tag:snapshot.data![index]['countryInfo']['flag'].toString(),
                                        child: Image(image: NetworkImage(snapshot.data![index]['countryInfo']['flag'],),height: 50,width: 50,)
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }
                      });
                    }

                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
