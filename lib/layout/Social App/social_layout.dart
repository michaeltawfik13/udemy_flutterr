import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/modules/social_app/feeds/new_post/new_post_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state)
      {
        if( state is SocialNewPostState)
          {
            navigateTo(context, NewPOstScreen());
          }
      },
      builder: (BuildContext context, Object? state)
      {
        var cubit = SocialCubit.get(context);
        return   Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.CurrentIndex],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
            ],
          ),

          // body: ConditionalBuilder(
          //     condition: SocialCubit.get(context).model != null,
          //     builder: (context)
          //     {
          //       var model = SocialCubit.get(context).model;
          //
          //
          //       return Column(
          //         children: [
          //          // if(!model!.isEmailVerified)
          //           if(!FirebaseAuth.instance.currentUser!.emailVerified)
          //           Container(
          //             color: Colors.amber.withOpacity(0.7),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10),
          //               child: Row(
          //                 children: [
          //                   Icon(Icons.info_outline),
          //                   SizedBox(width: 10,),
          //                   Expanded(
          //                     child: Text('Verify your email',
          //                       style: TextStyle(
          //                           fontSize: 25, fontWeight: FontWeight.bold ),),
          //                   ),
          //                   SizedBox(width: 20,),
          //                   defaultButton(
          //                       width: 90 ,
          //                       function: ()
          //                       {
          //                         FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value)
          //                         {
          //                            showToast(text: 'Check your mail', state: ToastStates.SUCCESS);
          //                         }).catchError((error){});
          //                       },
          //                       text: 'Send'),
          //
          //
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          // fallback: (context) => Center(child: CircularProgressIndicator()),
          // )
          body: cubit.screens[cubit.CurrentIndex],
          bottomNavigationBar:
            BottomNavigationBar(
              currentIndex: cubit.CurrentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),
                  label: 'Chats'
                ),
                BottomNavigationBarItem(icon: Icon(IconBroken.Upload),
                    label: 'Post'
                ),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),
                  label: 'Users'
                ),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting),
                  label: 'Settings'
                ),
              ]),

        );  },

    );
  }
}
