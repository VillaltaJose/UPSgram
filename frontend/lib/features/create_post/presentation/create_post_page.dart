import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postear"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Ventana de Crear Post',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
