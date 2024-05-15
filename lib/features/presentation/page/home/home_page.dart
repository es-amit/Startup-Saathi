import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? uid;
  const HomePage({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uid!),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
