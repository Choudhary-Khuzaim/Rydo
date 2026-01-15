import 'package:flutter/material.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Send Money",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle("Recipient"),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Name, Mobile or ID",
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.black54,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Quick Contacts",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildAddContact(),
                    _buildContactAvatar(
                      "Alex",
                      "https://i.pravatar.cc/150?u=1",
                    ),
                    _buildContactAvatar(
                      "Sara",
                      "https://i.pravatar.cc/150?u=2",
                    ),
                    _buildContactAvatar(
                      "John",
                      "https://i.pravatar.cc/150?u=3",
                    ),
                    _buildContactAvatar(
                      "Emma",
                      "https://i.pravatar.cc/150?u=4",
                    ),
                    _buildContactAvatar(
                      "Mike",
                      "https://i.pravatar.cc/150?u=5",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle("Amount to Send"),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Enter Amount",
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Rs. 0.00",
                        hintStyle: TextStyle(color: Colors.white24),
                        border: InputBorder.none,
                        prefixStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Divider(color: Colors.white12, height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Balance",
                          style: TextStyle(color: Colors.white60, fontSize: 13),
                        ),
                        Text(
                          "Rs. 12,500.00",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120), // Spacer for button
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () => _showConfirmation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Send Now",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAddContact() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
          const SizedBox(height: 8),
          const Text(
            "Add",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildContactAvatar(String name, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text("Payment Sent Successfully!"),
          ],
        ),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
  }
}
