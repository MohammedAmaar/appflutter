
import 'package:appflutter/service_image/AssestsManager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserRepository/Repository.dart';

class _AccountState extends State<Account> {
  // Add these variables to store the user's input
  final UserRepository _userRepository = UserRepository();
  final _fullname = TextEditingController();
  final _address = TextEditingController();
  final _phoneNumber = TextEditingController();
  DateTime _birthday = DateTime.now();
  String id ='';
  String _username = "";
  String email ='';
  @override
  void initState(){
    super.initState();
    _loadUsername();

  }
void Open(){}
  Future<void> _loadUsername() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id") ?? '';
      _username = prefs.getString("username") ?? '';
      email = prefs.getString("Email") ?? '';
    });
  }
  File? _image;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  // Add a key to the form to manage the form state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: <Widget>[
            Center(
              widthFactor: 100,
              child: GestureDetector(
              onTap: _selectImage,
              child:   CircleAvatar(
                radius: 60,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage("assets/images/user_icon.png") as ImageProvider,

              )

              ),
            ),
              Stack(
                children:[Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 45,
                      height: 45,
                      padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                border:
                Border.all(width: 2,color: Colors.white),
                borderRadius: BorderRadius.circular(35),

              ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              onPressed:(){
                _selectImage();
              } ,
            ),
          ),
        ),
                  ),
      ),

    ] ),
              const SizedBox(height: 20),
              Center(
                child: Text(_username,style: const TextStyle(
                  fontSize:25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,

                ),),
              ),
              const SizedBox(height: 20),

              // Add a text field for the username
              TextFormField(
                controller: _fullname,

                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 20),

              // Add a text field for the email
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }

                  return null;
                },

              ),
              const SizedBox(height: 20),

              // Add a text field for the phone number
              TextFormField(
                controller: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 20),

              // Add a date picker for the birthday
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _birthday,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _birthday = picked;
                    });
                  }
                },
                child: const Text('Select Birthday'),
              ),
              const SizedBox(height: 20),

              // Add a button to save the data
              ElevatedButton(
                onPressed: (){if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _userRepository.saveUserData(id, _fullname.text,_username, email, _address.text, _phoneNumber.text,_birthday.toString(),_image);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>NextForm())
      );
      print('Data saved: $id,$_fullname,$email, $_address, $_phoneNumber, $_birthday');
    }
  },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define the next form (e.g., NextForm)

class Account extends StatefulWidget {


  @override
  State<Account> createState() => _AccountState();
}
// help


class NextForm extends StatefulWidget {
  @override
  _NextFormState createState() => _NextFormState();
}

class _NextFormState extends State<NextForm> {
  File? _frontCardImage;
  File? _backCardImage;
  String _idNumber = '';
  File? _personImage;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Form"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // Add a field to upload the front card image
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
                setState(() {
                  if (pickedFile != null) {
                    _frontCardImage = File(pickedFile.path);
                  } else {
                    _frontCardImage = null;
                  }
                });
              },
              child: const Text('Upload Front Card Image'),
            ),
            const SizedBox(height: 20),

            // Add a field to upload the back card image
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
                setState(() {
                  if (pickedFile != null) {
                    _backCardImage = File(pickedFile.path);
                  } else {
                    _backCardImage = null;
                  }
                });
              },
              child: const Text('Upload Back Card Image'),
            ),
            const SizedBox(height: 20),

            // Add a field to upload the person image
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
                setState(() {
                  if (pickedFile != null) {
                    _personImage = File(pickedFile.path);
                  } else {
                    _personImage = null;
                  }
                });
              },
              child: const Text('Upload Person Image'),
            ),
            const SizedBox(height: 20),

            // Add a text field for the ID number
            TextFormField(
              decoration: const InputDecoration(labelText: 'ID Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your ID number';
                }
                return null;
              },
              onSaved: (value) => _idNumber = value!,
            ),
            const SizedBox(height: 20),

            // Add a button to submit the form
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  print('Form submitted: $_frontCardImage, $_backCardImage, $_personImage, $_idNumber');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
class Help extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
      ),
      body: const Center(
        child:  Text("Help"),
      ),
    );
  }
}


class Settings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Settings"),
      ),
      body: const Center(
        child:  Text("Settings"),
      ),
    );
  }
}