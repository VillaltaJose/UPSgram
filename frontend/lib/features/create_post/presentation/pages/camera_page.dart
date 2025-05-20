import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> _cameras;
  CameraController? _cameraController;
  bool _isRearCameraSelected = false;
  bool _isCameraInitialized = false;
  bool _isSwitchingCamera = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _isRearCameraSelected = false;
    _startCamera(frontCamera);
  }

  void _startCamera(CameraDescription cameraDescription) async {
    try {
      _cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint('Error al iniciar la cámara: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (_isSwitchingCamera || _cameras.isEmpty) return;

    setState(() {
      _isSwitchingCamera = true;
      _isCameraInitialized = false;
    });

    try {
      final newLensDirection =
          _isRearCameraSelected
              ? CameraLensDirection.front
              : CameraLensDirection.back;

      final newCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == newLensDirection,
      );

      await _cameraController?.dispose();

      _cameraController = CameraController(
        newCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isRearCameraSelected = !_isRearCameraSelected;
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error al cambiar de cámara: $e');
    } finally {
      if (mounted) {
        setState(() => _isSwitchingCamera = false);
      }
    }
  }

  void _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      Navigator.pushNamed(
        context,
        '/post/confirm',
        arguments: File(image.path),
      );
    }
  }

  void _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    try {
      final file = await _cameraController!.takePicture();
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/post/confirm',
          arguments: File(file.path),
        );
      }
    } catch (e) {
      debugPrint('Error al capturar la foto: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _isCameraInitialized
              ? Center(
                child: Builder(
                  builder: (context) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final containerHeight = screenHeight * 0.8;
                    final containerWidth = containerHeight * 9 / 16;

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        child: OverflowBox(
                          maxWidth:
                              containerHeight *
                              _cameraController!.value.aspectRatio,
                          maxHeight: containerHeight,
                          child:
                              _isRearCameraSelected
                                  ? CameraPreview(_cameraController!)
                                  : Transform(
                                    alignment: Alignment.center,
                                    transform:
                                        Matrix4.identity()
                                          ..scale(-1.0, 1.0, 1.0),
                                    child: CameraPreview(_cameraController!),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : const Center(child: CircularProgressIndicator()),

          Positioned(
            top: 78,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo, color: Colors.white, size: 30),
                  onPressed: _openGallery,
                ),
                GestureDetector(
                  onTap: _capturePhoto,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_android,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _switchCamera,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
