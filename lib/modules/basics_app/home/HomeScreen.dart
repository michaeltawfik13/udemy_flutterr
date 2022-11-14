import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          shadowColor: Colors.black,
          elevation: 12,
          leading: Icon(Icons.menu),
          title: Text('First App'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: Search, icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  print('Hello');
                },
                icon: Icon(
                  Icons.settings,
                )),
          ],
        ),
        body: Container(
          color: Colors.blueGrey,
          width: double.infinity,
          child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
               Column(
                 children: [
                   Container(
                     width: 150,
                     child: Stack(
                       children: [
                         Container(
                           child: Image.network('https://jesuschristsavior.net/Savior.jpeg?crop',
                             height: 200,
                             width: double.infinity,
                             fit: BoxFit.cover,

                           ),
                         ),
                         Container(
                          // width: double.infinity,
                           child: Text('Jesus Christ',
                             style: TextStyle(

                               fontSize: 25,
                               color: Colors.black,
                               backgroundColor: Colors.black12,
                             ),

                           ),
                         ),

                       ],
                     ),
                   ),

                 ],
               ),
                Image.network('https://thumbs.dreamstime.com/z/divine-mercy-jesus-sacred-heart-cross-digital-painting-done-photoshop-182865498.jpg',
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,

                ),
                Image.network('https://jesuschristsavior.net/Savior.jpeg?crop',
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,

                ),



              /*  Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text(
                    'First Widget',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Second Widget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    'Third Widget',
                    style: TextStyle(fontSize: 25, backgroundColor: Colors.red),
                  ),
                ),

*/
              ],
            ),
          ),
        ));
    

  }

  void Search() {
    print('Search Button Pressed');
  }

  void Settings() {
    print('Settings Button Pressed');
  }
}
