import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsgram/features/create_post/presentation/widgets/filter_selector.dart';

class ConfirmPage extends StatefulWidget {
  final File image;
  final bool isFrontCamera;

  const ConfirmPage({
    super.key,
    required this.image,
    required this.isFrontCamera,
  });

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  FilterType _selectedFilter = FilterType.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar imagen'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: _getColorFilter(_selectedFilter),
                  child: Transform(
                    alignment: Alignment.center,
                    transform:
                        widget.isFrontCamera
                            ? Matrix4.rotationY(math.pi)
                            : Matrix4.identity(),
                    child: Image.file(widget.image),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilterSelector(
            selected: _selectedFilter,
            onSelect: (filter) {
              setState(() => _selectedFilter = filter);
              // Conectar API
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Repetir'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Siguiente'),
                onPressed: () {
                  
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  ColorFilter _getColorFilter(FilterType filter) {
    switch (filter) {
      case FilterType.grayscale:
        return const ColorFilter.matrix(<double>[
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);
      case FilterType.sepia:
        return const ColorFilter.matrix(<double>[
          0.393,
          0.769,
          0.189,
          0,
          0,
          0.349,
          0.686,
          0.168,
          0,
          0,
          0.272,
          0.534,
          0.131,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);
      case FilterType.ups:
        return const ColorFilter.mode(
          Colors.deepPurpleAccent,
          BlendMode.colorBurn,
        );
      case FilterType.none:
      default:
        return const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
    }
  }
}
