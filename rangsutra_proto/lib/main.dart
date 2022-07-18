import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../login/login_page.dart';
import '../pages/home_page.dart';
import '../pages/orders_page.dart';
import '../login/user_details.dart';
import '../pages/artisan_page.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


//WidgetsFlutterBinding.ensureInitialized();
//dynamic token = FlutterSession().get('token');
//runApp(token != '' ? const HomePage() : const MyApp());


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = await FlutterSession().get('token');
  print("text"+token.toString() );
  print(window.locale);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    supportedLocales: [
      Locale('en', ''),
      Locale('hi', ''),
    ],
    localizationsDelegates: const [
      AppLocalizations.delegate, // Add this line
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: token == '' ? const MyLogin() : const HomePage(),
    routes: {
      'home_page': (context) => const HomePage(),
      'login': (context) => const MyLogin(),
      'orders_page': (context) => const OrdersPage(),
      'user_details':(context) => const UserDetails(),
      'artisan_page':(context) => const ArtisanPage(),
    },
  ));
  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: const MyLogin(),
  //   routes: {
  //     'home_page': (context) => const HomePage(),
  //     'login': (context) => const MyLogin(),
  //     'orders_page': (context) => const OrdersPage(),
  //   },
  // ));
}

