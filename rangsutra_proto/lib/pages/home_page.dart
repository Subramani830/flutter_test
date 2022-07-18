import '../main.dart';
import 'package:flutter/material.dart';
import '../pages/orders_page.dart';
import '../login/user_details.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String siteUrl = '';
  String fullName = '';
  @override
  void initState() {
    super.initState();
    print('hi there');
    getSessionDetails();
  }

  getSessionDetails() async{
    //setState(() async {
      siteUrl = await FlutterSession().get("site_url");
    //});

    print("URL"+siteUrl.toString());
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'user_details');

                },
                icon: const Icon(Icons.account_circle_outlined)
            ),
            IconButton(
                onPressed: (){
                  FlutterSession().set('token', '');
                  Navigator.pushNamed(context, 'login');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                  //Navigator.pop(context);
                },
                icon: const Icon(Icons.power_settings_new_sharp)
            ),
          ],
        ),
        body: SingleChildScrollView(child: Column(children: <Widget>[
          FutureBuilder(
              future: FlutterSession().get('token'),
              builder: (context , snapshot){

                //fullName = snapshot.hasData ? snapshot.data.toString() : 'Loading..' ;
                return const Text('');
              }),
          Card(
            color: Colors.blueGrey.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            shadowColor: Colors.black,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.orders, style: TextStyle(fontSize: 20.0,
                    color: Colors.white70),
                textAlign: TextAlign.center,),
                onPressed: () {
                  print('pressed');
                  Navigator.pushNamed(context, 'orders_page');
                  //print(customertxt);
                },
              ),
            ),
          ),
          Card(
            color: Colors.blueGrey.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            child: Container(
                width: double.infinity,
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: const Text('Artisan', style: TextStyle(fontSize: 20.0,
                    color: Colors.white70),
                  textAlign: TextAlign.center,),
                onPressed: () {
                  Navigator.pushNamed(context, 'artisan_page');
                  print('pressed');
                },
              ),
            ),
          ),
          Card(
            color: Colors.blueGrey.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            child: Container(
                width: double.infinity,
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: const Text('Orders Overdue', style: TextStyle(fontSize: 20.0,
                color: Colors.white70),
                  textAlign: TextAlign.center,),
                onPressed: () {
                  print('pressed');
                },
              ),
            ),
          ),
        ]
        ))
      ),
    );
  }
}
