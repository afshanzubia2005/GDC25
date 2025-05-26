import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Profile')), // top nav bar?
      body: Column(
        //alignment: Alignment.center, // what does this do?
        children: <Widget>[
          Positioned(
            child: Column(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: Image.asset('assets/blue_ellipse.png'),
                ),
                Center(
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Text("Volunteer"),
                //Padding(
                // padding: const EdgeInserts.fromLTRB
                //
                //)
              ],
              // color: Colors.white,
            ),
          ),
        ],
      ), // Center(child: Text('here is all your profile info from survey ')
      // Bottom Nav Bar?
    );
  }
}
