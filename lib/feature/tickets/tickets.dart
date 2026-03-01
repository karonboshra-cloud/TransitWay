import 'package:flutter/material.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Tickets',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 104,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFCDDFDA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '★',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 24,
                      height: -0.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF054F3A), Color(0xFF054F3A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      '9833',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTicketCard(
            busNumber: '359',
            price: '35',
            time: '9:00 pm',
            date: '25-2-2026',
          ),
          const SizedBox(height: 16),
          _buildTicketCard(
            busNumber: '009',
            price: '35',
            time: '1:30 pm',
            date: '2-2-2026',
          ),
          const SizedBox(height: 16),
          _buildTicketCard(
            busNumber: '117',
            price: '15',
            time: '7:00 am',
            date: '21-1-2026',
          ),
          const SizedBox(height: 16),
          _buildTicketCard(
            busNumber: 'Q9',
            price: '35',
            time: '12:00 pm',
            date: '22-2-2026',
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard({
    required String busNumber,
    required String price,
    required String time,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF054F3A), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 45,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(painter: DottedVerticalLinePainter()),
                  const Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'هيئة النقل العام',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'بالقاهرة',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Bus:', busNumber),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            'Price:',
                            '$price EGP',
                            color: const Color(0xFF000000),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow('Time:', time),
                          const SizedBox(height: 8),
                          _buildInfoRow('Date:', date),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 55,
                            child: Image.asset(
                              'assets/logo/1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 55,
                            height: 50,
                            child: Image.asset(
                              'assets/logo/2.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(
                                    0xFF054F3A,
                                  ).withOpacity(0.1),
                                );
                              },
                            ),
                          ),
                        ],
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

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Row(
      children: [
        const SizedBox(width: 6),
        Text(label),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}

class DottedVerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF054F3A)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashHeight = 6.0;
    const dashSpace = 6.0;
    double startY = 0.0;

    final xPosition = size.width / 0.9;

    while (startY < size.height) {
      final endY = (startY + dashHeight).clamp(0.0, size.height);
      canvas.drawLine(
        Offset(xPosition, startY),
        Offset(xPosition, endY),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
