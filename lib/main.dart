import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/screens/login_screen.dart';

main(){
  runApp(ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: LoginScreen(),
    );
  }
}