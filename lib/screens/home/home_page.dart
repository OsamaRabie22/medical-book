import 'package:flutter/material.dart';
import 'package:medical_book/screens/home/specialties_page.dart';
import 'bottom_navigation.dart';
import 'home_content.dart';

class HomePage extends StatefulWidget {
  final int initialIndex; // إضف هذا الـ parameter

  const HomePage({
    super.key,
    this.initialIndex = 0, // قيمة افتراضية
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // إستخدم الـ initialIndex
  }

  // الصفحات اللي هنربطها بالـ BottomNav
  final List<Widget> pages = [
    const HomeContent(),
    const SpecialtiesPage(), // دي هتكون SearchPage دلوقتي
    const AppointmentsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF9F8),
      body: pages[_currentIndex],
      bottomNavigationBar: buildBottomNav(),
    );
  }

  // ✅ Bottom Navigation Bar
  Widget buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.local_hospital_outlined, 'label': 'Specialties'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Appointments'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D9A8E),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = _currentIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFF0D9A8E),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    color: isSelected ? const Color(0xFF0D9A8E) : Colors.white,
                    size: 24,
                  ),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        items[index]['label'] as String,
                        style: const TextStyle(
                          color: Color(0xFF0D9A8E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
