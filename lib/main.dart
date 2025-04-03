// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weatherapp/navigation_screen.dart';
// import 'package:weatherapp/providers/auth_provider.dart';
// import 'package:weatherapp/screens/login_screen.dart';

// main(){
//   runApp(ChangeNotifierProvider(
//       create: (_) => AuthProvider(),
//       child: MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Weather App',
//       theme: ThemeData(primarySwatch: Colors.blue,),
//       home: LoginScreen(),
//       // home: NavigationScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/navigation_screen.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/screens/login_screen.dart';
import 'package:weatherapp/utils/storage_services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    return await StorageService().isLoggedIn(); // Await login status
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ); // Show loading spinner while checking login
          }

          if (snapshot.hasData && snapshot.data == true) {
            return  NavigationScreen(); // If logged in, go to dashboard
          } else {
            return const LoginScreen(); // Otherwise, show login screen
          }
        },
      ),
    );
  }
}
