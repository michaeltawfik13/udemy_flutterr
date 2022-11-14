import 'package:udemy_flutterr/models/shopApp/login_model.dart';

abstract class ShoprRegisterStates {}

class   ShopInitialRegisterState extends ShoprRegisterStates{}

class   ShopRegisterLoadingState extends ShoprRegisterStates{}

class   ShopRegisterSuccessState extends ShoprRegisterStates
{
   late final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class   ShopRegisterErrorState extends ShoprRegisterStates
{
  late final String error;

  ShopRegisterErrorState(String error);

}
class   ShopRegisterChangePasswordState extends ShoprRegisterStates{}
