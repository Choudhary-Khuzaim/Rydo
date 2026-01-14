import 'package:flutter/material.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Send Money",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To Whom?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Name or Mobile Number",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Quick Contacts",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildContactAvatar("Alex", "https://i.pravatar.cc/150?u=1"),
                  _buildContactAvatar("Sara", "https://i.pravatar.cc/150?u=2"),
                  _buildContactAvatar("John", "https://i.pravatar.cc/150?u=3"),
                  _buildContactAvatar("Emma", "https://i.pravatar.cc/150?u=4"),
                  _buildContactAvatar("Mike", "https://i.pravatar.cc/150?u=5"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Amount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Rs. 0.00",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Money sent successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Send Money",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactAvatar(String name, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(url)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
