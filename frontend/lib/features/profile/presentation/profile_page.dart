import 'package:flutter/material.dart';
import 'package:upsgram/core/widgets/button_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Perfil del usuario.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
