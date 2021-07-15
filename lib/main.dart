import 'package:flutter/material.dart';
import 'package:push_notifications/src/pages/home_page.dart';
import 'package:push_notifications/src/pages/message_page.dart';
import 'package:push_notifications/src/services/push_notifications_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationsService.messagesStream.listen((m) {
      print('MyApp: $m');
      final snackBar = SnackBar(content: Text(m));
      scaffoldKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications App',
      initialRoute: 'home',
      navigatorKey: navKey,
      scaffoldMessengerKey: scaffoldKey,
      routes: {
        'home': (BuildContext context) => HomePage(),
        'message': (BuildContext context) => MessagePage(),
      },
    );
  }
}
