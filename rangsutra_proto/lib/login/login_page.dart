import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            //Image.asset("assets/login.png", width: 170, height: 300),
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Rangsutra Crafts India Ltd.',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: urlController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Url",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  child: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                                ),
                            ),
                            obscureText: _obscure,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      print("pressed123");
                                      var headers = {
                                        'Accept': 'application/json',
                                        'Content-Type': 'application/json'
                                      };
                                      var request = http.Request('GET', Uri.parse(urlController.text+'/api/method/login'));
                                      request.body = '''{\n    "usr": "'''+ nameController.text +'''",\n    "pwd": "''' + passwordController.text + '''"\n}''';
                                      request.headers.addAll(headers);
                                      http.StreamedResponse response = await request.send();

                                      if (response.statusCode != 200) {
                                        showAlertDialog(context);
                                        print(nameController.text);
                                        print(passwordController.text);
                                        var bdy = '''{\n    "usr": "'''+ nameController.text.toString() +'''",\n    "pwd": "''' + passwordController.text.toString() + '''"\n}''';
                                        print(bdy);
                                      } else{
                                        var apiRequest = http.Request('GET', Uri.parse(urlController.text+'/api/method/rangsutra.api.login'));
                                        apiRequest.body = '''{\n    "usr": "'''+ nameController.text +'''",\n    "pwd": "''' + passwordController.text + '''"\n}''';
                                        apiRequest.headers.addAll(headers);
                                        http.StreamedResponse apiResponse = await apiRequest.send();

                                        //check the response data
                                        final respStr = await response.stream.bytesToString();
                                        final apiRespStr = await apiResponse.stream.bytesToString();

                                        print (apiRespStr);

                                        var login_details = json.decode(apiRespStr)['message'];
                                        print(login_details["username"]);
                                        print(json.decode(apiRespStr)['full_name']);

                                        await FlutterSession().set("token", nameController.text);
                                        await FlutterSession().set("site_url", urlController.text);
                                        await FlutterSession().set("full_name", json.decode(apiRespStr)['full_name'].toString());
                                        await FlutterSession().set("api_key", login_details['api_key'].toString());
                                        await FlutterSession().set("api_secret", login_details['api_secret'].toString());
                                        Navigator.pushNamed(context, 'home_page');
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => const HomePage()),
                                        // );
                                        //setState(() => this._status = 'loading');
                                        //Navigator.of(context).pushReplacementNamed();
                                        print("Success");

                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Try Again"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error !!!",
      style: TextStyle(color: Color(0xFFF44336)),
    ),
    content: const Text("Incorrect user name or password ...."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}