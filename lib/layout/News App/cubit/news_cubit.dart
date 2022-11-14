import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/News%20App/cubit/news_states.dart';
import 'package:udemy_flutterr/modules/news_app/business/business.dart';
import 'package:udemy_flutterr/modules/news_app/science/science.dart';
import 'package:udemy_flutterr/modules/news_app/sports/sports.dart';
import 'package:udemy_flutterr/modules/settings/settings.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super (InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
  BottomNavigationBarItem(
      icon: Icon(Icons.business),
       label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_rounded,),
    label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),
    label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings),
        label: 'Settings'),
  ];

  List<Widget> screens = [
    Business(),
    Sports(),
    Science(),
    Settings(),

  ];

  void ChangeBottomBar(int index)
  {
    CurrentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNav());
  }

  List<dynamic> business = [];

  //business
  void getBusiness()
  {
    emit(NewsGetLoadingbusinessState());

      DioHelper.getData(
          url:'v2/everything',
          query: {
            'q':'tesla',
            'sortBy':'publishedAt',
            'apiKey':'a28f31daaf9f47eaa2d544f2bd2a4b20',
          }).then((value) {
        // print(value?.data['articles'][0]['title']);
        business = value?.data['articles'];
        print(business[0]['titles']);

        emit(NewsGetBusinessSuccess());

      }).catchError((error){
        print(error.toString());

        emit(NewsGetBusinessError(error.toString()));
      });

  }

List<dynamic> sports = [];

  //sports
  void getSports()
  {
  emit(NewsGetLoadingSportsState());
  if(sports.length == 0)
    {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'apple',
            'from' : '2022-06-25T12:41:45Z',
            'apiKey':'a28f31daaf9f47eaa2d544f2bd2a4b20',
          }).then((value)
      {
        sports = value?.data['articles'];
        print(sports[0]['titles']);
        emit(NewsGetSportsSuccess());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsError(error));
      });
    }else
      {
        emit(NewsGetSportsSuccess());
      }


    }

    //science
    List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetLoadingScienceState());
    if(science.length == 0)
      {
        DioHelper.getData(
            url: 'v2/everything',
            query: {
              'q':'apple',
              'from' : '2022-06-25T12:41:45Z',
              'apiKey':'a28f31daaf9f47eaa2d544f2bd2a4b20',
            }).then((value)
        {
          science = value?.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccess());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceError(error));
        });
      }


  }

  //search
List<dynamic> search =[];

  void getSearch(String value)
  {
    emit(NewsGetLoadingSearchState());
    search = [];
    DioHelper.getData(
        url: 'v2/everything',
        query: {
        'q':'$value',
          'apiKey' : 'a28f31daaf9f47eaa2d544f2bd2a4b20',
        }).then((value)
    {
      search = value?.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccess());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchError(error));
    });
  }

}
