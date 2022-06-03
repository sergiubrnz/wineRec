import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/InputTextFieldWidget.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../firebase/auth_methods.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      surname: _usernameController.text,
    );

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res),
      ),
    );

    if (res == 'success') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                InputTextFieldWidget(
                  hintText: 'Nume',
                  textInputType: TextInputType.text,
                  icon: Icons.person,
                  textEditingController: _usernameController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextFieldWidget(
                  hintText: 'Prenume',
                  textInputType: TextInputType.text,
                  textEditingController: _surnameController,
                  icon: Icons.person,
                  isPass: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextFieldWidget(
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  icon: Icons.person,
                  isPass: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextFieldWidget(
                  hintText: 'Parola',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  icon: Icons.person,
                  isPass: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                // button login
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      "Creaza cont",
                    ),
                    onPressed: signUpUser,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Ai deja un cont? "),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: const Text(
                          "Autentificare",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                )
                // Transitioning to signing up
              ],
            ),
          ),
        ),
      ),
    );
  }
}
