import 'package:flutter/material.dart';
import 'package:udemy_flutterr/models/users/user_model.dart';
class UserModel
{
  final int id;
  final String name;
  final String num;

  UserModel({
    required this.id,
    required this.name,
    required this.num,
});
}


class UserScreen extends StatelessWidget {

  List<UserModel> users = [
    UserModel(name:'Michael Tawfik', num: '01220986806', id: 1),
    UserModel(name:'Mina Tawfik', num: '01849849878', id: 2),
    UserModel(name:'Samir Tawfik', num: '04897897489', id: 3),
    UserModel(name:'Michael Tawfik', num: '01220986806', id: 1),
    UserModel(name:'Mina Tawfik', num: '01849849878', id: 2),
    UserModel(name:'Samir Tawfik', num: '04897897489', id: 3),
    UserModel(name:'Michael Tawfik', num: '01220986806', id: 1),
    UserModel(name:'Mina Tawfik', num: '01849849878', id: 2),
    UserModel(name:'Samir Tawfik', num: '04897897489', id: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),

      ),
      body:
        ListView.separated(
            itemBuilder: (context, index) => buildUserItem(users[index]),
            separatorBuilder:(context,index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[200],
            ),
            itemCount: users.length )
    );
  }


  Widget buildUserItem(UserModel users) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          child: Text('${users.id}',
            style: TextStyle(color: Colors.red,fontSize: 50,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${users.name}',
                style: TextStyle(fontWeight: FontWeight.bold) ,),
              Text('${users.num}',
                style: TextStyle(color: Colors.green) ,),
            ],
          ),
        ),
      ],
    ),
  );

}
