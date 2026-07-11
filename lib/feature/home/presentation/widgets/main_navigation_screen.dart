import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/chat/presentation/chat_view.dart';
import 'package:decora/feature/home/presentation/home_view.dart';
import 'package:decora/feature/preview/preview_view.dart';
import 'package:decora/feature/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;



  late final List<Widget> _pages = [
    const HomeView(),
    PreviewRoomDecoratorView(
      onBack: () => setState(() => currentIndex = 0),
    ),
    const ChatView(),
    const ProfileView(),
  ];

  static const int _previewTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    final bool showBottomBar = currentIndex != _previewTabIndex;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
 
      bottomNavigationBar: showBottomBar
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
              
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.greyColor,
                  backgroundColor: AppColors.lightBackground,
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Camera',
                      icon: Icon(Icons.photo_camera_outlined),
                    ),
                    BottomNavigationBarItem(
                      label: 'Chat',
                      icon: Icon(Icons.chat_bubble),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(Icons.person_2_outlined),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}