import 'package:appflutter/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/firebase_auth/firebase_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../main.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseServise _auth = FirebaseServise();

  final _formKey = GlobalKey<FormState>();
  String id = "";
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register', style: TextStyle(fontSize: 30),),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    const Center(
    child: Text(
    'UV',
    style: TextStyle(
    fontSize: 40,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(height: 30),

    TextFormField(
    controller: _usernameController,
    decoration: InputDecoration(
    hintText: 'Username',
    prefixIcon: const Icon(Icons.person),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your username!';
    }else if ( value.trim() ==" ") {
      return 'Please enter your username a occure!';
    }else if ( value.contains(' ') ) {
      return 'Username can not contains space!';
    }else if ( value.contains('-') ) {
      return 'Username can not contains "-"!';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),

    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
    hintText: 'E-mail',
    prefixIcon: const Icon(Icons.email),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your email';
    }
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (!RegExp(pattern).hasMatch(value)) {
    return 'Please enter a valid email address(example@gmail.com)';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _passwordController,
    obscureText: _obscureText,
    decoration: InputDecoration(
    hintText: 'Password',
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: IconButton(
    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
    onPressed: () {
    setState(() {
    _obscureText = !_obscureText;
    });
    },
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your password';
    }
    if (value.length < 8) {
    return 'Please must be at least 8 characters';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _confirmPasswordController,
    obscureText: _obscureConfirmText,
    decoration: InputDecoration(
    hintText: 'Confirm Password',
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: IconButton(
    icon: Icon(_obscureConfirmText ? Icons.visibility_off : Icons.visibility),
    onPressed: () {
    setState(() {
    _obscureConfirmText = !_obscureConfirmText;
    });
    },
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your confirm password';
    }
    if (value != _passwordController.text) {
    return 'Passwords do not match';
    }
    return null;
    },
    ),
    const SizedBox(height: 30),
    ElevatedButton(
    onPressed:signUp,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Register'),
    ),
      const SizedBox(height: 30),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: const Text(
          'Already have an account? Login here',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 20),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.facebook,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.whatshot,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.telegram,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ],
    ),
    ),
        ),
        ),
    );
  }
  void signUp() async{
    String username = _usernameController.text;
    String email = _emailController.text;
    String pass = _passwordController.text;
    if( username.isEmpty || email.isEmpty || pass.isEmpty || _confirmPasswordController.text.isEmpty){
      if(_formKey.currentState!.validate()){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('empty field!'),
            backgroundColor: Colors.red,
          ),
        );
      }

    }
    else if (_formKey.currentState!.validate()) {
        User? user = await _auth.signUpEmailAndPass(context,email, pass);
        if (user != null){
          print("ok ok ok");

            id = user.uid;
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('id', id);
          });

            SharedPreferences.getInstance().then((prefs) {
              prefs.setString('username', username);
            });
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('Email', email);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('no internet!'),
            backgroundColor: Colors.red,
          ),
        );
      }

  }
}