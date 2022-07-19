import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/InputTextFieldWidget.dart';
import 'package:wine_rec/ui/navigation/bottom_navigator.dart';
import 'package:wine_rec/ui/screens/login_screen/signup_screen.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';

import '../../../firebase/auth_methods.dart';
import '../../../utils/colours.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _permanentLogIn = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = "";
    setState(() {
      _isLoading = true;
    });

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      res = "Va rugam sa introduceti email-ul si parola";
    } else if (!emailValid) {
      res = "Email-ul are formatul gresit";
    } else if (_passwordController.text.length < 8) {
      res = "Parola trebuie sa aiba cel putin 8 caractere";
    } else {
      res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      await SecureStorage.setKeepMeAuthenticated(_permanentLogIn);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const BottomNavigator();
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(res),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Image.asset('assets/logo.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InputTextFieldWidget(
                          icon: Icons.person,
                          hintText: 'Email',
                          isPass: false,
                          textInputType: TextInputType.text,
                          textEditingController: _emailController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InputTextFieldWidget(
                          icon: Icons.lock,
                          hintText: 'Parola',
                          isPass: true,
                          textInputType: TextInputType.text,
                          textEditingController: _passwordController,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: kPrimaryColor,
                              value: _permanentLogIn,
                              onChanged: (bool? value) {
                                setState(() {
                                  _permanentLogIn = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Pastreaza-ma autentificat',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18),
                                // style: kCheckBoxTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.056),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0))),
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Autentificare",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            onPressed: () {
                              loginUser();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0))),
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Creaza cont",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignupScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.transparent,
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
              : Container()
        ],
      ),
    );
  }
}
