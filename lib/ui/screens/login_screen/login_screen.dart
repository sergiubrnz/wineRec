import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine_rec/ui/components/InputTextFieldWidget.dart';
import 'package:wine_rec/ui/screens/login_screen/login_controller.dart';
import 'package:wine_rec/ui/screens/sign_up_screen/signup_screen.dart';

import '../../../utils/colours.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: Get.height * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Center(
                        child: SizedBox(
                          height: Get.height * 0.35,
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
                          controller: _controller.emailController,
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
                          controller: _controller.passwordController,
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
                              value: _controller.permanentLogIn.value,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  _controller.permanentLogIn.value = value;
                                }
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
                      SizedBox(height: Get.height * 0.056),
                      Center(
                        child: SizedBox(
                          width: Get.width * 0.6,
                          height: Get.height * 0.05,
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
                              _controller.loginUser();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Center(
                        child: SizedBox(
                          width: Get.width * 0.6,
                          height: Get.height * 0.05,
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
          _controller.isLoading.value
              ? Container(
                  height: Get.height,
                  width: Get.width,
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
