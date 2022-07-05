import 'package:esmserviceweb/bodys/list_phtoto.dart';
import 'package:esmserviceweb/bodys/take_photo.dart';
import 'package:esmserviceweb/bodys/web_service.dart';
import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/utility/my_dialog.dart';
import 'package:esmserviceweb/widgets/show_image.dart';
import 'package:esmserviceweb/widgets/show_menu.dart';
import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? nameLogin;
  var bodys = <Widget>[
    const WebService(),
    const TakePhoto(),
    const ListPhoto(),
  ];
  int indexBody = 0;
  var titles = <String>[
    'Web Service',
    'Take Photo',
    'List Photo',
  ];

  @override
  void initState() {
    super.initState();
    findNameLogin();
    setupMessage();
  }

  Future<void> setupMessage() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print('## token == > $token');

    //For FrontEnd Service
    FirebaseMessaging.onMessage.listen((event) {
      String? title = event.notification!.title;
      String? body = event.notification!.body;
      print('## onMessageWork title == > $title body == > $body');
      MyDialog(context: context).normalDialog(title: title!, subTitle: body!);
    });

    //For BackEnd Service
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String? title = event.notification!.title;
      String? body = event.notification!.body;
      print('## onOpenApp Work title == > $title body == > $body');
      MyDialog(context: context).normalDialog(title: title!, subTitle: body!);
    });
  }

  Future<void> findNameLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    nameLogin = preferences.getString('data');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ShowText(
          text: titles[indexBody],
          textStyle: MyConstant().h2WhiteStyle(),
        ),
        backgroundColor: MyConstant.primary,
      ),
      drawer: newDrawer(context),
      body: bodys[indexBody],
    );
  }

  Widget newDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const ShowImage(),
            decoration: MyConstant().gradienRadienBox(),
            accountName: ShowText(
              text: nameLogin ?? '',
              textStyle: MyConstant().h2WhiteStyle(),
            ),
            accountEmail: ShowText(
              text: 'Logined',
              textStyle: MyConstant().h3WhiteStyle(),
            ),
          ),
          ShowMenu(
            iconData: Icons.web,
            title: titles[0],
            pressFunc: () {
              Navigator.pop(context);
              setState(() {
                indexBody = 0;
              });
            },
          ),
          Divider(
            color: MyConstant.dark,
          ),
          ShowMenu(
              iconData: Icons.add_a_photo,
              title: titles[1],
              pressFunc: () {
                Navigator.pop(context);
                setState(() {
                  indexBody = 1;
                });
              }),
          Divider(
            color: MyConstant.dark,
          ),
          ShowMenu(
              iconData: Icons.list,
              title: titles[2],
              pressFunc: () {
                Navigator.pop(context);
                setState(() {
                  indexBody = 2;
                });
              }),
          Divider(
            color: MyConstant.dark,
          ),
          const Spacer(),
          Divider(
            color: MyConstant.dark,
          ),
          ShowMenu(
              iconData: Icons.exit_to_app,
              title: 'SignOut',
              pressFunc: () {
                Navigator.pop(context);
                MyDialog(context: context).normalDialog(
                    title: 'Sign Out?',
                    subTitle: 'Confirm SignOut by tap Confirm',
                    label: 'Confirm',
                    pressFunc: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear().then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/authen', (route) => false);
                      });
                    });
              }),
        ],
      ),
    );
  }
}
