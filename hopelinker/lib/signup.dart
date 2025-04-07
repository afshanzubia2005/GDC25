import 'package:flutter/material.dart';
import 'package:hopelinker/survey.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final fieldW = screenW * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text('Join HopeLinker',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: fieldW,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: fieldW,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: fieldW,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: fieldW,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: fieldW,
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => SurveyScreen()),
                    );
                  }, child: const Text("Create Account",
                  style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}