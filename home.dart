import 'dart:convert';

import 'package:fake_news_detection/ModelResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class HomePage extends StatefulWidget {
  // final User user; // Add this line

  // HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputController = TextEditingController();
  String? auth = '';
  String? senti = '';

  Future<void> makeAPICall() async {
    setState(() {
      auth = "";
      senti = "";
    });
    final url = Uri.parse('${ApiConfig.baseUrl}/model');
    final response = await http.post(
      url,
      body: {
        'text': inputController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successfully made the API call, handle the response as needed
      print("API Response: ${response.body}");
      // Update the output text with the API response
      final jsonResponse = json.decode(response.body);
      final result = ModelResult.fromJson(jsonResponse);
      setState(() {
        auth = result.auth;
        senti = result.sentiment;
      });
    } else {
      // Handle API call failure, e.g., display an error message
      print("API call failed with status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fake News and Sentiment Detector"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assests/images.jpeg'),
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
                      "Welcome to the App!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    TextFormField(
                      controller: inputController,
                      decoration: const InputDecoration(
                        labelText: 'Input 1',
                        icon: Icon(Icons.input),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        makeAPICall();
                      },
                      child: const Text("Submit"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        auth ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        senti ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
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
