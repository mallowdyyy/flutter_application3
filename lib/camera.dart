import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  bool _isCameraChanging = false;
  double _zoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;

    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.ultraHigh,
    );

    await _controller.initialize();

    _minAvailableZoom = await _controller.getMinZoomLevel();
    _maxAvailableZoom = await _controller.getMaxZoomLevel();

    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.torch);
    } else {
      await _controller.setFlashMode(FlashMode.off);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.torch);
    } else {
      await _controller.setFlashMode(FlashMode.off);
    }
  }

  Future<void> _toggleCamera() async {
    setState(() {
      _isCameraChanging = true;
    });

    final cameras = await availableCameras();
    final newCamera = _isFrontCamera ? cameras.first : cameras.last;

    await _controller.dispose();

    _controller = CameraController(
      newCamera,
      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.torch);
    } else {
      await _controller.setFlashMode(FlashMode.off);
    }

    _minAvailableZoom = await _controller.getMinZoomLevel();
    _maxAvailableZoom = await _controller.getMaxZoomLevel();

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _isCameraChanging = false;
    });
  }

  Future<void> _zoomIn() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    setState(() {
      _zoomLevel =
          (_zoomLevel + 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
    });
    await _controller.setZoomLevel(_zoomLevel);
  }

  Future<void> _zoomOut() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    setState(() {
      _zoomLevel =
          (_zoomLevel - 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
    });
    await _controller.setZoomLevel(_zoomLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF534F7D),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 00.0),
          child: _isCameraChanging
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CameraPreview(_controller),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Column(
                              children: [
                                FloatingActionButton(
                                  onPressed: _toggleFlash,
                                  backgroundColor: const Color(0xFF534F7D),
                                  child: _isFlashOn
                                      ? const Icon(Icons.flash_off)
                                      : const Icon(Icons.flash_on),
                                ),
                                const SizedBox(height: 16),
                                FloatingActionButton(
                                  onPressed: _toggleCamera,
                                  backgroundColor: const Color(0xFF534F7D),
                                  child: const Icon(Icons.switch_camera),
                                ),
                                const SizedBox(height: 16),
                                FloatingActionButton(
                                  onPressed: _zoomIn,
                                  backgroundColor: const Color(0xFF534F7D),
                                  child: const Icon(Icons.zoom_in),
                                ),
                                const SizedBox(height: 16),
                                FloatingActionButton(
                                  onPressed: _zoomOut,
                                  backgroundColor: const Color(0xFF534F7D),
                                  child: const Icon(Icons.zoom_out),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
        ),
      ),
    );
  }
}
