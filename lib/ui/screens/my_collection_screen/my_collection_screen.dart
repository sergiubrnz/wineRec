import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wine_rec/ui/screens/new_wine_screen/new_wine_screen.dart';

import '../../../utils/colours.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';

class MyCollectionScreen extends StatefulWidget {
  const MyCollectionScreen({Key? key}) : super(key: key);

  @override
  State<MyCollectionScreen> createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  int labelIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Vinurile mele"),
      ),
      floatingActionButton: labelIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NewWineScreen();
                    },
                  ),
                );
              },
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.add),
              elevation: 10,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ListsLoaded) {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: labelIndex == 1
                            ? state.likes.length
                            : state.collection.length,
                        itemBuilder: (context, index) {
                          return labelIndex == 1
                              ? Text(state.likes[index].denumire.toString())
                              : Text(
                                  state.collection[index].denumire.toString());
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
