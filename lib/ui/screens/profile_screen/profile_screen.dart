import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wine_rec/firebase/user_methods.dart';

import '../../../utils/Storage/user_preferences.dart';
import '../../../utils/colours.dart';
import '../../../utils/pick_image.dart';
import '../../components/InputTextFieldWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  var initialAccount;

  Uint8List? _image = null;
  String? firebaseImage;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    final userID = await SecureStorage.getUID();
    var res = (await UserMethods().getUserInfo(
      uid: userID!,
    ));
    initialAccount = res;

    _emailController.text = res?['email'];
    _usernameController.text = res?['nume'];
    _surnameController.text = res?['prenume'];
    firebaseImage = res?['photoUrl'];

    setState(() {
      _isLoading = false;
    });
  }

  void updateUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    final userID = await SecureStorage.getUID();

    if (_usernameController.text != initialAccount['nume']) {
      var res = (await UserMethods().updateUserName(
        uid: userID!,
        username: _usernameController.text,
      ));
    }

    if (_surnameController != initialAccount['prenume']) {
      var res = (await UserMethods().updateUserSurname(
        uid: userID!,
        surname: _surnameController.text,
      ));
    }

    if (_image != null) {
      var res = (await UserMethods().updateUserImage(
        uid: userID!,
        file: _image!,
      ));
    }

    setState(() {
      _isLoading = false;
    });

    getUserInfo();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      firebaseImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Contul meu",
          style: TextStyle(fontSize: 24),
        ),
      ),
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
                          firebaseImage != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(firebaseImage!),
                                )
                              : _image != null
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
                        isEnabled: false,
                        icon: Icons.person,
                        isPass: false,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      // button login
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: size.height * 0.05,
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
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Salveaza modificarile",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          onPressed: () => {
                            updateUserInfo(),
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: size.height * 0.05,
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
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Anuleaza",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                        ),
                      ),
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
