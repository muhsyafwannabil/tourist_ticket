import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showQrisDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Pembayaran QRIS"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: "https://example.com/qris-payment",
            size: 200,
          ),
          const SizedBox(height: 10),
          const Text(
            "Scan kode QR ini untuk melakukan pembayaran.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Tutup"),
        ),
      ],
    ),
  );
}
