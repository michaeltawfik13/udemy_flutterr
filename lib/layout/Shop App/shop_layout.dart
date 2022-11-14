import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutterr/modules/shop_app/products/products.dart';
import 'package:udemy_flutterr/modules/shop_app/search/search_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit,ShopStates>(
         listener: (context, state) {} ,
         builder: (context, state)
         {
           return Scaffold(
             appBar: AppBar(
               title: Text(
                   'Makanak'
               ),
               actions: [
                 IconButton(
                     onPressed: ()
                     {
                       navigateTo(context, ShopSearchScreen());
                     }, icon: Icon(Icons.search)),
               ],
             ),
             body: cubit.bottomScreens[cubit.currentIndex],
             bottomNavigationBar: BottomNavigationBar(
               onTap: (index)
               {
                 cubit.changeBottom(index);

               },
                 currentIndex: cubit.currentIndex,
                 items: [
                   BottomNavigationBarItem (
                       icon: Icon(Icons.home),
                       label:'Home'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.category),
                       label:'Categories'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.favorite),
                       label:'Favorites'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.settings),
                       label:'Settings'),
                 ]) ,
           );
         });
  }
}
