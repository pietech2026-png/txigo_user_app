import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateTimePickerDialog extends StatelessWidget {
  final String label;

  const DateTimePickerDialog({super.key, required this.label});

  List<String> _generateDates() {
    List<String> dates = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 90; i++) {
      DateTime date = now.add(Duration(days: i));
      dates.add(DateFormat('EEE MMM dd').format(date));
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dates = _generateDates();
    String today = dates.first;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Select $label Date And Time',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    padding: const EdgeInsets.all(4),
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.cyan.withOpacity(0.05),
                              border: Border.all(color: Colors.cyan.shade200),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildPickerColumn(dates, today),
                              _buildPickerColumn(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'], '3'),
                              const Text(':', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.cyan)),
                              _buildPickerColumn(['00', '15', '30', '45'], '45'),
                              _buildPickerColumn(['AM', 'PM'], 'PM'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.02),
                        border: Border.all(color: Colors.cyan.shade100),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label.toUpperCase(),
                            style: GoogleFonts.outfit(fontSize: 10, color: Colors.cyan, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dates.first,
                            style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '03:45 PM',
                            style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade400,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          'CONFIRM',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerColumn(List<String> items, String selected) {
    int selectedIndex = items.indexOf(selected);
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: selectedIndex),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {
            bool isSelected = index == selectedIndex;
            return Center(
              child: Text(
                items[index],
                style: GoogleFonts.outfit(
                  fontSize: isSelected ? 16 : 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.cyan : Colors.grey.shade400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
