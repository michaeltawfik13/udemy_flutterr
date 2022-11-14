
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/icon_broken.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';
import 'package:uri/uri.dart';


class NewPOstScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                  onPressed: () {
                    final now = DateTime.now();
                    print(now.toString());

                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 20),
                  ))
              // defaultTextButton(function: ()
              //
              //  {
              //    final now = DateTime.now();
              //    print(now.toString()) ;
              //
              //    if(SocialCubit.get(context).postImage == null)
              //      {
              //        SocialCubit.get(context).createPost(
              //            dateTime: now.toString() ,
              //            text: textController.text);
              //      }else
              //        {
              //          SocialCubit.get(context).uploadPostImage(
              //              dateTime: now.toString(),
              //              text: textController.text);
              //        }
              //  }, text: 'Post', fontSize: 20)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoading)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoading)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel?.image}'),   ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      '${SocialCubit.get(context).userModel?.name}',
                      style: TextStyle(height: 1.2),
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Write  here  your status ?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).postImage != null)
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          )),
                      CircleAvatar(
                        radius: 20,
                        child: IconButton(
                            onPressed: ()
                            {
                                SocialCubit.get(context).removePostImage();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 18,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo',
                                  style: TextStyle(
                                    color: defaultColor,
                                  )),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text('# Tags',
                              style: TextStyle(
                                color: defaultColor,
                              ))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
