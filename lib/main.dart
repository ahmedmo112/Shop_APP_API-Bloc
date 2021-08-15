import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'dart:ui' as ui;
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubit/appCubit.dart';
import 'package:shop_app/shared/cubit/appStates.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'layout/cubit/shopCubit.dart';
import 'modules/login/login_screen.dart';
import 'shared/constants/constants.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
//! if we did main async we must add => WidgetsFlutterBinding.ensureInitialized();
//!    and this mean  make sure that do all before RunApp() then runApp
//! بيتاكد ان كل حاجه هنا في الميثود خلصت وبعدين يفتح الابلكيشن

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  late Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(onBoarding);
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnboardingScreen();
  }

  runApp(MyApp(isDark: isDark, startWidget: widget));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;

  MyApp({
    this.startWidget,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..changeAppMode(fromShared: isDark!))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              title: 'Shop',
              //! //////////// //app theme ////////
              //* //////Light////////////
              theme: lightTheme,
              //* //////Dark////////////
              darkTheme: darktheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              //! ///////////////////////////////
              debugShowCheckedModeBanner: false,
              home: startWidget);
        },
      ),
    );
  }
}
