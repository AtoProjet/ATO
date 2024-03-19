import 'package:ato/verification_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:ato/customs/components.dart';
import 'package:ato/customs/styles.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/user.dart';
import 'package:ato/tools/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final String accountType;

  const RegisterScreen({required this.accountType, super.key});

  @override
  createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _error;
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: "ato.966000@gmail.com");
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<String> years =
      List.generate(100, (index) => (DateTime.now().year - index).toString());
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> areas = [
    "Eastern Province",
    "Makkah Al-Mukarramah",
    "Al-Madinah",
    "Al-Munawwarah" "Al-Jouf",
    "Tabuk",
    "Hail" "Riyadh",
    "Al-Qassim",
    "Najran",
    "Jazan",
    "Al-Baha",
    "Northern Borders",
    "Asir"
  ];
  late String year;
  late String month;
  late String area;
  bool _agreeToTerms = false;
  bool _valid = false;
  bool _verificationSent = false;

  addUserToDB(id, accountType) async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String birthDate = "$month, $year";
    try {
      UserModel userModel = UserModel(
          id: id,
          name: name,
          email: email,
          phone: phone,
          birthDate: birthDate,
          area: area,
          role: accountType);
      await Refs.instance().userRef.doc(id).set(userModel);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserToDB(userCredential.user?.uid, widget.accountType);
      _sendVerificationEmail();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  _validateInputs() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    setState(() {
      _nameError = validateUserName(_nameController.text);
      _emailError = validateEmail(_emailController.text);
      _phoneError = validatePhone(_phoneController.text);
      _passwordError = validatePassword(password);
      if(_nameError!= null)
        print(_nameError);
      if(_emailError!= null)
        print(_emailError);
      if(_phoneError!= null)
        print(_phoneError);
      if(_passwordError!= null)
        print(_passwordError);
      if (password != confirmPassword) {
        _confirmPasswordError = "Password and Confirm Password didn't match";
      }
      if(_confirmPasswordError!= null)
        print(_confirmPasswordError);

      _valid = _nameError == null &&
          _emailError == null &&
          _phoneError == null &&
          _passwordError == null &&
          _confirmPasswordError == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    setAsFullScreen();
    return Scaffold(
      appBar: getAppBar(context, ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    errorText: _nameError,
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _emailError,
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    errorText: _phoneError,
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _passwordError,
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: _confirmPasswordError,
                  ),
                ),
              ),
              const SizedBox(height: 16, width: double.infinity),
              const SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Text('Birth Date')),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: months.first,
                      onChanged: (value) {
                        month = value!;
                      },
                      items:
                          months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      width: 24.0,
                    ),
                    DropdownButton<String>(
                      value: years.first,
                      onChanged: (value) {
                        year = value!;
                      },
                      items:
                          years.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Text('Area')),
              SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: areas.first,
                  onChanged: (value) {
                    area = value!;
                  },
                  items:
                  areas.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  const Text('I agree to '),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Terms and Conditions'),
                  ),
                ],
              ),
              const SizedBox(height: 36.0),
              SizedBox(
                height: 48,
                width: 120,
                child: darkMaterialButton(
                  onPressed: () async {
                    _validateInputs();
                    if (_valid && _agreeToTerms) {
                      print("Valid");
                      try {
                        register();
                        if(_verificationSent){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VerificationCodeScreen()),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          _error = e.toString();
                        });
                      }
                    }
                    else{
                      print("Not valid");
                    }
                  },
                  // TODO fix this condition
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendVerificationEmail() {
    User user = _auth.currentUser!;
    user.sendEmailVerification().then((_) {
      setState(() {
        _verificationSent= true;
      });
    }).catchError((error) {
      setState(() {
        _error = 'Failed to send verification email: $error';
      });
    });
  }
}
