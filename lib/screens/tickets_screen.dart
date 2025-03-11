import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final List<Map<String, String>> tickets = [
    {'title': 'Bali Beach Ticket', 'date': '25 Maret 2025'},
    {'title': 'Mount Bromo Sunrise Tour', 'date': '30 Maret 2025'},
    {'title': 'Jakarta City Tour', 'date': '10 April 2025'},
    {'title': 'Labuan Bajo Sailing Trip', 'date': '25 Juni 2025'},
    {'title': 'Derawan Islands Diving', 'date': '1 Februari 2025'},
    {'title': 'Komodo Island Adventure', 'date': '19 Mei 2025'},
  ];

  void _deleteTicket(int index) {
    setState(() {
      tickets.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ticket Has Been Deleted'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'Delete Ticket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete this ticket?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteTicket(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tour Tickets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: tickets.isEmpty
          ? const Center(
              child: Text(
                'No Tickets Found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.airplane_ticket,
                          color: Colors.blueAccent, size: 30),
                    ),
                    title: Text(
                      tickets[index]['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.orangeAccent, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          tickets[index]['date']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _showDeleteDialog(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
