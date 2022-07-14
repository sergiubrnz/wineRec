import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wine_rec/ui/components/InputTextFieldWidget.dart';
import 'package:wine_rec/ui/screens/login_screen/signup_second_screen.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../firebase/auth_methods.dart';
import '../../../utils/pick_image.dart';

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

  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void transformImageToUi8n() async {
    final ByteData bytes = await rootBundle.load('assets/logo.png');
    _image = bytes.buffer.asUint8List();
  }

  @override
  void initState() {
    transformImageToUi8n();
    super.initState();
  }

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
      surname: _surnameController.text,
      file: _image!,
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 64,
                                backgroundImage: AssetImage('assets/logo.png'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0))),
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Pasul urmator",
                            ),
                            SizedBox(
                              width: size.width / 8,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
