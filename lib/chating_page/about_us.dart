import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blue, // Brand color
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Welcome to UV!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Image.asset('assets/uv_team.jpg'), // High-quality image
              SizedBox(height: 20),
              Text(
                'We are a team of passionate developers, designers, and innovators dedicated to creating amazing experiences.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue), // Visual interest
                  SizedBox(width: 10),
                  Text(
                    'Our headquarters are located in [City, Country].',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Some interesting facts about us:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '1.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'We have a team of 10+ experienced developers.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '2.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'We have completed 50+ successful projects.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '3.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'We have a 95% client satisfaction rate.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}