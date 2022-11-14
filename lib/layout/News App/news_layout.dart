
import  'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/News%20App/cubit/news_states.dart';
import 'package:udemy_flutterr/modules/news_app/search/search_screen.dart';

import 'package:udemy_flutterr/shared/cubit/cubit.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';

import '../../shared/components/components.dart';
import 'cubit/news_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (BuildContext context, state) {  },

        builder: (BuildContext context, Object? state)
        {
         var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 20,
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context,SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: ()
                    {
                     AppCubit.get(context).ChangeAppMode();
                    },icon:Icon(Icons.brightness_4_outlined))
              ],
            ),
            body: cubit.screens[cubit.CurrentIndex] ,

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.CurrentIndex,
              onTap: (index)
              {
                 cubit.ChangeBottomBar(index);
              },
              items: cubit.bottomItems,),
          );
        },

      );

  }
}
