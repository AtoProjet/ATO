import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/sr_screens/agreement_screen.dart';
import 'package:ato/sr_screens/login_screen.dart';
import 'package:ato/components/actions.dart';
import 'verification_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/user.dart';
import 'package:ato/db/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final String accountType;
  static String title = "Register";
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> years = List.generate(
      100, (index) => (DateTime.now().year - index - 18).toString());
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
    "Hail", "Riyadh",
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
  bool _isLoading = false;
  bool addTest = true;

  @override
  void initState() {
    month= months.first;
    year= years.first;
    area= areas.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (addTest) {
      setState(() {
        _nameController.text = "User 1323";
        _emailController.text = "ato.966000@gmail.com";
        _phoneController.text = "0598765432";
        _confirmPasswordController.text = "123456";
        _passwordController.text = "123456";
      });
    }
    setAsFullScreen(true);
    return atoScaffold(
      context: context,
      showAppBarBackground: true,
      showAppBar: true,
      title: RegisterScreen.title,
      isLoading: _isLoading,
      body: Padding(
        padding:const EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 0.0) ,
        child: ListView(
          padding:const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0) ,
          scrollDirection: Axis.vertical,
          children: [
              Text(_error!=null? _error!: "", style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Full Name',
                  errorText: _nameError,
                  hintText: "Your Full Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError,
                  hintText: "you@email.com"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: '05xxxxxxxx OR +9665xxxxxxxxx',
                errorText: _phoneError,
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordError,
                  hintText: "Text contains 6 letters or more"),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: _confirmPasswordError,
                  hintText: "Same of 'Password' field"),
            ),
            const SizedBox(height: 16, width: double.infinity),
            const SizedBox(
                height: 20, width: double.infinity, child: Text('Birth Date')),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: month,
                    onChanged: (value) {
                      setState(() {
                        month = value!;
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
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
                    value: year,
                    onChanged: (value) {
                      setState(() {
                        year = value!;
                      });
                    },
                    items: years.map<DropdownMenuItem<String>>((String value) {
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
                height: 20, width: double.infinity, child: Text('Area')),
            SizedBox(
              width: double.infinity,
              child: DropdownButton<String>(
                value: area,
                onChanged: (value) {
                  setState(() {
                    area = value!;
                  });
                },
                items: areas.map<DropdownMenuItem<String>>((String value) {
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
                  onPressed: (){
                    goToScreen(context, const AgreementScreen());
                  },
                  child: const Text('Terms and Conditions'),
                ),
              ],
            ),
            const SizedBox(height: 36.0),
            Center(
              child: SizedBox(
                height: 48,
                width: 120,
                child: atoDarkMaterialButton(
                  onPressed: () async {
                    _validateInputs();
                    if (_valid && _agreeToTerms) {
                      try {
                        register();
                      } catch (e) {
                        setState(() {
                          _error = e.toString();
                        });
                      }
                    } else {
                      print("Not valid");
                    }
                  },
                  // TODO fix this condition
                  text: 'Continue',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text('Already have an account?', style: TextStyle(fontSize: 16),),
                TextButton(
                  onPressed: () {
                    goToScreen(context, const LoginScreen());
                  },
                  child: const Text('Login',style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  _validateInputs() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    setState(() {
      _nameError = validateUserName(_nameController.text);
      _emailError = validateEmail(_emailController.text);
      _phoneError = validatePhone(_phoneController.text);
      _passwordError = validatePassword(password);
      _confirmPasswordError = password != confirmPassword
          ? "Password and Confirm Password didn't match"
          : null;
      _error =
          _agreeToTerms ? null : "You must agree with terms and conditions";
      _valid = _nameError == null &&
          _emailError == null &&
          _phoneError == null &&
          _passwordError == null &&
          _confirmPasswordError == null;
    });
  }

  register() async{
    setState(() {
      _isLoading = true;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
     UserCredential userCredential= await Fire.auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,);
        if (userCredential.user != null) {
         await addUserToDB(userCredential.user?.uid, widget.accountType);
        }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }
  addUserToDB(id, accountType) async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String birthDate = "$month, $year";
    try {

      UserModel.user = UserModel(
          id: id,
          name: name,
          email: email,
          phone: phone,
          birthDate: birthDate,
          area: area,
          role: accountType, isActive: true, isDeleted: false);
      await Fire.userRef.doc(id).set(UserModel.user!.toMap());
      _sendVerificationEmail();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }


  void _sendVerificationEmail() async {
    User user = Fire.auth.currentUser!;
    try {
      await user.sendEmailVerification();
      if(context.mounted) {
        goToScreen(context, const VerificationCodeScreen());
      }
    }
    catch(error) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to send verification email: $error';
      });
    }
  }
}
