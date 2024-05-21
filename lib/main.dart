import 'package:flutter/material.dart';
import 'package:flutter_application_3/filter.dart';
import 'camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            const Center(
              child: MenuScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/launch_image.png',
                height: 350,
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraPage()),
                      );
                    },
                    icon: const Icon(Icons.camera, size: 30),
                    label: const Text('Live Camera',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF534F7D),
                      minimumSize: const Size(300, 100),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterPage()),
                      );
                    },
                    icon: const Icon(Icons.filter, size: 30),
                    label: const Text(
                      'Colorblind Simulator',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF534F7D),
                      minimumSize: const Size(300, 100),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigation to History page
                    },
                    icon: const Icon(Icons.history, size: 30),
                    label: const Text('History',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF534F7D),
                      minimumSize: const Size(300, 100),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
