import 'package:at_tylers_demo/screens/ChatWithAtsign.dart';
import 'package:at_tylers_demo/screens/ChatsScreen.dart';
import 'package:at_tylers_demo/screens/mainMenu.dart';
import 'package:at_tylers_demo/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@Protocol Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),
        MainMenu.id: (context) => MainMenu(),
        ChatsScreen.id: (context) => ChatsScreen(),
        ChatWithAtsign.id: (context) => ChatWithAtsign(),
      },
    );
  }
}
