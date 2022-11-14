import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:uri/uri.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state) {},
        builder: (context,state)
        {

          var userModel = SocialCubit.get(context).userModel;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children:
                      [
                        Align(
                          child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${userModel?.cover}'),
                                  fit: BoxFit.cover ,

                                ),)

                          ),
                          alignment: Alignment.topCenter,
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('${userModel?.image}'),
                          ),
                        ),
                      ]

                  ),
                ),
                SizedBox(height: 5,),
                Text('${userModel?.name}',
                  style: Theme.of(context).textTheme.bodyText1,),
                Text('${userModel?.bio}',
                  style: Theme.of(context).textTheme.caption,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle1,),
                              Text('Posts',
                                style: Theme.of(context).textTheme.caption,),
                            ],),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('512',
                                style: Theme.of(context).textTheme.subtitle1,),
                              Text('Photos',
                                style: Theme.of(context).textTheme.caption,),
                            ],),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('15K',
                                style: Theme.of(context).textTheme.subtitle1,),
                              Text('Followers',
                                style: Theme.of(context).textTheme.caption,),
                            ],),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('150',
                                style: Theme.of(context).textTheme.subtitle1,),
                              Text('Following',
                                style: Theme.of(context).textTheme.caption,),
                            ],),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                       Expanded(
                         child: OutlinedButton(onPressed: (){}, child: Text('Add Photos'),
                      ),
          ),
                       SizedBox(width: 10,),
                       OutlinedButton(
                           onPressed: ()
                           {
                             navigateTo(context, EditProfileScreen());
                           },
                         child: Icon(Icons.edit,
                         size: 18,),

                       ),

                  ],
                ),
              ],
            ),
          );
        });
  }
}
