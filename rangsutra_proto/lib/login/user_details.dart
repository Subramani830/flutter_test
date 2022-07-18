import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool isLoading = false;
  String fullName = '';
  String email = '';
  String apiKey = '';
  String apiSecret = '';
  @override
  void initState(){
    super.initState();
    getSessionDetails();
  }

  getSessionDetails() async{
    setState(() {
      isLoading = true;
    });
    fullName = await FlutterSession().get("full_name");
    email = await FlutterSession().get("token");
    apiKey = await FlutterSession().get("api_key");
    apiSecret = await FlutterSession().get("api_secret");

    print("here"+fullName.toString());
    if (fullName!=''){
      setState(() {
        isLoading = false;
      });
    }
    // token = await FlutterSession().get("token");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pages.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){
                  FlutterSession().set('token', '');
                  Navigator.pushNamed(context, 'login');
                },
                icon: const Icon(Icons.power_settings_new_sharp)
            ),
          ],
        ),
        body: SingleChildScrollView(child: Column(children: <Widget>[
        ProfilePicture(
          name: fullName.toString(),
          radius: 35,
          fontsize: 25,
          //random: true,
        ),
          Card(
            elevation: 2,
            color: Colors.blueGrey.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "Full Name: "+fullName+"\n",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "E-mail : "+ email+"\n",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                      "Api Key: "+ apiKey+"\n"
                  ),
                  Text(
                      "Api Secret: "+ apiSecret
                  )
                ],
              ),
            ),
          ),
        ]
        ))
    ),
    );
  }
}
