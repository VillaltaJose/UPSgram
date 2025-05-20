import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PublishPage extends StatefulWidget {
  final File image;
  final String filter;

  const PublishPage({super.key, required this.image, required this.filter});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPublishing = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onPublish() async {
    setState(() => _isPublishing = true);

    // Firebase y API
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isPublishing = false);

    if (!mounted) return;
    GoRouter.of(context).go('/feed');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Publicación compartida")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva publicación"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.file(widget.image),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Escribe una descripción...',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16),
          _isPublishing
              ? const CircularProgressIndicator()
              : ElevatedButton.icon(
                  onPressed: _onPublish,
                  icon: const Icon(Icons.send),
                  label: const Text('Compartir'),
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
