import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/settings_widget_card.dart';
import 'package:wine_rec/ui/screens/login_screen/login_screen.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';
import 'package:wine_rec/utils/colours.dart';

class ProfileCard extends StatelessWidget {
  void logoutUser() async {
    await SecureStorage.deleteAllData();
  }

  final String? name;
  final String? imageUrl;

  ProfileCard({
    Key? key,
    this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.6,
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
                          top: 50,
                          bottom: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              name!,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'AdobeGaramond',
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Divider(
                                  thickness: 2,
                                  height: 15,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            SettingsWidgetCard(
                              text: 'Editare cont ',
                              rightIcon: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_outlined),
                                onPressed: () => {},
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SettingsWidgetCard(
                              text: 'Colectia mea ',
                              rightIcon: IconButton(
                                icon: Text('0'),
                                onPressed: () => {},
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SettingsWidgetCard(
                              text: 'Aprecierile mele ',
                              rightIcon: IconButton(
                                icon: Text('0'),
                                onPressed: () => {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    backgroundImage: NetworkImage(imageUrl!),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.05,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0))),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: const Text(
                  "Delogare",
                ),
                onPressed: () {
                  logoutUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
