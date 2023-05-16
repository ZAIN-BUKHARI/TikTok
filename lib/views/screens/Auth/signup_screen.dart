import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/auth_controller.dart';
import 'package:tiktok_tutorial/views/screens/Auth/login_screen.dart';

import '../../../constants.dart';
import '../../widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TikTok',
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              'Signup',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_thumb-732x549.jpg'),
                  backgroundColor: Colors.red,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: ()=>authController.imagepicker(),
                      
              ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: InputTextField(
                controller: usernameController,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: InputTextField(
                controller: emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: InputTextField(
                controller: passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                obText: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                onTap: ()=>authController.registerUser(usernameController.text, emailController.text, passwordController.text,authController.Profilepic ),
                child: const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),  
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                    onTap: ()=>Navigator.of(context).pop(),
                    child: Text(
                      "  Login",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
