import 'package:fake_news_detection/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> makeAPICall() async {
    final url = Uri.parse(
        '${ApiConfig.baseUrl}/user/register'); // Replace with your Node.js server endpoint
    final response = await http.post(
      url,
      body: {
        'name': fullNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successfully registered, handle the response as needed
      print("API Response: ${response.body}");
      // Navigate to the home page or perform other actions
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Handle registration failure, e.g., display an error message
      print("Registration failed with status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        makeAPICall();
                      },
                      child: Text("Register"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the login page
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text("Already have an account? Login"),
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
