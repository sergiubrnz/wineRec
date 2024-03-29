import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/blocs/firebase_bloc/firebase_lists_bloc.dart';
import 'package:wine_rec/ui/components/heart_animation_widget.dart';
import 'package:wine_rec/utils/Models/wineApiModel.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../firebase/save_wine_methods.dart';
import '../../utils/Storage/user_preferences.dart';
import '../screens/wine_details_screen/wine_details_screen.dart';

class WineListingCard extends StatefulWidget {
  final Match? wine;
  final String sort;

  const WineListingCard({
    Key? key,
    required this.wine,
    required this.sort,
  }) : super(key: key);

  @override
  State<WineListingCard> createState() => _WineListingCardState();
}

class _WineListingCardState extends State<WineListingCard> {
  var existingItem;
  bool _isLoading = false;

  void addWine() async {
    setState(() {
      _isLoading = true;
    });
    String res = await SaveWineMethods().SaveNewWineToFavourites(
      tip: '',
      culoare: widget.wine!.vintage.wine.typeId == 1
          ? 'Rosu'
          : (widget.wine!.vintage.wine.typeId == 2
              ? 'Alb'
              : (widget.wine!.vintage.wine.typeId == 4 ? 'Rose' : 'Spumant')),
      denumire: widget.wine!.vintage.wine.name,
      sort: widget.sort,
      year: int.parse(widget.wine!.vintage.year),
      pret: widget.wine!.price.amount,
      photoUrl: 'https:${widget.wine!.vintage.image.variations.medium_square}',
    );

    final userID = await SecureStorage.getUID();
    await getLists(context, userID!);
  }

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var likedWine = false;
        if (state is ListsLoaded) {
          likedWine = state.likes.any(
            (Wine) =>
                Wine.denumire == widget.wine!.vintage.wine.name &&
                Wine.year == int.parse(widget.wine!.vintage.year),
          );
        }
        return Stack(children: [
          GestureDetector(
            onDoubleTap: () => {
              if (state is ListsLoaded)
                {
                  existingItem = state.likes.any(
                    (likedWine) =>
                        likedWine.denumire == widget.wine!.vintage.wine.name &&
                        likedWine.year == int.parse(widget.wine!.vintage.year),
                  ),
                  if (!existingItem) {addWine()},
                  print(existingItem),
                }
            },
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WineDetailsScreen(
                      wine: WineModel(
                        widget.wine!.vintage.wine.name,
                        int.parse(widget.wine!.vintage.year),
                        'Sec',
                        widget.wine!.vintage.wine.typeId == 1
                            ? 'Rosu'
                            : (widget.wine!.vintage.wine.typeId == 2
                                ? 'Alb'
                                : (widget.wine!.vintage.wine.typeId == 4
                                    ? 'Rose'
                                    : 'Spumant')),
                        'https:${widget.wine!.vintage.image.variations.medium_square}',
                        widget.wine!.price.amount,
                        widget.sort,
                        '',
                      ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                'https:${widget.wine!.vintage.image.variations.medium_square}',
                                height: size.width * 0.3,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: _isLoading ? 1 : 0,
                            child: HeartAnimationWidget(
                              isAnimating: _isLoading,
                              duration: const Duration(milliseconds: 700),
                              onEnd: () => {
                                setState(() => {_isLoading = false})
                              },
                              child: const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width * 0.3,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.wine!.vintage.wine.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 24,
                              fontFamily: 'AdobeGaramond',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            SizedBox(
                              width: size.width * 0.1,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.wine!.vintage.year.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            likedWine
                                ? const Center(
                                    child: Icon(
                                      Icons.favorite,
                                      color: kPrimaryColor,
                                      size: 18,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: size.width * 0.15,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${widget.wine!.price.amount.toStringAsFixed(2)} \$',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
