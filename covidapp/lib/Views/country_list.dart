import 'package:covidapp/Services/stateworld.dart';
import 'package:covidapp/Views/country_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryScreenState extends StatefulWidget {
  const CountryScreenState({super.key});

  @override
  State<CountryScreenState> createState() => _CountryScreenStateState();
}

class _CountryScreenStateState extends State<CountryScreenState> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Worldstate worldstate = Worldstate();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search With Country Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: worldstate.getcountrydata(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        // ignore: sort_child_properties_last
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                  height: 50, width: 70, color: Colors.white),
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                  height: 10, width: 89, color: Colors.white),
                            ),
                          ],
                        ),
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100);
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'].toString();
                    if (searchcontroller.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetailScreen(
                                        name: name,
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        todayRecoverd: snapshot.data![index]
                                            ['todayRecovered'],
                                        active: snapshot.data![index]['active'],
                                        totalRecoverd: snapshot.data![index]
                                            ['recovered'],
                                        test: snapshot.data![index]['tests']),
                                  ));
                            },
                            child: ListTile(
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              trailing: Text(snapshot.data![index]['population']
                                  .toString()),
                            ),
                          ),
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetailScreen(
                                        name: name,
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        todayRecoverd: snapshot.data![index]
                                            ['todayRecovered'],
                                        active: snapshot.data![index]['active'],
                                        totalRecoverd: snapshot.data![index]
                                            ['recovered'],
                                        test: snapshot.data![index]['tests']),
                                  ));
                            },
                            child: ListTile(
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              trailing: Text(snapshot.data![index]['population']
                                  .toString()),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
