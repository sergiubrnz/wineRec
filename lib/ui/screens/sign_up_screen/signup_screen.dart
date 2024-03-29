import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wine_rec/ui/components/InputTextFieldWidget.dart';
import 'package:wine_rec/ui/screens/sign_up_screen/signup_second_screen.dart';
import 'package:wine_rec/utils/colours.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                  backgroundImage:
                                      AssetImage('assets/logo.png'),
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
                        controller: _usernameController,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFieldWidget(
                        hintText: 'Prenume',
                        textInputType: TextInputType.text,
                        controller: _surnameController,
                        icon: Icons.person,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFieldWidget(
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                        icon: Icons.mail,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFieldWidget(
                        hintText: 'Parola',
                        textInputType: TextInputType.text,
                        controller: _passwordController,
                        icon: Icons.lock,
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
                          child: SizedBox(
                            width: size.width * 0.6,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Pasul urmator",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: size.width / 8,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          onPressed: () => {
                            if (_passwordController.text.isEmpty &&
                                _surnameController.text.isEmpty &&
                                _usernameController.text.isEmpty &&
                                _emailController.text.isEmpty)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Te rugam sa completezi toate datele'),
                                  ),
                                ),
                              }
                            else if (_passwordController.text.length < 8)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Parola trebuie sa aiba cel putin 8 caractere'),
                                  ),
                                ),
                              }
                            else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_emailController.text))
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Formatul email-ului nu este valid'),
                                  ),
                                ),
                              }
                            else
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignupSecondScreen(
                                        email: _emailController.text,
                                        username: _usernameController.text,
                                        surname: _surnameController.text,
                                        password: _passwordController.text,
                                        file: _image,
                                      );
                                    },
                                  ),
                                )
                              }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  "Ai deja un cont? ",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: const Text(
                                    "Autentificare",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      // Transitioning to signing up
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
