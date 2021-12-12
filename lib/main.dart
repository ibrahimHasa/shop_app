import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/home_layout/home_layout.dart';

import 'package:souq/layout/state_management/bloc_observer.dart';
import 'package:souq/layout/state_management/cubit/shop_cubit.dart';
import 'package:souq/modules/login/login_screen.dart';
import 'package:souq/modules/on_boarding/on_boarding_screen.dart';
import 'package:souq/shared/constants/constants.dart';
import 'package:souq/shared/network/local/cache_helper.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';
import 'package:souq/shared/styles/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
   token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  print(onBoarding);
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getCategories(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleSpacing: 20,
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
                color: defaultColor, fontSize: 30, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: defaultColor),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              elevation: 30),
          primarySwatch: defaultColor,
        ),
        home: startWidget,
      ),
    );
  }
}
// onBoarding?LoginScreen():