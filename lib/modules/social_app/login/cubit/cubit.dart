import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/modules/social_app/login/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit(): super(SocialInitialLoginState());


  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // SocialLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
})
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      emit(SocialLoginErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off_outlined;
 emit(SocialChangePasswordState());
  }

}