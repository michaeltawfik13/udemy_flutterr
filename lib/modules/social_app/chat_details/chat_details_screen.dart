import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/socialApp/message_model.dart';
import 'package:udemy_flutterr/models/socialApp/social_model.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';
import 'package:uri/uri.dart';


class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;

  var messController = TextEditingController();

  ChatDetailsScreen({
    this.userModel
});

  @override
  Widget build(BuildContext context) {


        return Builder(
          builder: (BuildContext context) {
            SocialCubit.get(context).getMessages(recieverId: userModel!.uId);

          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel?.image}'),
                      ),
                      SizedBox(width: 10,),
                      Text('${userModel?.name}'),
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.length >= 0,
                  builder: (context) =>  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index)
                              {
                                var message = SocialCubit.get(context).messages[index];

                                if(SocialCubit.get(context).userModel!.uId == message.senderId )
                                 { return buildMyMessage(message);}

                                 return buildMessage(message);

                              },
                              separatorBuilder: (context,index) => SizedBox(height: 15,),
                              itemCount: SocialCubit.get(context).messages.length
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          //علشان يقص الrow علي اساس boxdecoration
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here',
                                  ),

                                ),
                              ),
                              Container(
                                color: defaultColor,
                                height: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        recieverId: userModel!.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messController.text);
                                  },
                                  minWidth: 1,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ),
              );
            },
          );
            },

        );
      }


  }

  Widget buildMessage(MessageModel model) =>  Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(5),
            topEnd: Radius.circular(5),
            bottomEnd: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(model.text)),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.5),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(5),
            topEnd: Radius.circular(5),
            bottomStart: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(model.text)),
  );

