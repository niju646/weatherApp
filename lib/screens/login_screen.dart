import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/screens/signup_screen.dart';
import 'package:weatherapp/screens/weather_dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();



    return  Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _emailController ,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
                
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async {
              try {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .login(_emailController.text, _passwordController.text);
                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (_) => WeatherDashboard()));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),
          TextButton(onPressed: ()=>
          Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
          child: Text("Create an account"))
        ],
      ),
      ),
    );
  }
}