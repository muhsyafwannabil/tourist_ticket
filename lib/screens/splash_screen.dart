import 'package:flutter/material.dart';
import 'package:tiket_wisata/utils/navigation_extension.dart';
import 'package:tiket_wisata/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // **🔹 Animasi Fade In**
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // **🔹 Navigasi ke Login setelah 3 detik**
    Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacement(const LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent, 
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // **✈️ Icon yang lebih besar**
              const Icon(Icons.airplanemode_active, size: 120, color: Colors.white),
              const SizedBox(height: 20),

              // **📝 Animasi Teks**
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: const Text(
                  "Tourist Ticket",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(height: 40),

              // **🌟 Animasi Loading yang Lebih Keren Tanpa Package**
              Container(
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(
                  strokeWidth: 5, // Lebih tebal agar terlihat premium
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
