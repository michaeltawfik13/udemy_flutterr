import 'dart:convert';
//import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/shopApp/categories_model.dart';
import 'package:udemy_flutterr/models/shopApp/change_favorites_model.dart';
import 'package:udemy_flutterr/models/shopApp/favorites_model.dart';
import 'package:udemy_flutterr/models/shopApp/home_model.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/modules/news_app/search/search_screen.dart';
import 'package:udemy_flutterr/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy_flutterr/modules/shop_app/favorites/favorites.dart';
import 'package:udemy_flutterr/modules/shop_app/products/products.dart';
import 'package:udemy_flutterr/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutterr/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: Home,
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      // print(homeModel?.data.banners[0].image);
      // print(homeModel?.status);

      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      url: Get_Categories,
      token: token, //مش لازم يتبعت
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      print(homeModel?.status);

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
        url: Favorites,
        data: {
          'product_id': productId
        },
        token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }else
      {
        getFavorites(); // علشان يعمل لثف للداتا في الfavoritesScreen عشان يبقي real Time
      }

      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel!));
    }).catchError((error) {
      //favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesDataState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {

    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
      url: Favorites,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      print(value?.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;
  void getUserData() {

    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      print(userModel?.data!.name);

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,

  }) {

    emit(ShopLoadingUpdateDataState());
    DioHelper.putData(
      url: Update_Profile,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      print(userModel?.data!.name);

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }
}