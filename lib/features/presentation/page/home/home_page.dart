import 'package:flutter/material.dart';
import 'package:startup_saathi/features/presentation/page/home/widget/user_card.dart';

class HomePage extends StatelessWidget {
  final String? uid;
  const HomePage({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          UserCard(url: 'assets/pic.jpeg'),
          UserCard(url: 'assets/pic2.jpeg'),
        ],
      ),
    );
  }
}
