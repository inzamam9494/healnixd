import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/style/text_style.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class OnboardingSliderScreen extends StatefulWidget {
  const OnboardingSliderScreen({super.key});

  @override
  State<OnboardingSliderScreen> createState() => _OnboardingSliderScreenState();
}

class _OnboardingSliderScreenState extends State<OnboardingSliderScreen> {
  final LiquidController _controller = LiquidController();
  int currentPage = 0;

  final pages = [
    // 🌿 Page 1 – To-do Check (Manage Stock)
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7FC8A9), Color(0xFFB2F7EF)], // soft green tones
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 320,
            child: Lottie.asset('assets/animation/1.json', fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
           Text(
            "Stay Organized, Stay Healed",
            style: AppTextStyles.kBody17SemiBoldTextStyle,
          ),
          const SizedBox(height: 10),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Easily manage your homeopathic medicine inventory track stocks, expiry, and needs with HealnixD.",
              textAlign: TextAlign.center,
              style: AppTextStyles.kSmall8RegularTextStyle,
            ),
          ),
        ],
      ),
    ),

    // 💬 Page 2 – Assistant Saying Hi
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE495DB), Color(0xFFF6ACAC)], // calming blues
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 320,
            child: Lottie.asset('assets/animation/2.json', fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
           Text(
            "Your Smart Homeo Assistant",
              style: AppTextStyles.kBody17SemiBoldTextStyle,
          ),
          const SizedBox(height: 10),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Add, edit, and monitor every medicine effortlessly — HealnixD works like your own clinic helper.",
              textAlign: TextAlign.center,
              style: AppTextStyles.kSmall8RegularTextStyle,
            ),
          ),
        ],
      ),
    ),

    // 📱 Page 3 – Phone Notifications
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFB4A2), Color(0xFFFFD6A5)], // soft coral tones
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 320,
            child: Lottie.asset('assets/animation/3.json', fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          Text(
            "Never Miss a Stock or \n Expiry Update",
            style: AppTextStyles.kBody17SemiBoldTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Get instant notifications for low stock and expiry reminders stay prepared with HealnixD.",
              textAlign: TextAlign.center,
              style: AppTextStyles.kSmall8RegularTextStyle
            ),
          ),
        ],
      ),
    ),
  ];

  void goToHome() {
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
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: goToHome,
                  child: Text(
                    "Skip",
                    style: AppTextStyles.kBody15SemiBoldTextStyle.copyWith(color: Colors.blue),
                  ),
                ),
                Row(
                  children: List.generate(
                    3,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 14 : 8,
                      height: currentPage == index ? 14 : 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.blue
                            : Colors.blue.shade200,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (currentPage == 2) {
                      goToHome();
                    } else {
                      _controller.animateToPage(
                        page: currentPage + 1,
                        duration: 600,
                      );
                    }
                  },
                  child: Text(
                    currentPage == 2 ? "Done" : "Next",
                    style: AppTextStyles.kBody15SemiBoldTextStyle.copyWith(color: Colors.blue),
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
