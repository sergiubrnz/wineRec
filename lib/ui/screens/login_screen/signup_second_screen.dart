import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/signup_selection_buttons.dart';
import 'package:wine_rec/utils/Storage/dashboardLists.dart';
import 'package:wine_rec/utils/strings.dart';

import '../../../utils/colours.dart';

class SignupSecondScreen extends StatefulWidget {
  const SignupSecondScreen({Key? key}) : super(key: key);

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  List<bool> isSelected1 = List.generate(2, (index) => false);
  List<bool> isSelected2 = List.generate(2, (index) => false);
  List<bool> isSelected3 = List.generate(2, (index) => false);
  List<bool> isSelected4 = List.generate(2, (index) => false);
  List<bool> isSelectedWine =
      List.generate(listaStruguri.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15, top: 20, bottom: 3),
                child: Text(
                  kSecondSignupHeader,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.75,
                  child: const Divider(
                    thickness: 1,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Ce fel de persoana esti?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Center(
                child: ToggleButtons(
                  children: [
                    SignupSelectionButtons(
                      text: 'Introvert',
                      isSelected: isSelected1[0],
                      fixedWidth: true,
                    ),
                    SignupSelectionButtons(
                      text: 'Extrovert',
                      isSelected: isSelected1[1],
                      fixedWidth: true,
                    ),
                  ],
                  isSelected: isSelected1,
                  selectedColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  renderBorder: false,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected1.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected1[buttonIndex] = !isSelected1[buttonIndex];
                        } else {
                          isSelected1[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Cum preferi sa iai deciziile?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Center(
                child: ToggleButtons(
                  children: [
                    SignupSelectionButtons(
                      text: 'Analizezi',
                      isSelected: isSelected2[0],
                      fixedWidth: true,
                    ),
                    SignupSelectionButtons(
                      text: 'Simti',
                      isSelected: isSelected2[1],
                      fixedWidth: true,
                    ),
                  ],
                  isSelected: isSelected2,
                  selectedColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  renderBorder: false,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected2.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected2[buttonIndex] = !isSelected2[buttonIndex];
                        } else {
                          isSelected2[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Cum preferi sa obtii informatiile?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Center(
                child: ToggleButtons(
                  children: [
                    SignupSelectionButtons(
                      text: 'Sensorial',
                      isSelected: isSelected3[0],
                      fixedWidth: true,
                    ),
                    SignupSelectionButtons(
                      text: 'Intuitiv',
                      isSelected: isSelected3[1],
                      fixedWidth: true,
                    ),
                  ],
                  isSelected: isSelected3,
                  selectedColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  renderBorder: false,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected3.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected3[buttonIndex] = !isSelected3[buttonIndex];
                        } else {
                          isSelected3[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Cat de organizat esti?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Center(
                child: ToggleButtons(
                  children: [
                    SignupSelectionButtons(
                      text: 'Organizat',
                      isSelected: isSelected4[0],
                      fixedWidth: true,
                    ),
                    SignupSelectionButtons(
                      text: 'Flexibil',
                      isSelected: isSelected4[1],
                      fixedWidth: true,
                    ),
                  ],
                  isSelected: isSelected4,
                  selectedColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  renderBorder: false,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected4.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected4[buttonIndex] = !isSelected4[buttonIndex];
                        } else {
                          isSelected4[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 5, top: 10, bottom: 10),
                child: Text(
                  "Care este sortul tau preferat de struguri?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: ToggleButtons(
                      children: _createWineList(),
                      isSelected: isSelectedWine,
                      selectedColor: Colors.transparent,
                      fillColor: Colors.transparent,
                      renderBorder: false,
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelectedWine.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelectedWine[buttonIndex] =
                                  !isSelectedWine[buttonIndex];
                            } else {
                              isSelectedWine[buttonIndex] = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Creaza cont",
                        ),
                        SizedBox(
                          width: size.width / 15,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14,
                        )
                      ],
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignupSecondScreen();
                          },
                        ),
                      )
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _createWineList() {
    return List<Widget>.generate(listaStruguri.length, (int index) {
      return SignupSelectionButtons(
        text: listaStruguri[index].name,
        isSelected: isSelectedWine[index],
        fixedWidth: false,
      );
    });
  }
}
