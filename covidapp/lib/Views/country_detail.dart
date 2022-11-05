import 'package:covidapp/Views/world_state.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  String image;
  String name;
  int? totalCases,
      totalDeaths,
      totalRecoverd,
      active,
      critical,
      todayRecoverd,
      test;
  CountryDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecoverd,
    required this.active,
    required this.totalRecoverd,
    required this.test,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
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
                      ReuseDesign(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReuseDesign(
                          title: 'Total Recoverd',
                          value: widget.todayRecoverd.toString()),
                      ReuseDesign(
                          title: 'Total Death',
                          value: widget.totalDeaths.toString()),
                      ReuseDesign(
                          title: 'Today Recoverd',
                          value: widget.todayRecoverd.toString()),
                      ReuseDesign(
                          title: 'Active', value: widget.active.toString()),
                      ReuseDesign(title: 'Test', value: widget.test.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image.toString()),
              )
            ],
          )
        ],
      ),
    );
  }
}
