import 'package:appflutter/firebase_auth/firebase_auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:appflutter/firebase_auth/register_page.dart';

import 'main.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseServise _auth = FirebaseServise();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: TextStyle(
            fontSize: 30,
        ),),
        centerTitle:true ,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  <Widget>[

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
                    prefixIcon: Icon(Icons.lock),
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
                    if (value.length < 8){
                      return 'Please must be at least 8 characters';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Register here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
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
  void signIn() async{
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      if (_formKey.currentState!.validate()) {


          //User? user = await _auth.signInEmailAndPass(email, password);
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);


           Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

    }



    }catch(e) {


      if (e is FirebaseAuthException) {
        print(e.code);
          if (e.code =="network-request-failed"){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('no internet'),
                backgroundColor: Colors.red,
              ),
            );
          }else if (e.code =="too-many-requests"){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Try again later, due to high volume of requests!'),
                backgroundColor: Colors.red,
              ),
            );
          }else if(e.code =="invalid-credential"){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('email or password is valid!'),
                backgroundColor: Colors.red,
              ),
            );
          }else if(e.code =="invalid-email"){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('email  is valid!'),
                backgroundColor: Colors.red,
              ),
            );
          }
      }else{
        print(e);
      }
    }
  }
 }