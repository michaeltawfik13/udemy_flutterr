import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/models/socialApp/social_model.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutterr/modules/social_app/register/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class SocialRegitserCubit extends Cubit<SocialRegisterStates>
{
  SocialRegitserCubit(): super(SocialInitialRegisterState());

  static SocialRegitserCubit get(context) => BlocProvider.of(context);

  void userRegister({
  required String name,
    required String email,
    required String password,
    required String phone,
    required bool isEmailVerified,
})
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
    {
      print(value.user!.email);
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
        isEmailVerified:isEmailVerified,

          );
    print(value.user!.email);
     //emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
    }

    void createUser({
      required String name,
      required String email,
      required String phone,
      required String uId,
      required bool isEmailVerified
    })
{
  SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone:  phone,
      uId:  uId,
     image: 'https://img.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_1303-29791.jpg?w=996&t=st=1666277553~exp=1666278153~hmac=d570999552add58ea61abc2be97fc9722b3bce3b0233150142125d1d2329d915',
     cover: 'https://img.freepik.com/free-photo/close-up-happy-brunette-girl-white-t-shirt-laughing-smiling-carefree-camera_1258-19129.jpg?w=996&t=st=1666181884~exp=1666182484~hmac=7febef48bc99441a8d46dddbc2f2c258df68c06efc9465a5706864e3c527582a',
    bio: 'Write your Bio ...',
    isEmailVerified: false,

  );

  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
  {

    emit(SocialCreateUserSuccessState());
  }
  ).catchError((error)
      {
        emit(SocialCreateUserErrorState(error.toString()));
      });
}

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordState());
  }

}