import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/socialApp/post_model.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/icon_broken.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';
import 'package:http/http.dart' as http;

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state)
      {
        var usermodel = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
         condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) =>  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:
                      [
                        Image(
                          image:
                          NetworkImage(
                              '${usermodel?.cover}'),
                          fit: BoxFit.cover ,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Communicte with Friends',
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color: Colors.white

                            ),
                          ),
                        ),
                      ]

                  ),

                ),
                // SizedBox(height: 10,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  itemCount: SocialCubit.get(context).posts.length,
                  separatorBuilder: (BuildContext context, int index) => myDivider(),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

Widget buildPostItem(PostModel model , context, index) => Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 10,
  margin: EdgeInsets.symmetric(horizontal: 8),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage
                (
                  //'${SocialCubit.get(context).userModel?.image}'
                'https://img.freepik.com/free-photo/pleased-young-female-doctor-wearing-medical-robe-stethoscope-around-neck-standing-with-closed-posture_409827-254.jpg?w=996&t=st=1667408161~exp=1667408761~hmac=8d65df3436110ec5dc2cdd5504d18527a51c1340cfcacf41b7b87551138c7117'
              ),
            ),
            SizedBox(width: 10,),
            Expanded
              (child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${model.name}',
                      style: TextStyle(
                          height: 1.2
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.check_circle,
                      color: defaultColor,
                      size: 20,
                    ),
                  ],
                ),
                Text('${model.dateTime}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      height: 1.9
                  ),

                )
              ],
            )),
            IconButton(
              onPressed: (){}, icon:Icon(Icons.more_horiz,size: 18,),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Text('${model.text}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Container(
        //     width: double.infinity,
        //     child: Wrap(
        //       crossAxisAlignment: WrapCrossAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsetsDirectional.only(end:10),
        //           child: Container(
        //             height: 25,
        //             child: MaterialButton(
        //                 minWidth: 1,
        //                 padding: EdgeInsets.zero,
        //                 onPressed: (){}, child: Text('# Software Engineer',
        //               style: TextStyle(
        //                 color: defaultColor,
        //               ),
        //             )),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsetsDirectional.only(end:10),
        //           child: Container(
        //             height: 25,
        //             child: MaterialButton(
        //                 minWidth: 1,
        //                 padding: EdgeInsets.zero,
        //                 onPressed: (){}, child: Text('# Software Engineer',
        //               style: TextStyle(
        //                 color: defaultColor,
        //               ),
        //             )),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        if(model.postImage != '')
        Padding(
          padding: const EdgeInsets.only(
             top: 8,
          ),
          child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      '${model.postImage}'),
                  fit: BoxFit.cover ,

                ),)

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5,),
                        Text('${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(IconBroken.Chat,
                        size: 18,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 5,),
                      Text('0 Comment',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('${SocialCubit.get(context).userModel?.image}'),
            ),
            SizedBox(width: 10,),
            InkWell(
              child: Text('write comment ...',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
              onTap: (){},
            ),
            Spacer(),
            InkWell(
              child: Row(
                children: [
                  Icon(IconBroken.Heart,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10,),
                  Text('LIKE',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              onTap: ()
              {
                SocialCubit.get(context).postLikes(SocialCubit.get(context).postId[index]);
              },
            ),
          ],
        ),
      ],
    ),
  ),
);
}
