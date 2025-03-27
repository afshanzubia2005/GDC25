import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override State<SurveyScreen> createState() => _SurveyScreenState();
}

  class _SurveyScreenState extends State<SurveyScreen> {
    int _currentStep = 0;
    final List<String> _answers = List.filled(5, '');


// List of questions
/*
1. what is your age? [num] or maybe age range?
2. 
*/
    final List<Map<String, dynamic>> _questions = [
      // {
      //   'question': '',
      //   'options': [''],
      // }
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Survey'),
        ),
        body: SafeArea(child: Stepper(currentStep: _currentStep, 
        onStepContinue: () {
          if (_currentStep < _questions.length - 1) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: List.generate(_questions.length, (index) => Step(
          title: Text('Question ${index + 1}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_questions[index]['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(_questions[index]['options'].length,
            (optionIndex) => RadioListTile<String>(
              title: Text(_questions[index]['options'][optionIndex]),
              value: _questions[index]['options'][optionIndex],
              groupValue: _answers[index],
              onChanged: (value) {
                setState(() {
                  _answers[index] = value!;
                });
              },
            ),
          ),
        ],
      ),
      isActive: _currentStep >= index,
    ),
  ),
  controlsBuilder: (context, details) {
    return Row(
      children: [
        ElevatedButton(onPressed: details.onStepContinue, 
        child: Text(_currentStep < _questions.length - 1 ? 'Next' : 'Complete'),
        ),
        if (_currentStep > 0 ) ...[
          const SizedBox(width: 0),
          TextButton(onPressed: details.onStepCancel, 
          child: const Text('Back'),
        ),
      ],
    ],
    );
  },
        ),
      ),
      );
    }
  }