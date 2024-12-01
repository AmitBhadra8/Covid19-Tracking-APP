import 'package:covid_tracking_app/View/detail_screen.dart';
import 'package:covid_tracking_app/services/states_services.dart';
import 'package:flutter/material.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with Country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder( future: statesServices.countrieslistapi(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData)
                      {
                        return Text("Loading");
                      }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty){

                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    critical: snapshot.data![index]['critical'],
                                  )
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),

                                      leading: Image(
                                        height : 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );


                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],
                                      )
                                      )
                                      );
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),

                                      leading: Image(
                                        height : 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }else{
                              return Container();
                            }

                      });
                    }

                      })


              )
            ],)),
    );
  }
}
