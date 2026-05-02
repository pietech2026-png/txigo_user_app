import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/booking_card.dart';
import 'widgets/banners_section.dart';
import 'widgets/expert_section.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/pet_cab_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;
  bool _isOneWay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.5,
        title: Text(
          'Txigo',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle, color: Colors.blue.shade400, size: 32),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookingCard(
              isOneWay: _isOneWay,
              onToggle: (val) => setState(() => _isOneWay = val),
            ),
            const PetCabBanner(),
            const BannersSection(),
            const ExpertSection(),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }
}
