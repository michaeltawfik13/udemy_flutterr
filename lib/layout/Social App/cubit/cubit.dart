import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/socialApp/message_model.dart';
import 'package:udemy_flutterr/models/socialApp/post_model.dart';
import 'package:udemy_flutterr/models/socialApp/social_model.dart';
import 'package:udemy_flutterr/models/users/user_model.dart';
import 'package:udemy_flutterr/modules/social_app/chats/chats_screen.dart';
import 'package:udemy_flutterr/modules/social_app/feeds/new_post/new_post_screen.dart';
import 'package:udemy_flutterr/modules/social_app/feeds/newsfeed_screen.dart';
import 'package:udemy_flutterr/modules/social_app/users/users_screen.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoading());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserError(error.toString()));
    });
  }

  int CurrentIndex = 0;

  List<Widget> screens = [
    NewsFeedScreen(),
    ChatsScreen(),
    NewPOstScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      CurrentIndex = index;
      emit(SocialChangeBottomState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedSuccessState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  //String profileImageUrl = '';

  void uploadprofileImage({
    required String name,
    required String phone,
    required String bio,
    required String email,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        . // يدخل الfirebase storage
        child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        . //هيتحرك ازاي جوه الفايل
        putFile(profileImage!)
        . //ابتدي الرفع
        then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value.toString());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          email: email,
          image: value,
        );
      }).catchError((error) {});
      emit(SocialUploadProfileImageErrorState());
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String coverImageUrl = '';

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    required String email,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        . // يدخل الfirebase storage
        child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        . //هيتحرك ازاي جوه الفايل
        putFile(coverImage!)
        . //ابتدي الرفع
        then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value.toString());

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          email: email,
          cover: value,
        );
        // coverImageUrl = value;
      }).catchError((error) {});
      emit(SocialUploadCoverImageErrorState());
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   required String email,
  // }) {
  //
  //   if(coverImage != null)
  //     {
  //       uploadCoverImage();
  //     }else if(profileImage != null)
  //     {
  //       uploadprofileImage();
  //     }else
  //       {
  //         updateUser(
  //             name: name,
  //             phone: phone,
  //             bio: bio,
  //             email: email
  //         );
  //       }
  //
  //
  //
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    required String email,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      uId: userModel!.uId,
      email: userModel!.email,
      image: image ??
          userModel!
              .image, // law image == null استخدم الصوره الاساسيه userModel!.image
      cover: cover ??
          userModel!
              .cover, // law image == null استخدم الصوره الاساسيه userModel!.cover
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        . // يدخل الfirebase storage
        child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        . //هيتحرك ازاي جوه الفايل
        putFile(postImage!)
        . //ابتدي الرفع
        then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {});
      emit(SocialCreatePostError());
    }).catchError((error) {
      emit(SocialCreatePostError());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoading());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!
          .image, // law image == null استخدم الصوره الاساسيه userModel!.image
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text, // law image == null استخدم الصوره الاساسيه userModel!.cover
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap()) // set هتخليه يعمل doc و يحط فيه البوست
        .then((value) {
      emit(SocialCreatePostSuccess());
    }).catchError((onError) {
      emit(SocialCreatePostError());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      });

      emit(SocialGetPostsSuccess());
    }).catchError((error) {
      emit(SocialGetPostsError(error.toString()));
    });
  }

  void postLikes(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel?.uId)
        .set({'Like': true}).then((value) {
      emit(SocialLikesPostsSuccess());
    }).catchError((error) {
      emit(SocialLikesPostsError(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          // if(element.data()['uId'] != userModel?.uId) // علشان يجيب كل الusers ماعدا user بتاعي انا
          users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccess());
      }).catchError((error) {
        emit(SocialGetAllUserError(error.toString()));
      });
  }

  void sendMessage({
    required recieverId,
    required dateTime,
    required text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel!.uId,
        recieverId: recieverId,
        dateTime: dateTime,
        text: text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((onError) {
      emit(SocialSendMessageError());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId!)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((onError) {
      emit(SocialSendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String recieverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots() // stream (queue of future data)
        .listen((event) {
      //  if(messages.length > 0)            //messages list = 0
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccess());
    });
  }

  // List<BottomNavigationBarItem> socialNav = [
  //   BottomNavigationBarItem(
  //       icon: ,
  //       label:
  //   )
  // ];
}
