
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/splash_screen/splash_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/bloc_observer.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  toast(text: 'Background message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget = LoginScreen();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    toast(text: 'on message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    toast(text: 'opened app message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget;
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            home: AnimatedSplashScreen(
              splash: SplashScreen(),
              backgroundColor: defaultColor,
              nextScreen: startWidget,
              splashIconSize: 250,
              splashTransition: SplashTransition.scaleTransition,
              animationDuration: Duration(milliseconds: 2000),
            ),
          );
        },
      ),
    );
  }
}
