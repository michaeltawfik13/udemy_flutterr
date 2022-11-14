import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings',
        style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold),),
    );
  }
}