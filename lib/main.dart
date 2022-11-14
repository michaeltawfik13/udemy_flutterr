import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/layout/Shop%20App/shop_layout.dart';
import 'package:udemy_flutterr/layout/Social%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Social%20App/social_layout.dart';
import 'package:udemy_flutterr/modules/basics_app/login/LoginScreen.dart';
import 'package:udemy_flutterr/modules/news_app/science/science.dart';
import 'package:udemy_flutterr/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutterr/modules/social_app/login/social_login_screen.dart';

import 'package:udemy_flutterr/shared/bloc_observer.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/cubit/cubit.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutterr/shared/styles/themes.dart';

import 'layout/News App/cubit/news_cubit.dart';
import 'layout/News App/news_layout.dart';
import 'layout/Todo App/todo_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/users/UserScreen.dart';

Future<void> main() async {


  // to be sure that all methods async are done
  WidgetsFlutterBinding.ensureInitialized();
  // /to intialize firebase
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;

//Shop App
//   bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
//   token = CacheHelper.getData(key: 'token');
//   print(token);
//
//   if (onBoarding != null) {
//     if (token != null)
//       widget = ShopLayout();
//     else
//       widget = ShopLoginScreen();
//   } else {
//     widget = OnBoardingScreen();
//   }
//
//   print(onBoarding);
/*--------------------------------------------------------------------------------*/
  //Social App
   uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
    {
      widget = SocialLayout();
    }else
      {
        widget = SocialLoginScreen();
      }

  //after that run app
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark, widget!));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final bool? isDark;
  //late final bool? onBoarding;
  final Widget startWidget;

  MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) // manage design on the screen
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()), // NewsCubit()..getBusiness()..getSports()..getScience(),معناها انه هيعمل لود للداتا للثلاثه مره واحده
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..ChangeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()..getFavorites()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                // home: Text('Hello World'),
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,

                //Colors.black),
                //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                themeMode: ThemeMode.light,
                home: SocialLayout(),//startWidget
                //onBoarding! ? ShopLoginScreen():OnBoardingScreen(),
                );
          }),
    );
  }
}
