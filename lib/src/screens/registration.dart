import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/src/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/src/helpers/style.dart';
import 'package:flutter_food_delivery/src/providers/auth.dart';
import 'package:flutter_food_delivery/src/screens/home.dart';
import 'package:flutter_food_delivery/src/screens/login.dart';
import 'package:flutter_food_delivery/src/widgets/custom_text.dart';
import 'package:flutter_food_delivery/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _key,
      body: authProvider.status == Status.Authenticating ? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/lg.png",width: 240,height: 240,),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: blue),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:  TextFormField(
                      controller: authProvider.name,
                      decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: "User Name",
                          icon: Icon(Icons.person)
                      ),
                    ),
                  )
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: blue),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:  TextFormField(
                      controller: authProvider.email,
                      decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: "Email",
                          icon: Icon(Icons.phone)
                      ),
                    ),
                  )
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: blue),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:  TextFormField(
                      controller: authProvider.password,
                      decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: "Password",
                          icon: Icon(Icons.lock)
                      ),
                    ),
                  )
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () async{
                  if(!await authProvider.signUp()){
                    // ignore: deprecated_member_use
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Registration Failed"))
                    );
                    return;
                  }
                  authProvider.cleanController();
                  changeScreenReplacement(context, Home());
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: red,
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(text: "Register",color: white, size: 22,)
                        ],
                      ),
                    )
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                changeScreen(context, LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Log In Here",size: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}