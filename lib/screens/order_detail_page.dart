import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import '../models/product_model.dart';

class OrderDetailPage extends StatefulWidget {
  final Product product;

  const OrderDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showTransferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Bank Transfer Payment"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Please transfer to the following account:\n"
                    "Bank ABC - 1234567890\n"
                    "A/N Example Name",
                  ),
                  const SizedBox(height: 15),
                  _image != null
                      ? Image.file(_image!,
                          width: 200, height: 200, fit: BoxFit.cover)
                      : const Text("No image uploaded yet."),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _image = File(pickedFile.path);
                        });
                      }
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Proof of Transfer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: _image != null
                      ? () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Proof of transfer uploaded successfully!")),
                          );
                        }
                      : null, // Disable button if no image uploaded
                  child: const Text("Send"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Payment Method"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.qr_code, color: Colors.white),
                label: const Text("Pay with QRIS",
                    style: TextStyle(color: Colors.white)),
                onPressed: () => _showQrisDialog(context),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.money, color: Colors.white),
                label: const Text("Pay with Cash",
                    style: TextStyle(color: Colors.white)),
                onPressed: () => _showCashDialog(context),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.account_balance, color: Colors.white),
                label: const Text("Pay with Transfer",
                    style: TextStyle(color: Colors.white)),
                onPressed: () => _showTransferDialog(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showQrisDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("QRIS Payment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/qris_code.jpg",
                  width: 200, height: 200),
              const SizedBox(height: 10),
              const Text("Scan the QR code to complete payment."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showPaymentSuccessDialog(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Payment Successful"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              SizedBox(height: 10),
              Text("Your payment was successful!"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showCashDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cash Payment"),
          content: const Text("Please pay at the ticket counter."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                widget.product.imageUrl,
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 5),
                      Text("Indonesia", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Enjoy a wonderful experience in this amazing place. "
                    "Discover breathtaking views and unforgettable memories.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _showPaymentDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Payment",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
