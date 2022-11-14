import 'package:udemy_flutterr/models/shopApp/login_model.dart';

abstract class SocialLoginStates {}

class   SocialInitialLoginState extends SocialLoginStates{}

class   SocialLoginLoadingState extends SocialLoginStates{}

class   SocialLoginSuccessState extends SocialLoginStates
{
  late final String uId;

  SocialLoginSuccessState(this.uId);
}

class   SocialLoginErrorState extends SocialLoginStates
{
  late final String error;

  SocialLoginErrorState(this.error);

}
class   SocialChangePasswordState extends SocialLoginStates{}
