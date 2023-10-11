import 'package:f1/View/fourthapi.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String? name, image;
  int? totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovery,
      test;
  DetailScreen(
      {super.key,
      this.name,
      this.image,
      this.totalCases,
      this.totalDeaths,
      this.totalRecovered,
      this.active,
      this.critical,
      this.todayRecovery,
      this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovery.toString()),
                      ReusableRow(
                          title: 'tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
//every image has their own url so i used it as a tag so that hero builder does not clash under the same sub tree due to same tag name
              //Hero(tag: widget.image.toString(), child: Image.network(widget.image.toString()),),
              Hero(
                tag: widget.image.toString(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.image.toString()),
                  radius: 50,
                ),
              ),
                                          //circle image with container
              // Hero(
              //   tag: widget.image.toString(),
              //   child: Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: DecorationImage(
              //         image: NetworkImage(widget.image.toString()),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
