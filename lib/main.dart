import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app_clone/providers/user_provider.dart';
import 'package:instagram_app_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_app_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_app_clone/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './utilis/colors.dart';
import './responsive/responsive_layout_screen.dart';
import './responsive/mobile_screen_layout.dart';
import './responsive/web_screen_layout.dart';
import 'screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCpI0SnNZjGYNWUIAj5y4EVSXxTqD7kq_M",
        appId: "1:1093331087692:web:0ba55c88644ce1f3dbdfe9",
        messagingSenderId: "1093331087692",
        projectId: "instagram-clone-99e9a",
        storageBucket: "instagram-clone-99e9a.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        title: 'Instagram Clone',
        // home: ResponsiveLayout(
        //     webScreenLayout: WebScrenLayout(),
        //     mobileScreenLayout: MobileScrenLayout()),
        // home: SignupScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScrenLayout(),
                  mobileScreenLayout: MobileScrenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
