
import 'package:fake_news_detection/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> makeAPICall() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/user/login'); 
    final response = await http.post(
      url,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successfully logged in, handle the response as needed
      print("API Response: ${response.body}");
      
      // Navigate to the home page or perform other actions
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Handle login failure, e.g., display an error message
      print("Login failed with status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
         decoration: const BoxDecoration(
         image: DecorationImage(
         image: AssetImage('assests/loginimage.jpeg'),
         fit: BoxFit.cover,
         ),
         ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        makeAPICall();
                      },
                      child: Text("Login"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the login page
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text("Don't have an account? Register"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
