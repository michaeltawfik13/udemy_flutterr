import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super(ShopInitialLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel;

  void userLogin({
   required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: Login,
        data:
    {
      'email':email,
      'password':password,
    }).then((value)
    {
      print(value?.data);
      ShopLoginModel.fromJson(value?.data);
      loginModel = ShopLoginModel.fromJson(value?.data);
      print(loginModel!.data?.phone);
      print(loginModel!.data?.token);
      print(value?.data["message"]);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off_outlined;
 emit(ShopChangePasswordState());
  }

}