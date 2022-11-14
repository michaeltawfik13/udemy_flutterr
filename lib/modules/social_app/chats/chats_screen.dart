
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/socialApp/social_model.dart';
import 'package:udemy_flutterr/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
       builder: (context,state)
       {
         return ConditionalBuilder(
             condition: SocialCubit.get(context).users.length > 0,
             builder: (context) =>  ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
                 separatorBuilder: (context,index) => myDivider(),
                 itemCount: SocialCubit.get(context).users.length),
             fallback: (context) => Center(child: CircularProgressIndicator()),
         );
       },
     );
   }

  Widget buildChatItem(SocialUserModel model,context) =>  InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));

    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage
              (
               '${model.image}',
            ),
          ),
          SizedBox(width: 15,),
          Row(
            children: [
              Text('${model.name}',
                style: TextStyle(
                    height: 1.2
                ),
              ),
              SizedBox(width: 10,),

            ],
          ),
          Spacer(),
          IconButton(
            onPressed: (){}, icon:Icon(Icons.more_horiz,size: 18,),
          ),

        ],
      ),
    ),
  );
}
