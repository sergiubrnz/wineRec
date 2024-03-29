import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/screens/login_screen/login_screen.dart';

import '../../../utils/Storage/user_preferences.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';
import '../../navigation/bottom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLoggedIn = false;

  void getIsLoggedIn() async {
    final isLogged = await SecureStorage.getKeepMeAuthenticated();
    final userId = await SecureStorage.getUID();
    setState(() {
      isLoggedIn = isLogged == 'true';
    });
    if (isLoggedIn && userId != null) {
      final basketBloc = context.read<FirebaseListsBloc>();
      basketBloc.add(GetFirebaseLists(userId));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getIsLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      duration: 2000,
      splashIconSize: size.width * 0.8,
      splash: Image.asset(
        'assets/logo.png',
      ),
      nextScreen: isLoggedIn ? BottomNavigator() : LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
