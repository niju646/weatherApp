import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/navigation_screen.dart';
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
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/login.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3),
           BlendMode.dstATop,
           ),
          )
        ),
        child: Center(
          child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(
                fontSize: 60,fontFamily: 'DancingScript',
              ),),
              const SizedBox(height: 40,),
              TextField(
                controller: _emailController ,
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
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
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
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
                      //  MaterialPageRoute(builder: (_) => WeatherDashboard()));
                       MaterialPageRoute(builder: (_) => NavigationScreen()));
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
        ),
      ),
    );
  }
}