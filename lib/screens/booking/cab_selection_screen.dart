import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_review_screen.dart';

class CabSelectionScreen extends StatefulWidget {
  final String from;
  final String to;
  final String date;
  final String time;
  final bool isOneWay;
  final String phoneNumber;

  const CabSelectionScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.isOneWay,
    required this.phoneNumber,
  });

  @override
  State<CabSelectionScreen> createState() => _CabSelectionScreenState();
}

class _CabSelectionScreenState extends State<CabSelectionScreen> with SingleTickerProviderStateMixin {
  int _selectedCarIndex = 1; // Default to Sedan
  late TabController _tabController;

  final List<Map<String, dynamic>> carTypes = [
    {'name': 'Hatchback', 'price': '₹ 2596', 'image': 'assets/images/cab_hatchback.png'},
    {'name': 'Sedan', 'price': '₹ 2655', 'image': 'assets/images/cab_sedan.png'},
    {'name': 'Ertiga', 'price': '₹ 3336', 'image': 'assets/images/cab_ertiga.png'},
    {'name': 'Crysta', 'price': '₹ 6344', 'image': 'assets/images/cab_crysta.png'},
    {'name': 'Innova', 'price': '₹ 7344', 'image': 'assets/images/cab_innova.png'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${widget.from} - ${widget.to}',
          style: GoogleFonts.outfit(
            color: Colors.blue.shade400,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.blue.shade400, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Trip Info Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.withOpacity(0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isOneWay ? 'One Way' : 'Round Trip',
                        style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.from} - ${widget.to}',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pickup Details: ${widget.date} | ${widget.time}',
                        style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('Modify Booking', style: GoogleFonts.outfit(color: Colors.blue, fontSize: 12)),
                ),
              ],
            ),
          ),

          // Car Selection List
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: carTypes.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCarIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCarIndex = index),
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Text(
                          carTypes[index]['name'],
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Image.asset(
                            carTypes[index]['image'],
                            height: 40,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, size: 24, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          carTypes[index]['price'],
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Car Details Card
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMainCarCard(),
                  const SizedBox(height: 16),
                  _buildInfoBar(),
                  const SizedBox(height: 16),
                  _buildDetailsTabs(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCarCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carTypes[_selectedCarIndex]['name'],
                      style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('4-7 seater AC Cab ', style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Text('4.5', style: GoogleFonts.outfit(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              const Icon(Icons.star, color: Colors.white, size: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                carTypes[_selectedCarIndex]['image'],
                width: 150,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.directions_car, color: Colors.grey.shade400, size: 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Icon(Icons.percent, color: Colors.green.shade600, size: 12),
                    const SizedBox(width: 4),
                    Text('11% OFF', style: GoogleFonts.outfit(color: Colors.green.shade600, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('₹ 2,983', style: GoogleFonts.outfit(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            carTypes[_selectedCarIndex]['price'],
            style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
          ),
          Text(
            '+ ₹ 432 Charges and Taxes',
            style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildInclusionItem(Icons.person_outline, 'Driver allowance included'),
          _buildInclusionItem(Icons.speed, '260 kms included | Post limit: ₹ 14.25/km'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Icon(Icons.new_releases_outlined, color: Colors.blue.shade400, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'New Car Promise - Model that is 2023 or newer @ ₹ 249',
                    style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingReviewScreen(
                      from: widget.from,
                      to: widget.to,
                      date: widget.date,
                      time: widget.time,
                      isOneWay: widget.isOneWay,
                      carName: carTypes[_selectedCarIndex]['name'],
                      price: carTypes[_selectedCarIndex]['price'],
                      phoneNumber: widget.phoneNumber,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'SELECT CAR',
                style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInclusionItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.outfit(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem(Icons.currency_rupee, 'Book Now\nat Zero Cost'),
          _buildInfoDivider(),
          _buildInfoItem(Icons.cancel_outlined, 'Free Cancellations\nTill 1 Hour'),
          _buildInfoDivider(),
          _buildInfoItem(Icons.support_agent, '24x7\nCustomer Support'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade400, size: 20),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
      ],
    );
  }

  Widget _buildInfoDivider() {
    return Container(height: 30, width: 1, color: Colors.blue.shade200);
  }

  Widget _buildDetailsTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.zero,
            padding: const EdgeInsets.all(4),
            tabs: const [
              Tab(child: Text('INCLUSIONS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
              Tab(child: Text('EXCLUSIONS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
              Tab(child: Text('FACILITIES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
              Tab(child: Text('T&C', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTabDetailItem(Icons.local_gas_station_outlined, 'Fuel Charges'),
                _buildTabDetailItem(Icons.person_outline, 'Driver Allowance'),
                _buildTabDetailItem(Icons.receipt_long_outlined, 'Toll / State tax'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
            child: Icon(icon, size: 20, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 16),
          Text(text, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
