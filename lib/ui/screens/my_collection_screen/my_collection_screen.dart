import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wine_rec/ui/components/wine_card.dart';
import 'package:wine_rec/ui/screens/new_wine_screen/new_wine_screen.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';

import '../../../utils/Storage/user_preferences.dart';
import '../../../utils/colours.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';

class MyCollectionScreen extends StatefulWidget {
  const MyCollectionScreen({Key? key}) : super(key: key);

  @override
  State<MyCollectionScreen> createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  int labelIndex = 0;
  var uid = '';
  double totalPrice = 0.0;

  void getData() async {
    final userID = await SecureStorage.getUID();
    setState(() {
      uid = userID!;
    });
    await getLists(context, userID!);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Vinurile mele"),
      ),
      floatingActionButton: labelIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewWineScreen();
                    },
                  ),
                );
              },
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.add),
              elevation: 10,
            )
          : null,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ToggleSwitch(
              minWidth: 200.0,
              cornerRadius: 20.0,
              activeBgColors: const [
                [kPrimaryColor],
                [kPrimaryColor]
              ],
              initialLabelIndex: labelIndex,
              totalSwitches: 2,
              labels: const ['Colecția mea', 'Aprecierile mele'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  if (labelIndex == 0) {
                    labelIndex = 1;
                  } else {
                    labelIndex = 0;
                  }
                });
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ListsLoading) {
                          return Container(
                            height: size.height * 0.55,
                            width: size.width,
                            color: Colors.transparent,
                            child: const Center(
                              child: SizedBox(
                                height: 60.0,
                                width: 60.0,
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(kPrimaryColor),
                                    strokeWidth: 5.0),
                              ),
                            ),
                          );
                        } else if (state is ListsLoaded) {
                          List<WineModel> wineList;
                          if (labelIndex == 1) {
                            wineList = state.likes;
                          } else {
                            wineList = state.collection;
                          }

                          if (wineList.isNotEmpty) {
                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: wineList.length,
                              itemBuilder: (context, index) {
                                return WineCard(wine: wineList[index]);
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.3),
                                  child: (const Center(
                                    child: Text(
                                      'Nu aveti inregistrari pentru moment',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: kPrimaryColor),
                                    ),
                                  )),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.3),
                                child: (const Center(
                                  child: Text(
                                    'Nu am putut incarca datele dumneavoastra',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: kPrimaryColor),
                                  ),
                                )),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  labelIndex == 0
                      ? BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                          listener: (context, state) {
                            if (state is ListsLoaded) {
                              totalPrice = 0;
                              for (WineModel wine in state.collection) {
                                totalPrice += wine.pret;
                              }
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Pretul estimat al colectiei: ${totalPrice.toStringAsFixed(2)} \$',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'AdobeGaramond',
                                    color: kPrimaryColor),
                                textAlign: TextAlign.start,
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }
}
