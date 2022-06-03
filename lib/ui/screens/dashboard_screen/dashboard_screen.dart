import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/food_card.dart';
import 'package:wine_rec/ui/components/grapes_card.dart';
import 'package:wine_rec/ui/components/wine_types_card.dart';
import 'package:wine_rec/ui/components/year_card.dart';
import 'package:wine_rec/utils/Models/FoodModel.dart';
import 'package:wine_rec/utils/Models/GrapesModel.dart';
import 'package:wine_rec/utils/Models/WineTypeModel.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../utils/Storage/user_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<WineTypeModel> listaTipuriVin = [
    WineTypeModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        type: 'Vin alb',
        key: 'white'),
    WineTypeModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        type: 'Vin rosu',
        key: 'red'),
    WineTypeModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        type: 'Vin rose',
        key: 'rose'),
    WineTypeModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        type: 'Vin spumant',
        key: 'sparkling'),
  ];

  List<FoodModel> listaMancaruri = [
    FoodModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        name: 'Vita',
        key: 'beef'),
    FoodModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        name: 'Pasare',
        key: 'poultry'),
    FoodModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        name: 'Peste',
        key: 'fish'),
    FoodModel(
        image: "assets/toppng.com-white-wine-288x616.png",
        name: 'Legume',
        key: 'legumes'),
  ];

  List<GrapesModel> listaStruguri = [
    GrapesModel(color: 'red', name: "Merlot", key: 'merlot'),
    GrapesModel(color: 'red', name: "Cabernet Sauvignon", key: 'cabernet'),
    GrapesModel(color: 'red', name: "Pinot Noir", key: 'pinotNoir'),
    GrapesModel(color: 'white', name: "Sauvignon", key: 'sauvignon'),
    GrapesModel(color: 'white', name: "Pinot Gris", key: 'pinotGris'),
    GrapesModel(color: 'white', name: "Chardonnay", key: 'chardonnay'),
    GrapesModel(color: 'rose', name: "Cabernet Sauvignon", key: 'cabernetRose'),
  ];

  List<int> listaAni = [
    1995,
    2000,
    2005,
    2006,
    2007,
    2008,
    2010,
    2012,
    2016,
    2017,
    2018,
    2019,
    2020
  ];

  var nume = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getName();
    });
  }

  void getName() async {
    final nume1 = await SecureStorage.getUserName();
    setState(() {
      nume = nume1.toString();
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
                borderRadius: BorderRadius.circular(5),
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
                                fontSize: 18,
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
                                fontSize: 18,
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
                  fontSize: 16,
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
                        onTap: () {},
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
                  fontSize: 16,
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
                        onTap: () {},
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
                  fontSize: 16,
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
                        onTap: () {},
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
                  fontSize: 16,
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
                        onTap: () {},
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
          ],
        ),
      ),
    ));
  }
}
