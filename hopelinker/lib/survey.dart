import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:hopelinker/home.dart';
import 'package:hopelinker/survey_loading.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

final List<String> _usStates = [
  'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'
];

String? _selectedCity;
String? _selectedState;
String? _selectedZip;

class _SurveyScreenState extends State<SurveyScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Are you volunteering?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Display Name',
      'options': [], // should it be legal or user has an option to display custom name?
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
      'question': 'Address',
      'options': [], // check online and autocorrect?
      'isText': true,
    },    {
      'question': 'Country of birth',
      'options': ['U.S.', 'Other (Outside of U.S)'],
    },
    {
      'question': 'Select Country',
      'options': ['Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo', 'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Korea, North', 'Korea, South', 'Kosovo', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Macedonia', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestine', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe'],
      'skipIf': {'question': 'Country of birth', 'answer': 'U.S.'},
    },
    {
      'question': 'City, State, Zip Code',
      'options': [],
      'isText': 'cityStateZip',
      'skipIf': {'question': 'Country of birth', 'answer': 'Other (Outside of U.S)'},
    },
    {
      'question': 'Household income',
      'options': [
        'Less than or equal to \$30,000',
        '\$30,001 - \$58,020',
        '\$58,021 - \$94,000',
        '\$94,001 - \$153,000',
        'Greater than \$153,000'
      ],
    },
    {
      'question': 'Are you receiving assistance?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Phone number',
      'options': [], // ensure number is valid or convert to valid number
      'isText': true,
    },
    {
      'question': 'Email address',
      'options': [], // make sure it is email
      'isText': true,
    },
    {
      'question': 'Marital status',
      'options': ['Single', 'Married', 'Divorced', 'Widowed'],
    },
    {
      'question': 'If married, how many children between you and your spouse?',
      'options': [],
      'isText': true,
    },
    {
      'question': 'If married, what is status of spouse?',
      'options': [],
      'isText': true,
    },
    {
      'question': 'Status',
      'options': [
        'U.S. Citizen',
        'Naturalized Citizen',
        'U.S Resident',
        'Visa Holder'
      ],
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
        'Certificate',
        'Associates',
        'Bachelors',
        'Graduates'
      ],
    },
  ];
  int _currentStep = 0;
  late final List<String> _answers;
  late final List<TextEditingController> _controllers;
  late final List<GlobalKey<FormState>> _formKeys; 

  @override
  void initState() {
    super.initState();
    _answers = List.filled(_questions.length, '');
    _controllers = List.generate(_questions.length, (index) => TextEditingController());
    _formKeys = List.generate(_questions.length, (index) => GlobalKey<FormState>());
  }

    @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }    super.dispose();
  }

  // Email validation function
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Phone validation function
  bool _isValidPhone(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    return cleaned.length == 10;
  }

  // Get input formatter based on question type
  List<TextInputFormatter> _getInputFormatters(String question) {
    if (question.toLowerCase().contains('age') || question.toLowerCase().contains('children') || question.toLowerCase().contains('dependents')) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    if (question.toLowerCase().contains('phone')) {
      return [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)];
    }
    return [];
  }

  // Get keyboard type based on question
  TextInputType _getKeyboardType(String question) {
    if (question.toLowerCase().contains('email')) {
      return TextInputType.emailAddress;
    }
    if (question.toLowerCase().contains('phone')) {
      return TextInputType.phone;
    }
    if (question.toLowerCase().contains('age') || question.toLowerCase().contains('children') || question.toLowerCase().contains('dependents')) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  // Validation function
  String? _validateInput(String? value, String question) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (question.toLowerCase().contains('email')) {
      if (!_isValidEmail(value)) {
        return 'Please enter a valid email address';
      }
    }

    if (question.toLowerCase().contains('phone')) {
      if (!_isValidPhone(value)) {
        return 'Please enter a valid 10-digit phone number';
      }
    }    if (question.toLowerCase().contains('age')) {
      int? age = int.tryParse(value);
      if (age == null || age < 13 || age > 110) {
        return 'Please enter a valid age (13-110)';
      }
    }

    if (question.toLowerCase().contains('children') || question.toLowerCase().contains('dependents')) {
      int? number = int.tryParse(value);
      if (number == null || number < 0) {
        return 'Please enter a valid number (0 or greater)';
      }
    }

    return null;
  }

  // Helper function for hint text
  String _getHintText(String question) {
    if (question.toLowerCase().contains('email')) {
      return 'example@email.com';
    }
    if (question.toLowerCase().contains('phone')) {
      return '1234567890';
    }
    if (question.toLowerCase().contains('age')) {
      return 'Enter your age';
    }
    if (question.toLowerCase().contains('display name')) {
      return 'Enter display name';
    }
    if (question.toLowerCase().contains('address')) {
      return 'Enter your address';
    }
    return 'Enter your answer';  }

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
                  // Options as buttons or text field or city/state/zip
                  if (currentQ['isText'] == 'cityStateZip')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: [
                          // City TextField
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(                              labelText: 'City',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _selectedCity = val;
                                  _answers[_currentStep] = '${_selectedCity ?? ''},${_selectedState ?? ''},${_selectedZip ?? ''}';
                                });
                              },
                            ),
                          ),
                        const SizedBox(width: 8),
                        // State Dropdown
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedState,
                            decoration: const InputDecoration(                              labelText: 'State',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            items: _usStates.map((state) {
                              return DropdownMenuItem(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedState = val;
                                _answers[_currentStep] = '${_selectedCity ?? ''},${_selectedState ?? ''},${_selectedZip ?? ''}';
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Zip TextField
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(                              labelText: 'Zip',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() {
                                _selectedZip = val;
                                _answers[_currentStep] = '${_selectedCity ?? ''},${_selectedState ?? ''},${_selectedZip ?? ''}';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  else if (isText == true)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Form(
                        key: _formKeys[_currentStep],
                        child: TextFormField(
                          controller: _controllers[_currentStep],
                          keyboardType: _getKeyboardType(currentQ['question']),
                          inputFormatters: _getInputFormatters(currentQ['question']),
                          validator: (value) => _validateInput(value, currentQ['question']),
                          onChanged: (value) {
                            setState(() {
                              _answers[_currentStep] = value;
                            });
                          },
                          style: const TextStyle(fontSize: 20, color: Colors.black),                          decoration: InputDecoration(
                            hintText: _getHintText(currentQ['question']),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  else if (currentQ['question'] == 'Select Country')
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),                        itemCount: currentQ['options'].length,
                        itemBuilder: (context, index) {
                          final isSelected = _answers[_currentStep] == currentQ['options'][index];                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF37A5FF) : null,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ] : null,
                            ),
                            child: ListTile(
                              title: Text(
                                currentQ['options'][index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              selected: isSelected,
                              onTap: () {
                                setState(() {
                                  _answers[_currentStep] = currentQ['options'][index];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    )
                  else if (currentQ['options'].isNotEmpty)
                    Wrap(                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        currentQ['options'].length,                        (index) => ChoiceChip(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          label: Text(
                            currentQ['options'][index],
                            style: TextStyle(
                              fontSize: 18,
                              color: _answers[_currentStep] == currentQ['options'][index] 
                                  ? Colors.white 
                                  : Colors.black87,
                            ),
                          ),                          selected: _answers[_currentStep] == currentQ['options'][index],
                          selectedColor: const Color(0xFF37A5FF),
                          checkmarkColor: Colors.white,
                          backgroundColor: Colors.white,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _answers[_currentStep] = currentQ['options'][index];
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                      if (_currentStep > 0)
                        TextButton(
                          onPressed: () {
                            // Find the appropriate previous question when going back
                            int prevStep = _currentStep - 1;
                            
                            // Special handling for going back from country selection
                            if (currentQ['question'] == 'Select Country') {
                              // Find the Country of birth question
                              int countryBirthIndex = _questions.indexWhere((q) => q['question'] == 'Country of birth');
                              if (countryBirthIndex >= 0) {
                                prevStep = countryBirthIndex;
                              }
                            }
                            
                            // Special handling for going back from City,State,Zip
                            if (currentQ['question'] == 'City, State, Zip Code') {
                              // Find the Country of birth question
                              int countryBirthIndex = _questions.indexWhere((q) => q['question'] == 'Country of birth');
                              if (countryBirthIndex >= 0) {
                                prevStep = countryBirthIndex;
                              }
                            }
                            
                            setState(() {
                              _currentStep = prevStep;
                            });
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          bool canProceed = false;
                          
                          if (isText) {
                            // Validate text input
                            if (_formKeys[_currentStep].currentState?.validate() ?? false) {
                              canProceed = true;
                            }
                          } else {
                            // Check if option is selected
                            canProceed = _answers[_currentStep].isNotEmpty;
                          }                          if (canProceed) {
                            if (_currentStep < _questions.length - 1) {
                              // Find next non-skipped question
                              int nextStep = _currentStep + 1;
                              while (nextStep < _questions.length) {
                                final nextQ = _questions[nextStep];
                                if (nextQ.containsKey('skipIf')) {
                                  final skip = nextQ['skipIf'];
                                  // Find the referenced question for the skipIf condition
                                  int prevIndex = -1;
                                  for (int i = 0; i < _questions.length; i++) {
                                    if (_questions[i]['question'] == skip['question']) {
                                      prevIndex = i;
                                      break;
                                    }
                                  }
                                  
                                  // If question found and answer matches skip condition, skip this question
                                  if (prevIndex >= 0 && _answers[prevIndex] == skip['answer']) {
                                    nextStep++;
                                    continue;
                                  }
                                }
                                break;
                              }
                              setState(() {
                                _currentStep = nextStep;
                              });
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SurveyLoadingScreen()),
                              );
                            }
                          }
                        },
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
                        MaterialPageRoute(builder: (context) => HomeMenu()), // Changed from MapPage to HomeMenu
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