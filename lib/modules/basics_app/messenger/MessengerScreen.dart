import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://thumbs.dreamstime.com/z/divine-mercy-jesus-sacred-heart-cross-digital-painting-done-photoshop-182865498.jpg'),
        ),
        title: Row(
          children: [
            Text(
              'Chat',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,

                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) => buildStoryItem(),
                    separatorBuilder: (context,index) => SizedBox(
                      width: 15,
                    ),
                    itemCount: 7,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
             ListView.separated(
               shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder:(context, index) =>buildChatItem() ,
                 separatorBuilder: (context, index) =>  SizedBox(
                   height: 20,
                 ),
                 itemCount:12 ),
          ],
          ),
        ),
      ),
    );
  }


  Widget buildStoryItem() =>  Container(
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/z/divine-mercy-jesus-sacred-heart-cross-digital-painting-done-photoshop-182865498.jpg'),
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        Container(
            alignment: Alignment.center,
            width: 50,
            child: Text(
              'Jesus Christ ',
              maxLines: 1,
              overflow:TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),

      ],
    ),
  );

 Widget buildChatItem() =>  Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://religionnews.com/wp-content/uploads/2020/06/webRNS-HEAD-OF-CHRIST-Sallman1-062420-291x369.jpg'),
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor:Colors.green ,
          ),
        ],
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Michael Tawfik Kamel Michael Tawfik Kamel',
              style: TextStyle(fontWeight: FontWeight.bold,
              ),
              maxLines:1 ,
              overflow: TextOverflow.ellipsis,),
            Row(
              children: [
                Expanded(
                  child: Text('Hello dear we are here Hello dear we are here Hello dear we are here' ,maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                ),
                Text('12:07 PM'),
              ],
            ),
          ],
        ),
      ),//chat

    ],
  );


}
