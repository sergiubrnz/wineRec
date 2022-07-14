import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/wine_listing_card.dart';
import 'package:wine_rec/utils/Models/wineApiModel.dart';

import '../../../utils/colours.dart';
import '../../../utils/networking/api_networking.dart';

class WineListingScreen extends StatefulWidget {
  WineListingScreen({
    Key? key,
    this.searchParam,
    this.searchType,
    this.personalizedList,
    required this.title,
  }) : super(key: key);

  final String? searchType;
  final String? searchParam;
  final String title;
  final List? personalizedList;

  @override
  State<WineListingScreen> createState() => _WineListingScreenState();
}

class _WineListingScreenState extends State<WineListingScreen> {
  bool _isLoading = false;
  List<Match> wines = <Match>[];

  void getData() async {
    setState(() {
      _isLoading = true;
    });

    var Vintages = await ApiService().getWines(
        widget.searchType!,
        widget.searchParam != null
            ? widget.searchParam!
            : widget.personalizedList);
    print(Vintages.toJson());

    setState(() {
      wines = Vintages.matches;
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
    print(widget.searchParam);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Stack(children: [
        Container(
          child: wines.isNotEmpty
              ? GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: wines.length,
                  itemBuilder: (context, index) {
                    return WineListingCard(
                      wine: wines[index],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    (Center(
                      child: Text(
                        'Ne pare rau. Nu am putut incarca datele.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: kPrimaryColor),
                      ),
                    )),
                  ],
                ),
        ),
        _isLoading
            ? Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
                child: const Center(
                  child: SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                        strokeWidth: 5.0),
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }
}
