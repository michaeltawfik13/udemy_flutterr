import 'package:udemy_flutterr/models/shopApp/change_favorites_model.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/modules/users/UserScreen.dart';

abstract class ShopStates {}


class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavoritesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesDataState extends ShopStates
{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopErrorChangeFavoritesDataState extends ShopStates {}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates
{
  late final ShopLoginModel loginModel;
  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateDataState extends ShopStates {}

class ShopSuccessUpdateDataState extends ShopStates
{
  late final ShopLoginModel loginModel;
  ShopSuccessUpdateDataState(this.loginModel);
}

class ShopErrorUpdateDataState extends ShopStates {}