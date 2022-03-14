// TODO: Remove ignore
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_example/model/user.dart';
import 'package:form_example/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final List<String> _countries = [
    'Russia',
    'Sri Lanka',
    'Italy',
    'New Zealand'
  ];
  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    // Очищаем контроллер после удаления виджета
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    // Очищаем фокусноды
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Метод передачи фокуса после подтверждения ввода
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  child: Icon(Icons.clear, color: Colors.redAccent),
                  onTap: () {
                    _nameController.clear();
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              //validator: (val) => val!.isEmpty ? 'Name is required' : null,
              //validator: (val) => _validateName(val!),
              validator: _validateName,
              onSaved: (value) => newUser.name = value ?? '',
            ), // Name
            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passwordFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'How can we reach you?',
                helperText: 'Phone format +### ### ###-##-##',
                prefixIcon: Icon(Icons.phone),
                suffixIcon: GestureDetector(
                  child: Icon(Icons.clear, color: Colors.redAccent),
                  onTap: () {
                    _phoneController.clear();
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[\d\-\+ ]{1,}$'),
                    allow: true),
              ],
              onSaved: (value) => newUser.phone = value ?? '',
              validator: (value) => _validatePhone(value!)
                  ? null
                  : 'Phone number must be entered as +### ### ###-##-##',
            ), // Phone
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Adress',
                hintText: 'Enter your email',
                icon: Icon(Icons.mail),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => newUser.email = value ?? '',
              //validator: _validateEmail,
            ), // Email
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Country',
                helperText: 'Choose your country',
                icon: Icon(Icons.map),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              items: _countries
                  .map((country) => DropdownMenuItem(
                        child: Text(country),
                        value: country,
                      ))
                  .toList(),
              onChanged: (selectedCountry) {
                print(selectedCountry);
                if (selectedCountry != null) {
                  setState(() {
                    _selectedCountry = selectedCountry as String;
                    newUser.country = _selectedCountry ?? '';
                  });
                }
              },
              value: _selectedCountry,
              // validator: (value) {
              //   return value == null ? 'Please select a country' : null;
              // },
            ), // Country
            SizedBox(height: 10),
            TextFormField(
              controller: _storyController,
              maxLines: 3,
              maxLength: 140,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short, this is just a demo',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              onSaved: (value) => newUser.story = value ?? '',
            ), // Story
            SizedBox(height: 10),
            TextFormField(
              focusNode: _passwordFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                labelText: 'Password *',
                hintText: 'Enter the password',
                helperText: '8 or more characters',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              validator: _validatePassword,
            ), // Password
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.border_color),
                labelText: 'Confirm Password *',
                hintText: 'Confirm the password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              validator: _validatePassword,
            ), // Confirm Password
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: _submitForm,
              child: Text('Sudmit Form'),
            ),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(_nameController.text);
      print('Form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Story: ${_storyController.text}');
      print('Country: ${_selectedCountry}');
    } else {
      print('Form is invalid');
      _showMessage(message: 'Form if not valid! Please review and correct');
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.yellow,
          onPressed: () {},
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showDialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            'Registration successful',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            '$name is now a verified register form',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                debugPrint('Button pressed');
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  ),
                );
              },
              child: Text('Verified'),
            )
          ],
        );
      },
    );
  }

  String? _validateName(String? input) {
    final _nameExp = RegExp(r'[A-Za-z ]+$');

    if (input == null) {
      throw Exception('Name is null');
    } else {
      if (input.isEmpty) {
        return 'Name is required';
      } else if (!_nameExp.hasMatch(input)) {
        return 'Please enter alphabetical characters';
      } else {
        return null;
      }
    }
  }

  bool _validatePhone(String input) {
    final _phoneExp = RegExp(r'^\+\d{1,3} \d{3} \d{3}-\d{2}-\d{2}$');
    return _phoneExp.hasMatch(input);
  }

  String? _validateEmail(String? input) {
    final _emailExp = RegExp(r'^.+@.+\..+$$');

    if (input == null) {
      throw Exception('Email is null');
    }

    if (input.isEmpty) {
      return 'Email is required';
    } else if (!_emailExp.hasMatch(input)) {
      // !input.contains('@')
      return 'Please enter valid email';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? input) {
    if (input == null) {
      throw Exception('Password is null');
    }

    if (input.length < 8) {
      return 'Password should be 8 or more characters';
    } else if (_passController.text != _confirmPassController.text) {
      return 'Passwords must be equal';
    } else {
      return null;
    }
  }
}
