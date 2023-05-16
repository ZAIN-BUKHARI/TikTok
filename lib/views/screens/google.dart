import 'package:flutter/material.dart';


class Google extends StatelessWidget {
  const Google({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Column(
            // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Text('Google',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 23),),
            SizedBox(height: 30,),
            Text('Welcome',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_2_rounded,color: Colors.grey),
                Text('ali.haider@doctornow.io',style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 180),
              child: Text('Show password'),
            ),
            SizedBox(height: 70,),
            Padding(
              padding: const EdgeInsets.only(right:170),
              child: Text('Forgot password?',style: TextStyle(color: Colors.blueAccent),),
            ),
            SizedBox(height: 250,),
            Padding(
              padding: const EdgeInsets.only(left:180),
              child: ElevatedButton(onPressed:()=>print('hello'),
              child: Text('Next'),),
            ),
          ],
        ),
      ),
    );
  }
}
