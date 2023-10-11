import 'package:f1/Models/WorldStatesModel.dart';
import 'package:f1/Services/states_services.dart';
import 'package:f1/View/Api7.dart';
import 'package:f1/View/SixthApi.dart';
import 'package:f1/View/countries_list.dart';
import 'package:f1/View/fifthapi.dart';
import 'package:f1/View/home.dart';
import 'package:f1/View/secondapi.dart';
import 'package:f1/View/thirdapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'fourthapi.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 3),vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ReusableGestureDetector(title: 'api1',link:HomePage(),),
            ReusableGestureDetector(title: 'api2',link:SecondApi(),),
            ReusableGestureDetector(title: 'api3',link:ThirdApi(),),
            ReusableGestureDetector(title: 'api4',link:FourthApi(),),
            ReusableGestureDetector(title: 'api5',link:FifthApi(),),
            ReusableGestureDetector(title: 'api6',link:SixthApi(),),
            ReusableGestureDetector(title: 'api7',link:SeventhApi(),),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Main Body'),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                  );
                }else{
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PieChart(
                            dataMap: {
                              // "Total":20,
                              // "Recovered":23,
                              // "Deaths":5,
                              "Total":double.parse(snapshot.data!.cases!.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width/3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ReusableRow(title: 'Today Recovery', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  final String title,value;
  const ReusableRow({super.key, required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}


class ReusableGestureDetector extends StatefulWidget {
  final String? title;
  final dynamic link;
  const ReusableGestureDetector({super.key,this.title,this.link});

  @override
  State<ReusableGestureDetector> createState() => _ReusableGestureDetectorState();
}

class _ReusableGestureDetectorState extends State<ReusableGestureDetector> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> widget.link));
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(widget.title.toString())),
        ),
      ),
    );
  }
}
