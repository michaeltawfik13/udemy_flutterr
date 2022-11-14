import 'package:udemy_flutterr/models/shopApp/login_model.dart';

abstract class ShopLoginStates {}

class   ShopInitialLoginState extends ShopLoginStates{}

class   ShopLoginLoadingState extends ShopLoginStates{}

class   ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class   ShopLoginErrorState extends ShopLoginStates
{
  late final String error;

  ShopLoginErrorState(String error);

}
class   ShopChangePasswordState extends ShopLoginStates{}
