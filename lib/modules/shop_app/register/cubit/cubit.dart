import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopRegitserCubit extends Cubit<ShoprRegisterStates>
{
  ShopRegitserCubit(): super(ShopInitialRegisterState());

  static ShopRegitserCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel;

  void userRegister({
    required String name,
   required String email,
    required String password,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: Register,
        data:
    {
      'name' : name,
      'email':email,
      'password':password,
      'phone' : phone,
    }).then((value)
    {
      print(value?.data);
      ShopLoginModel.fromJson(value?.data);
      loginModel = ShopLoginModel.fromJson(value?.data);
      // print(RegisterModel!.data?.phone);
      // print(RegisterModel!.data?.token);
      // print(value?.data["message"]);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }

}