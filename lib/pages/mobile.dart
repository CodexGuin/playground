import 'package:flutter/material.dart';

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Mobile'),
        centerTitle: true,
      ),
      drawer: const Drawer(
          child: Column(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.home,
            size: 50,
          )),
          ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text('Mobile'),
            leading: Icon(Icons.mobile_friendly),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text('Tablet'),
            leading: Icon(Icons.tablet_mac),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text('Laptop'),
            leading: Icon(Icons.laptop),
          )
        ],
      )),
      body: const Center(
        child: Text(
          'Mobile',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
