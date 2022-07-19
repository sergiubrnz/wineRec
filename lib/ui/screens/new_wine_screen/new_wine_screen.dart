import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wine_rec/utils/colours.dart';
import 'package:wine_rec/utils/constants.dart';

import '../../../firebase/save_wine_methods.dart';
import '../../../utils/Storage/user_preferences.dart';
import '../../../utils/pick_image.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';
import '../../components/InputTextFieldWidget.dart';

class NewWineScreen extends StatefulWidget {
  const NewWineScreen({Key? key}) : super(key: key);

  @override
  State<NewWineScreen> createState() => _NewWineScreenState();
}

class _NewWineScreenState extends State<NewWineScreen> {
  final TextEditingController _controllerDenumire = TextEditingController();
  final TextEditingController _controllerPret = TextEditingController();
  final TextEditingController _controllerAn = TextEditingController();
  final TextEditingController _controllerSort = TextEditingController();
  bool _isLoading = false;

  String ColorDropdownvalue = kWineColors.first;
  String TypeDropdownvalue = kWineTypes.first;

  Uint8List? _image;
  void transformImageToUi8n() async {
    final ByteData bytes = await rootBundle.load('assets/wineBottle.jpeg');
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
    _controllerAn.dispose();
    _controllerSort.dispose();
    _controllerPret.dispose();
    _controllerDenumire.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  void addWine() async {
    String res = "";
    setState(() {
      _isLoading = true;
    });
    if (_controllerDenumire.text.isEmpty) {
      res = "Denumirea este obligatorie";
    } else if (_controllerPret.text.isEmpty ||
        !RegExp(r'^[0-9]+$').hasMatch(_controllerPret.text) ||
        double.parse(_controllerPret.text) < 0) {
      res = "Introduceti un pret valid";
    } else if (_controllerAn.text.isEmpty ||
        !RegExp(r'^[0-9]+$').hasMatch(_controllerAn.text) ||
        double.parse(_controllerAn.text) > 2022) {
      res = "Introduceti un an valid";
    } else {
      res = await SaveWineMethods().SaveWine(
        denumire: _controllerDenumire.text,
        culoare: ColorDropdownvalue,
        pret: double.parse(_controllerPret.text),
        sort: _controllerSort.text,
        tip: TypeDropdownvalue,
        year: int.parse(_controllerAn.text),
        file: _image!,
      );
    }

    final basketBloc = context.read<FirebaseListsBloc>();
    final userID = await SecureStorage.getUID();
    basketBloc.add(GetFirebaseLists(userID!));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        title: Text("Mărește-ți colecția"),
      ),
      body: Stack(children: [
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        _image != null
                            ? Image(
                                image: MemoryImage(_image!),
                                height: size.height * 0.2,
                              )
                            : Image.asset(
                                'assets/wineBottle.jpeg',
                                height: size.height * 0.2,
                              ),
                        Positioned(
                          bottom: 0,
                          left: (size.width * 0.5),
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputTextFieldWidget(
                    hintText: 'Denumire',
                    textInputType: TextInputType.text,
                    icon: Icons.wine_bar_outlined,
                    textEditingController: _controllerDenumire,
                    isPass: false,
                  ),

                  InputTextFieldWidget(
                    hintText: 'An producere',
                    textInputType: TextInputType.number,
                    textEditingController: _controllerAn,
                    icon: Icons.calendar_today_outlined,
                    isPass: false,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: size.width * 0.38,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: ColorDropdownvalue,
                            isExpanded: true,
                            items: kWineColors.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (string) => {
                              setState(() {
                                ColorDropdownvalue = string.toString();
                              }),
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: size.width * 0.38,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: TypeDropdownvalue,
                            isExpanded: true,
                            items: kWineTypes.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (string) => {
                              setState(() {
                                TypeDropdownvalue = string.toString();
                              }),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputTextFieldWidget(
                    hintText: 'Sort',
                    textInputType: TextInputType.text,
                    textEditingController: _controllerSort,
                    icon: Icons.wine_bar_sharp,
                    isPass: false,
                  ),
                  InputTextFieldWidget(
                    hintText: 'Pret',
                    textInputType: TextInputType.number,
                    textEditingController: _controllerPret,
                    icon: Icons.attach_money,
                    isPass: false,
                  ),
                  // button login
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0))),
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: const Text(
                        "Adauga",
                      ),
                      onPressed: addWine,
                    ),
                  ),
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
      ]),
    );
  }
}
