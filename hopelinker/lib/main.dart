import 'package:flutter/material.dart';
import 'package:hopelinker/signup.dart';
import 'package:hopelinker/survey.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hopelinker/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: StartupSplashScreen(),
    );
  }
}

class StartupSplashScreen extends StatefulWidget{
  const StartupSplashScreen({super.key});

  @override
  State<StartupSplashScreen> createState() => _StartupSplashScreenState();
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  bool _validateFields() {
    if (_userController.text.isEmpty) {
      _showWarning('Please enter your username or email.');
      return false;
    }
    if (_passController.text.isEmpty) {
      _showWarning('Please enter your password.');
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fieldWidth = screenWidth * 0.8;
    final circleDiameter = screenHeight * 1.2; // Make the circle larger

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient circle
          Positioned(
            left: (screenWidth - circleDiameter) / 2,
            top: -circleDiameter * 0.35, // Move it up so it covers the top and still appears lower
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1897B9),
                    Color(0xFF293C72),
                  ],
                ),
              ),
            ),
          ),
          
          // Logo in top left with light gray-blue background
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5F5F5).withValues(alpha: 0.3), // Bright grey, semi-transparent
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/logomini.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Center all children horizontally
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                    
                    // Username/Email label and field
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Username or Email",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: fieldWidth,
                      child: TextField(
                        controller: _userController,
                        decoration: InputDecoration(
                          hintText: 'Enter Username/Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Password label and field
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: fieldWidth,
                      child: TextField(
                        controller: _passController,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        obscureText: true,
                      ),
                    ),
                    
                    // Forgot Password Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: Color(0xFFA1D8DA),
                                fontSize: 17,
                                ), 
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 17, color: Color(0xFFA1D8DA)),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: fieldWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_validateFields()) {
                            await AuthService().signin(
                              email: _userController.text,
                              password: _passController.text,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SurveyScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD0EFB1),
                          foregroundColor: const Color.fromARGB(255, 49, 47, 47),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                    ),
                    
                    // Push the New User section to the bottom
                    const Spacer(),
                    
                    // New User section
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "New User?",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: fieldWidth * 0.8, // Make the button shorter
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24), // More rounded corners
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                "Create an Account",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartupSplashScreenState extends State<StartupSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Set up animations
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    
    // Animation for background transition (from gradient to white)
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
      ),
    );
    
    // Animation for fading in the logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.5, curve: Curves.easeIn),
      ),
    );
    
    // Start the animation
    _controller.forward();
    
    // Navigate to auth screen after animation completes
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {  // Use mounted instead of context.mounted
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(const Color(0xFF1897B9), Colors.white, _backgroundAnimation.value)!,
                  Color.lerp(const Color(0xFF293C72), Colors.white, _backgroundAnimation.value)!,
                ],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/logo.png'),
                    height: 268,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
