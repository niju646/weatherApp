import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/screens/weather_dashboard.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();


    return  Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign Up"),

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
              Text("Create Account",style: TextStyle(
                fontSize: 55,fontFamily: 'DancingScript',
              ),),
              const SizedBox(height: 40,),
              TextField(
                controller: _emailController,
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
              ElevatedButton(onPressed: () async {
                try {
                  await Provider.of<AuthProvider>(context, listen: false)
                          .signup(_emailController.text, _passwordController.text);
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(
                          builder: (_) => WeatherDashboard()));
                }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }, child: Text("Sign Up")),
            ],
          ),),
        ),
      ),
    );
  }
}