import 'package:flutter/material.dart';
import 'home.dart';
import 'forum.dart';
import 'chatbot.dart';
import 'profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  void _onNavTap(BuildContext context, int index) {
    if (index == selectedIndex) return; // Don't navigate if already on current page

    Widget page;
    switch (index) {
      case 0:
        page = const HomeMenu();
        break;
      case 1:
        page = const ForumPage();
        break;
      case 2:
        page = const ChatbotPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main navigation bar
        Container(
          height: 100,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mappage/homebackgroundCopy.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [                BottomNavigationBarItem(
                  icon: SizedBox(height: 60, width: 60),
                  label: '',
                ),BottomNavigationBarItem(
                  icon: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.only(left: 25),
                    child: ColorFiltered(
                      colorFilter: selectedIndex == 1
                          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      child: Image.asset('assets/mappage/forum.png', height: 60),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.only(left: 25),
                    child: ColorFiltered(
                      colorFilter: selectedIndex == 2
                          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      child: Image.asset('assets/mappage/chatbot.png', height: 60),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.only(left: 25),
                    child: ColorFiltered(
                      colorFilter: selectedIndex == 3
                          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      child: Image.asset('assets/mappage/profile.png', height: 60),
                    ),
                  ),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFF37A5FF),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              currentIndex: selectedIndex,
              onTap: (index) => _onNavTap(context, index),
            ),
          ),
        ),
        // Large homeicon.png as background with homedesign.png on top
        Positioned(
          left: MediaQuery.of(context).size.width * 0.125 - 40,
          bottom: 19,
          child: GestureDetector(
            onTap: () => _onNavTap(context, 0),
            child: Container(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,                children: [
                  // homeicon.png as the background circle - no color change
                  Image.asset(
                    'assets/mappage/homeicon.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                  ),                  // homedesign.png icon on top with color inversion
                  ColorFiltered(
                    colorFilter: selectedIndex == 0
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    child: Image.asset(
                      'assets/mappage/homedesign.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}