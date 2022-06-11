import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/blocs/firebase_bloc/firebase_lists_bloc.dart';
import 'package:wine_rec/ui/components/heart_animation_widget.dart';
import 'package:wine_rec/utils/Models/wineApiModel.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../firebase/save_wine_methods.dart';
import '../screens/wine_details_screen/wine_details_screen.dart';

class WineListingCard extends StatefulWidget {
  final Match? wine;

  const WineListingCard({
    Key? key,
    required this.wine,
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
    String res = await SaveWineMethods()
        .SaveWineToFavourites(id: '/wines/${widget.wine!.vintage.id}');

    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(children: [
          GestureDetector(
            onDoubleTap: () => {
              if (state is ListsLoaded)
                {
                  existingItem = state.likes.any(
                    (likedWine) =>
                        likedWine.denumire == widget.wine!.vintage.wine.name,
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
                        widget.wine!.vintage.grapes ?? ' - ',
                        DateTime.now().millisecondsSinceEpoch.toString(),
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
                                height: 80,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: _isLoading ? 1 : 0,
                            child: HeartAnimationWidget(
                              isAnimating: _isLoading,
                              duration: Duration(milliseconds: 700),
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
                      child: Text(
                        widget.wine!.vintage.wine.name,
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
                            Text(widget.wine!.vintage.year.toString()),
                            Text(
                                '${widget.wine!.price.amount.toStringAsFixed(2)} \$'),
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
