// File: rating_screen.dart

import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> orderItem; // Jo item ka review de rahe ho
  final Function(double rating, String feedback) onSubmit;

  const RatingScreen({
    super.key,
    required this.orderItem,
    required this.onSubmit,
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 5.0;
  final TextEditingController _feedbackController = TextEditingController();
  final List<String> _quickFeedbacks = [
    "Delicious food",
    "Super fast delivery",
    "Well packed",
    "Portion size was great",
    "Little spicy",
    "Could be better",
    "Missing items",
    "Cold food"
  ];

  final Set<String> _selectedQuick = {};

  @override
  Widget build(BuildContext context) {
    final item = widget.orderItem;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Rate Your Experience",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 24),

            // Star Rating
            const Text(
              "How was your food?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    iconSize: 48,
                    onPressed: () {
                      setState(() => _rating = index + 1.0);
                    },
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  );
                }),
              ),
            ),
            Center(
              child: Text(
                _getRatingText(_rating),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _rating >= 4 ? Colors.green : _rating >= 2 ? Colors.orange : Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Quick Feedback Chips
            const Text(
              "Quick Feedback (optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _quickFeedbacks.map((text) {
                final isSelected = _selectedQuick.contains(text);
                return FilterChip(
                  label: Text(text),
                  selected: isSelected,
                  selectedColor: Colors.orange.shade100,
                  checkmarkColor: Colors.orange.shade700,
                  backgroundColor: Colors.grey.shade100,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedQuick.add(text);
                      } else {
                        _selectedQuick.remove(text);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Written Review
            const Text(
              "Write a review (optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Share your experience... (e.g., taste, packaging, delivery)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  final feedback = [
                    _feedbackController.text.trim(),
                    ..._selectedQuick,
                  ].where((e) => e.isNotEmpty).join(" • ");

                  widget.onSubmit(_rating, feedback);

                  // Success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 12),
                          Text("Thank you for your feedback!", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      backgroundColor: Colors.green.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                child: const Text(
                  "Submit Review",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating >= 4.5) return "Loved it!";
    if (rating >= 4.0) return "Great!";

    if (rating >= 3.0) return "Good";
    if (rating >= 2.0) return "Okay";
    return "Not good";
  }
}