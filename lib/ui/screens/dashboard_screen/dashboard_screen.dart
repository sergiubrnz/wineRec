import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/components/food_card.dart';
import 'package:wine_rec/ui/components/grapes_card.dart';
import 'package:wine_rec/ui/components/wine_types_card.dart';
import 'package:wine_rec/ui/components/year_card.dart';
import 'package:wine_rec/ui/screens/wine_listing_screen/wine_listing_creen.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../firebase/user_methods.dart';
import '../../../utils/Storage/dashboardLists.dart';
import '../../../utils/Storage/user_preferences.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var nume = '';
  var lovedList = [];
  bool _isLoading = false;

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    final userID = await SecureStorage.getUID();

    var res = (await UserMethods().getUserInfo(
      uid: userID!,
    ));

    await getLists(context, userID!);

    setState(() {
      nume = res!['prenume'];
      if (res!['lovedSorts'] != null) {
        lovedList = res!['lovedSorts'];
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: size.width * 1.1,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Salut, $nume!',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Descopera magia vinului',
                                style: TextStyle(
                                  fontFamily: 'AdobeGaramond',
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Image.asset('assets/wineStains.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  'Cautare dupa tip:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WineListingScreen(
                                    searchType: 'color',
                                    searchParam: listaTipuriVin[index].key,
                                    title: listaTipuriVin[index].type,
                                  );
                                },
                              ),
                            );
                          },
                          child: WineTypesCard(
                            denumire: listaTipuriVin[index].type,
                            image: listaTipuriVin[index].image,
                          ),
                        ),
                      );
                    },
                    itemCount: listaTipuriVin.length,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  'Cautare dupa struguri:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WineListingScreen(
                                    searchType: 'sort',
                                    searchParam: listaStruguri[index].key,
                                    title: listaStruguri[index].name,
                                  );
                                },
                              ),
                            );
                          },
                          child: GrapesCard(
                            denumire: listaStruguri[index].name,
                            color: listaStruguri[index].color,
                          ),
                        ),
                      );
                    },
                    itemCount: listaStruguri.length,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  'Pairing mancare:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WineListingScreen(
                                    searchType: 'food',
                                    searchParam: listaMancaruri[index].key,
                                    title: listaMancaruri[index].name,
                                  );
                                },
                              ),
                            );
                          },
                          child: FoodCard(
                            denumire: listaMancaruri[index].name,
                            image: listaMancaruri[index].image,
                          ),
                        ),
                      );
                    },
                    itemCount: listaMancaruri.length,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  'Cautare dupa an:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WineListingScreen(
                                    searchType: 'year',
                                    searchParam: listaAni[index].toString(),
                                    title: listaAni[index].toString(),
                                  );
                                },
                              ),
                            );
                          },
                          child: YearCard(
                            year: listaAni[index].toString(),
                          ),
                        ),
                      );
                    },
                    itemCount: listaAni.length,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: lovedList.length > 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: size.width * 0.6,
                child: FloatingActionButton.extended(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WineListingScreen(
                            searchType: 'sort',
                            //searchParam: lovedList[0].toString(),
                            personalizedList: lovedList,
                            title: 'Sugestii personalizate',
                          );
                        },
                      ),
                    );
                  },
                  label: const Text(
                    'Sugestii personalizate',
                    style: TextStyle(
                      fontFamily: "AdobeGaramond",
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
