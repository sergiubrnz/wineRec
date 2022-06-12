import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/firebase/delete_wine_methods.dart';

import '../../../utils/Models/wineModel.dart';
import '../../../utils/Storage/user_preferences.dart';
import '../../../utils/colours.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';

class WineDetailsScreen extends StatefulWidget {
  const WineDetailsScreen({Key? key, this.wine}) : super(key: key);
  final WineModel? wine;

  @override
  State<WineDetailsScreen> createState() => _WineDetailsScreenState();
}

class _WineDetailsScreenState extends State<WineDetailsScreen> {
  bool _isLoading = false;

  void deleteWineFromCollection(bool fromFirebase) async {
    setState(() {
      _isLoading = true;
    });
    String res = await DeleteWineMethods()
        .DeleteWineFromCollection(id: widget.wine!.id!);

    final userID = await SecureStorage.getUID();
    await getLists(context, userID!);

    if (fromFirebase) deleteWine();

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  void deleteWine() async {
    setState(() {
      _isLoading = true;
    });
    String res = await DeleteWineMethods()
        .DeleteWine(id: widget.wine!.id!, photoUrl: widget.wine!.photoUrl!);

    final userID = await SecureStorage.getUID();
    await getLists(context, userID!);

    setState(() {
      _isLoading = false;
    });
  }

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFEBEBEB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          elevation: 0,
          title: const Text("Despre vin"),
        ),
        body: Center(
          heightFactor: 1,
          child: SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 80,
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 120, bottom: 20, left: 20, right: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.wine!.denumire!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: kPrimaryColor,
                                            fontFamily: 'AdobeGaramond'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          ' ${widget.wine!.sort} - ${widget.wine!.year}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Divider(
                                        thickness: 2,
                                        height: 15,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${widget.wine!.culoare} - ${widget.wine!.tip}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 40,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.wine!.year.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Text(
                                          '${widget.wine!.pret!.toStringAsFixed(2)} \$',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ListsLoaded) {
                            var existingItem = state.collection.any(
                              (wine) => wine.denumire == widget.wine!.denumire,
                            );
                            var likedItem = state.likes.any(
                              (wine) => wine.denumire == widget.wine!.denumire,
                            );
                            if (existingItem) {
                              print(widget.wine!.id);
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: const Text(
                                    "Sterge din colectia mea",
                                  ),
                                  onPressed: () => {
                                    deleteWineFromCollection(!likedItem),
                                  },
                                ),
                              );
                            } else {
                              print(existingItem);
                              return Container();
                            }
                          } else {
                            print('list not loaded');
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          widget.wine!.photoUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
