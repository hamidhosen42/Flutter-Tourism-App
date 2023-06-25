// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../styles/style.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../main.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  static const routeName = '/profile-edit-screen';

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  bool _isUpdating = false; // Flag to track the update process

  var isLoading = false;
  var isobx = false;

  File? _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future getImageGally() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  showUserData({required data}) {
    nameController.text = data['name'];
    emailController.text = data['email'];
    phoneController.text = data['phone_number'];
    addressController.text = data['address'];

    return SingleChildScrollView(
      child: Column(
        children: [
          formField(
            icon: Icons.person,
            controller: nameController,
            inputType: TextInputType.name,
            hint: "name",
          ),
          SizedBox(
            height: 20.h,
          ),
          formField(
              icon: Icons.email,
              controller: emailController,
              inputType: TextInputType.emailAddress,
              hint: "email",
              readOnly: true),
          SizedBox(
            height: 20.h,
          ),
          formField(
            icon: Icons.phone,
            controller: phoneController,
            inputType: TextInputType.phone,
            hint: "phone",
          ),
          SizedBox(
            height: 20.h,
          ),
          formField(
            icon: Icons.location_city_rounded,
            controller: addressController,
            inputType: TextInputType.text,
            hint: "address",
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: () {
              getImageGally();
            },
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: _image != null
                  ? Image.file(_image!)
                  : Center(
                      child: data['image_url'] != ""
                          ? Image.network(data['image_url'])
                          : Image.asset("assets/avatar.png")),
            ),
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: _isUpdating
                ? null
                : () async {
                    setState(() {
                      _isUpdating = true;
                    });
                    String id =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    var ref = FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid);

                    if (_image != null) {
                      firebase_storage.Reference ref1 = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/profile/' + id);
                      firebase_storage.UploadTask uploadTask =
                          ref1.putFile(_image!);
                      await uploadTask.whenComplete(() => null);
                      String downloadUrl = await ref1.getDownloadURL();

                      // Update the profile image URL in the user's document
                      ref.update({'image_url': downloadUrl});
                    }

                    try {
                      // Update other user profile fields
                      ref
                          .update({
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone_number': phoneController.text,
                            'address': addressController.text,
                          })
                          .then(
                            (value) => Fluttertoast.showToast(
                              msg: "Updated Successfully",
                              backgroundColor: Colors.black87,
                            ),
                          )
                          .then(
                            (value) => Get.back(),
                          );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Something is wrong",
                        backgroundColor: Colors.black87,
                      );
                    } finally {
                      setState(() {
                        _isUpdating = false;
                      });
                    }
                  },
            child: Container(
              height: 60.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: _isUpdating
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Center(
                      child: Text(
                      "Update",
                      style: GoogleFonts.courgette(
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.white
                            : Colors.white,
                        fontSize: 25,
                      ),
                    )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Edit".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data!.data();
              return showUserData(data: data);
            }
          },
        ),
      ),
    );
  }

  Widget formField({
    required IconData icon,
    required TextEditingController controller,
    required TextInputType inputType,
    required String hint,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      decoration: AppStyle().textFieldDecoration(hint, icon),
    );
  }
}
