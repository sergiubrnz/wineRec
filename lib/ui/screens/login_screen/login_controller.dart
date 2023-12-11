import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine_rec/firebase/auth_methods.dart';
import 'package:wine_rec/ui/navigation/bottom_navigator.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool permanentLogIn = false.obs;

  LoginController();

  @override
  void onInit() async {
    super.onInit();
  }

  void loginUser() async {
    String res = "";
    isLoading.value = true;

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      res = "Va rugam sa introduceti email-ul si parola";
    } else if (!emailValid) {
      res = "Email-ul are formatul gresit";
    } else if (passwordController.text.length < 8) {
      res = "Parola trebuie sa aiba cel putin 8 caractere";
    } else {
      res = await AuthMethods().loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
    }

    isLoading.value = false;

    if (res == 'success') {
      await SecureStorage.setKeepMeAuthenticated(permanentLogIn.value);
      Get.offAll(BottomNavigator());
    } else {
      Get.snackbar(
        'Login',
        res,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
