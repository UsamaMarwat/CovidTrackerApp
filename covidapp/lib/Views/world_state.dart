import 'package:covidapp/Models/worldmodel.dart';
import 'package:covidapp/Services/stateworld.dart';
import 'package:covidapp/Views/country_list.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldScreenState extends StatefulWidget {
  const WorldScreenState({super.key});

  @override
  State<WorldScreenState> createState() => _WorldScreenStateState();
}

class _WorldScreenStateState extends State<WorldScreenState>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ColorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    Worldstate worldstate = Worldstate();
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('World Screen State'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                future: worldstate.Getworlddata(),
                builder: (context, AsyncSnapshot<WorldDetail> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          size: 50,
                          color: Colors.white,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recoverd': double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: const Duration(milliseconds: 1500),
                          colorList: ColorList,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(children: [
                              ReuseDesign(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReuseDesign(
                                  title: 'Recoverd',
                                  value: snapshot.data!.recovered.toString()),
                              ReuseDesign(
                                  title: 'Death',
                                  value: snapshot.data!.deaths.toString()),
                              ReuseDesign(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReuseDesign(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReuseDesign(
                                  title: 'Today Death',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReuseDesign(
                                  title: 'Today Recoverd',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CountryScreenState(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            // padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff1aa260),
                            ),
                            child: const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseDesign extends StatelessWidget {
  String title, value;
  ReuseDesign({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
