import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/src/helpers/style.dart';
import 'package:flutter_food_delivery/src/providers/auth.dart';
import 'package:flutter_food_delivery/src/screens/home.dart';
import 'package:flutter_food_delivery/src/screens/login.dart';
import 'package:flutter_food_delivery/src/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize())
  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Food App',
    theme: ThemeData(
      primarySwatch: red,
    ),
    home: ScreenController(),
  )));
}

class ScreenController extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final auth = Provider.of<AuthProvider>(context);
    switch(auth.status){
      case Status.Uninitialized:
        print("Uninitialized");
        return Loading();
      case Status.Unauthenticated:
        // print("Unauthenticated");
        // break;
      case Status.Authenticating:
        print("Authenticating");
        return LoginScreen();
      case Status.Authenticated:
        print("Authenticated");
        return Home();
      default:
        print("default");
        return LoginScreen();
    }
  }
}