
import 'package:flutter/material.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/pages/cafe_page.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: AuthPage(),
    // );

    // return ChangeNotifierProvider(
    //   create: (context) => Cafe(),
    //   builder: (context, child) => const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: AuthPage(),
    //   ),
    // );
    // )

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cafe()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
      
  }
}
