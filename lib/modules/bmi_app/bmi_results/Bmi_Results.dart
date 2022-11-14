import 'package:flutter/material.dart';

class BmiResults extends StatelessWidget {

  final int result;
  final bool isMale;
  final int age;

  BmiResults({
   required this.result,
   required this.isMale,
   required this.age,
});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
            {
              Navigator.pop(context);
            },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('BMI Results'),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gender : ${isMale ? 'Male' : 'Female'}',style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            Text('Height : $result',style:
            TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            Text('Age : $age',style:
            TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
