import 'dart:math';

import 'package:flutter/material.dart';


import '../bmi_results/Bmi_Results.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {

  bool isMale = true;
  double height = 120;
  int weight = 30;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),

      body: Column(
        children: [
          Container(
          child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isMale ? Colors.blue : Colors.grey[400]
                        ),
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('images/male.png'),
                            height: 90,
                              width: 90,
                            ),
                            SizedBox(height: 12,),
                            Text('Male',style:
                            TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: !isMale ? Colors.blue: Colors.grey[400]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ac_unit_outlined,
                              color: Colors.black,
                              size: 70,
                            ),
                            SizedBox(height: 12,),
                            Text('Female',style:
                              TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[400],

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Height',style:
                    TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.baseline ,
                      textBaseline:TextBaseline.alphabetic ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${height.round()}',style:
                          TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
                        SizedBox(width: 5,),
                        Text('CM',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    Slider(
                        value: height,
                        min: 80,
                        max: 220
                        ,
                        onChanged: (value){
                          setState(() {
                            height = value;
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
               children: [
                Expanded(
                  child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[400]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Age',style:
                        TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text('$age',style:
                        TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           FloatingActionButton(
                             onPressed: (){
                               setState(() {
                                 age --;
                               });
                             },
                             heroTag: 'age-',
                             mini: true,
                           child: Icon(Icons.remove),

                           ),
                           FloatingActionButton(
                             onPressed: (){
                               setState(() {
                                 age ++;
                               });
                             },
                             heroTag: 'age+',
                           mini: true,
                             child: Icon(Icons.add),
                           )
                         ],
                       ),
                      ],
                    ),
                  ),
                ),
                 SizedBox(width: 20,),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Colors.grey[400]),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('Weight',style:
                         TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                         Text('$weight',style:
                         TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             FloatingActionButton(
                               onPressed: (){
                                 setState(() {
                                   weight --;
                                 });
                               },
                               heroTag: 'weight-',
                               mini: true,
                               child: Icon(Icons.remove),

                             ),
                             FloatingActionButton(
                               onPressed: (){
                               setState(() {

                                 weight ++;
                               });
                             },
                               heroTag: 'weight+',
                               mini: true,
                               child: Icon(Icons.add),
                             )
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
              ),
            ),
          ),
          Container (
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(onPressed: () {
              double result = weight / pow(height / 100, 2);
              print(result.round());

              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) =>
                      BmiResults(
                          result: result.round(),
                          isMale: isMale,
                          age: age
                      ),
                ),
              );
            },
              height: 50,
              child: Text('Calculate',style:
                TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
            ),
          ),
        ],
      ),
    );
  }
}
