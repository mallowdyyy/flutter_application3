// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({Key? key}) : super(key: key);

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool _isFrontCamera = false;
//   bool _isCameraChanging = false;

//   int _selectedIndex = 0;
//   static const List<String> _filterOptions = [
//     'Normal',
//     'Deuteranopia',
//     'Protanopia',
//     'Tritanopia',
//     'Achromatopsia',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;

//     _controller = CameraController(
//       selectedCamera,
//       ResolutionPreset.ultraHigh,
//     );

//     await _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _toggleCamera() async {
//     setState(() {
//       _isCameraChanging = true;
//     });

//     final cameras = await availableCameras();
//     final newCamera = _isFrontCamera ? cameras.first : cameras.last;

//     await _controller.dispose();

//     _controller = CameraController(
//       newCamera,
//       ResolutionPreset.ultraHigh,
//     );

//     _initializeControllerFuture = _controller.initialize();
//     await _initializeControllerFuture;

//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//       _isCameraChanging = false;
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // Here you can add logic to apply the selected filter
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         backgroundColor: const Color(0xFF534F7D),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 0.0),
//           child: _isCameraChanging
//               ? const Center(child: CircularProgressIndicator())
//               : FutureBuilder<void>(
//                   future: _initializeControllerFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return Stack(
//                         children: [
//                           Positioned.fill(
//                             child: AspectRatio(
//                               aspectRatio: _controller.value.aspectRatio,
//                               child: CameraPreview(_controller),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: _filterOptions
//             .map((filter) => BottomNavigationBarItem(
//                   icon: Icon(Icons.filter),
//                   label: filter,
//                 ))
//             .toList(),
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFF534F7D), // Updated color
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = false;
  bool _isCameraChanging = false;

  int _selectedIndex = 0;
  static const List<String> _filterOptions = [
    'Normal',
    'Deuteranopia',
    'Protanopia',
    'Tritanopia',
    'Achromatopsia',
  ];

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ignore: unused_element
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

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _isCameraChanging = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Here you can add logic to apply the selected filter
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
          padding: const EdgeInsets.only(bottom: 0.0),
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
      bottomNavigationBar: BottomNavigationBar(
        items: _filterOptions
            .map((filter) => BottomNavigationBarItem(
                  icon: const Icon(Icons.filter),
                  label: filter,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF534F7D), // Updated color
        unselectedItemColor: Colors.grey, // Added unselected item color
        onTap: _onItemTapped,
      ),
    );
  }
}
