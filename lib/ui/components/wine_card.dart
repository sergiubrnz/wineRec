import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/blocs/firebase_bloc/firebase_lists_bloc.dart';
import 'package:wine_rec/ui/components/heart_animation_widget.dart';
import 'package:wine_rec/ui/screens/wine_details_screen/wine_details_screen.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../firebase/save_wine_methods.dart';
import '../../utils/Storage/user_preferences.dart';

class WineCard extends StatefulWidget {
  final WineModel? wine;

  const WineCard({
    Key? key,
    required this.wine,
  }) : super(key: key);

  @override
  State<WineCard> createState() => _WineCardState();
}

class _WineCardState extends State<WineCard> {
  var existingItem;
  bool _isLoading = false;

  void addWine() async {
    setState(() {
      _isLoading = true;
    });
    String res = await SaveWineMethods()
        .SaveWineToFavourites(id: '/wines/${widget.wine!.id}');

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
      listener: (context, state) {
        if (state is ListsLoaded) {
          existingItem = state.likes.any(
            (likedWine) => likedWine.denumire == widget.wine!.denumire,
          );
        }
      },
      builder: (context, state) {
        var likedWine = false;
        if (state is ListsLoaded) {
          likedWine = state.likes.any(
            (Wine) => Wine.denumire == widget.wine!.denumire,
          );
        }
        return Stack(children: [
          GestureDetector(
            onDoubleTap: () => {
              if (state is ListsLoaded)
                {
                  existingItem = state.likes.any(
                    (likedWine) => likedWine.denumire == widget.wine!.denumire,
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
                      wine: widget.wine,
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
                                widget.wine!.photoUrl!,
                                height: size.width * 0.3,
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
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.wine!.denumire!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 24,
                            fontFamily: 'AdobeGaramond',
                            fontWeight: FontWeight.bold,
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
                                  widget.wine!.year.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            likedWine
                                ? const Icon(
                                    Icons.favorite,
                                    color: kPrimaryColor,
                                    size: 18,
                                  )
                                : Container(),
                            SizedBox(
                              width: size.width * 0.15,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${widget.wine!.pret?.toStringAsFixed(2)} \$',
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
