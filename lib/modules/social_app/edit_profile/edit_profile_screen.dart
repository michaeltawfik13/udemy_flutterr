import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/icon_broken.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';
import 'package:uri/uri.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context)!.userModel;
        var profileImage = SocialCubit.get(context)!.profileImage;
        var coverfileImage = SocialCubit.get(context)!.coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel!.bio;
        phoneController.text = userModel!.phone;
        emailController.text = userModel!.email;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                      email: emailController.text);
                },
                child: Text('UPDATE'),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 180,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: coverfileImage == null
                                        ? NetworkImage('${userModel?.cover}')
                                        : FileImage(coverfileImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  )),
                            ),
                          ],
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel!.image}')
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: 18,
                                )),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null )
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: MaterialButton(
                                      onPressed: () {
                                        SocialCubit.get(context).uploadprofileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text,
                                            email: emailController.text);
                                      }, child: Text('Upload Profile'),
                                  color: defaultColor,
                                    textColor: Colors.white,
                                  ),
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  SizedBox(height: 5,),
                                 if (state is SocialUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),

                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: MaterialButton(onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        email: emailController.text);
                                  },child: Text('Upload Cover'),color: defaultColor,
                                  textColor: Colors.white,
                                  ),
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  SizedBox(height: 5,),
                                if (state is SocialUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),

                      ],
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be Empty';
                      }
                      return null;
                    },
                    labelText: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be Empty';
                      }
                      return null;
                    },
                    labelText: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be Empty';
                      }
                      return null;
                    },
                    labelText: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Email must not be Empty';
                      }
                      return null;
                    },
                    labelText: 'Email',
                    prefix: IconBroken.User1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
