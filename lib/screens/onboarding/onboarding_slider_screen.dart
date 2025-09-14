import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnboardingSliderScreen extends StatefulWidget {
  const OnboardingSliderScreen({super.key});

  @override
  State<OnboardingSliderScreen> createState() => _OnboardingSliderScreenState();
}

class _OnboardingSliderScreenState extends State<OnboardingSliderScreen> {
  final LiquidController _controller = LiquidController();
  int currentPage = 0;

  final pages = [
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text("Welcome",
            style: TextStyle(fontSize: 32, color: Colors.white)),
      ),
    ),
    Container(
      color: Colors.green,
      child: const Center(
        child: Text("Explore Features",
            style: TextStyle(fontSize: 32, color: Colors.white)),
      ),
    ),
    Container(
      color: Colors.red,
      child: const Center(
        child: Text("Get Started",
            style: TextStyle(fontSize: 32, color: Colors.white)),
      ),
    ),
  ];

  void goToHome() {
    /// replace with your main screen route
    Get.offAllNamed(ApplicationRoutes.bottomNavigationMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: _controller,
            onPageChangeCallback: (page) {
              setState(() => currentPage = page);
            },
            enableLoop: false,
            waveType: WaveType.liquidReveal,
            slideIconWidget:
            const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),

          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip
                TextButton(
                  onPressed: goToHome,
                  child: const Text("Skip",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),

                // Dots Indicator
                Row(
                  children: List.generate(
                    pages.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 14 : 8,
                      height: currentPage == index ? 14 : 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.white
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                // Next / Done
                TextButton(
                  onPressed: () {
                    if (currentPage == pages.length - 1) {
                      goToHome();
                    } else {
                      _controller.animateToPage(
                        page: currentPage + 1,
                        duration: 600,
                      );
                    }
                  },
                  child: Text(
                    currentPage == pages.length - 1 ? "Done" : "Next",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
