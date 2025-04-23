import 'package:flutter/material.dart';
import 'package:hopelinker/map_page.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Are you volunteering?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Name',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Age',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Gender',
      'options': ['Male', 'Female', 'Non-binary', 'Other', 'Prefer not to say'],
    },
    {
      'question': 'Address (if valid)',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Country of birth',
      'options': ['U.S.', 'Other'],
    },
    {
      'question': 'City, State, Zip Code',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Household income (if valid)',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Are you receiving assistance?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Phone number',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Email address',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Marital status',
      'options': ['Single', 'Married', 'Divorced', 'Widowed'],
    },
    {
      'question': 'If married, how many children?',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Status',
      'options': [
        'U.S. Citizen',
        'Naturalized Citizen',
        'Greencard Holder',
        'Visa Holder'
      ],
    },
    {
      'question': 'If married, what is status of spouse?',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Number of dependents',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Education level',
      'options': [
        'Some high school',
        'High school diploma',
        'GED',
        'Some college',
        'Bachelors',
        'Associates',
        'Graduates'
      ],
    },
  ];

  int _currentStep = 0;
  late final List<String> _answers;

  @override
  void initState() {
    super.initState();
    _answers = List.filled(_questions.length, '');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final blueCircleDiameter = screenHeight * 1.1;
    final orangeCircleDiameter = screenHeight * 0.9;

    final currentQ = _questions[_currentStep];
    final isText = currentQ['isText'] == true;

    return Scaffold(
      body: Stack(
        children: [
          // Blue gradient circle (top left to left center)
          Positioned(
            left: -blueCircleDiameter * 0.4,
            top: -blueCircleDiameter * 0.25,
            child: Container(
              width: blueCircleDiameter,
              height: blueCircleDiameter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFF1897B9),
                    Color(0xFF293C72),
                  ],
                ),
              ),
            ),
          ),
          // Orange/red gradient circle (bottom left)
          Positioned(
            left: -orangeCircleDiameter * 0.5,
            bottom: -orangeCircleDiameter * 0.3,
            child: Container(
              width: orangeCircleDiameter,
              height: orangeCircleDiameter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFF3C27D),
                    Color(0xFFE8225A),
                  ],
                ),
              ),
            ),
          ),
          // Logo and progress bubbles in top left
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF5F5F5).withOpacity(0.3),
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
                    height: 32,
                    width: 32,
                  ),
                ),
                const SizedBox(width: 8),
                // Small, narrow bubbles
                Row(
                  children: List.generate(_questions.length, (index) {
                    bool answered = _answers[index].isNotEmpty;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: answered
                            ? const Color(0xFFA8FBFE)
                            : const Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          // Main survey content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Question
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      currentQ['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Options as buttons or text field
                  if (isText)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            _answers[_currentStep] = val;
                          });
                        },
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your answer',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                      ),
                    )
                  else
                    ...List.generate(
                      currentQ['options'].length,
                      (optionIndex) {
                        final option = currentQ['options'][optionIndex];
                        final isSelected = _answers[_currentStep] == option;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _answers[_currentStep] = option;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? const Color(0xFF293C72)
                                  : Colors.white,
                              foregroundColor: isSelected
                                  ? Colors.white
                                  : const Color(0xFF293C72),
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: isSelected ? 4 : 1,
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_currentStep > 0)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _currentStep -= 1;
                            });
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _answers[_currentStep].isNotEmpty
                            ? () {
                                if (_currentStep < _questions.length - 1) {
                                  setState(() {
                                    _currentStep += 1;
                                  });
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MapPage()),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0090C1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentStep < _questions.length - 1 ? 'Next' : 'Finish',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Skip Survey
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                    child: const Text(
                      'Skip Survey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}