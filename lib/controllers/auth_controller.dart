import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/user.dart' as model;
import 'package:tiktok_tutorial/views/screens/Auth/login_screen.dart';
import 'package:tiktok_tutorial/views/screens/home_screen.dart';

import '../views/screens/a.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // getter
  User get user => _user.value!;
  File? get Profilepic => _pickedImage.value;

  // check user true then go home page
  late Rx<User?> _user;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, moveTo);
  }

  moveTo(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  // imgae picker
  late Rx<File?> _pickedImage;

  void imagepicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Get.snackbar(
          'Profile Picture', 'You have successfully selected your picture!');
    }
    _pickedImage = Rx<File?>(File(image!.path));
  }

  // Upload to firebase storage anf get url
  Future<String> _uploadToStorage(File? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            name: username,
            profilePhoto: downloadUrl,
            email: email,
            uid: cred.user!.uid);
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('An error while creating', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('An error while creating', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('hello');
      } else {
        Get.snackbar('An error while creating', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('An error while Login', e.toString());
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
