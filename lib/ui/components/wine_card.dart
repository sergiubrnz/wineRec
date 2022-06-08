import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/blocs/firebase_bloc/firebase_lists_bloc.dart';
import 'package:wine_rec/ui/screens/wine_details_screen/wine_details_screen.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';
import 'package:wine_rec/utils/colours.dart';

class WineCard extends StatelessWidget {
  var existingItem;

  WineCard({
    Key? key,
    this.wine,
  });

  final WineModel? wine;

  @override
  Widget build(BuildContext context) {
    var _FirebaseListsBloc = FirebaseListsBloc();
    var state;
    if (_FirebaseListsBloc.state is ListsLoaded) {
      state = _FirebaseListsBloc.state as ListsLoaded;

      print(state.collection.length);
    }
    return BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onDoubleTap: () => {
            if (state is ListsLoaded)
              {
                existingItem = state.likes.any(
                  (likedWine) => likedWine.denumire == wine!.denumire,
                ),
                print(existingItem),
              }
          },
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WineDetailsScreen(
                    wine: wine,
                  );
                },
              ),
            )
          },
          child: SafeArea(
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        wine!.photoUrl,
                        height: 80,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      wine!.denumire,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: 'AdobeGaramond',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(wine!.year.toString()),
                          Text('${wine!.pret.toString()} \$'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
