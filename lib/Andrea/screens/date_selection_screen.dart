import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/Andrea/screens/reservation_detail_screen.dart';
import 'package:moon_aplication/Andrea/widgets/calendar_input.dart';
import 'package:moon_aplication/Andrea/widgets/calendarioCard.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedCheckInDay = DateTime.now();
  DateTime _selectedCheckInDay = DateTime.now();

  DateTime _focusedCheckOutDay = DateTime.now().add(Duration(days: 1));
  DateTime _selectedCheckOutDay = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
   

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '1/4',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true, // ⬅️ Esto centra el título
        backgroundColor: const Color(0xFFE0F7FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
     backgroundColor: Color(0xFFE6F9FF), // Color de fondo celeste suave
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              _sectionLabel('Check In', screenWidth),
              CalendarioCard(selectedDay: _selectedCheckInDay, focusedDay: _focusedCheckInDay, onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedCheckInDay = selectedDay;
                    _focusedCheckInDay = focusedDay;
                  });
                }),
              const SizedBox(height: 15),

              _sectionLabel('Check Out', screenWidth),
              CalendarioCard(selectedDay: _selectedCheckOutDay, focusedDay: _focusedCheckOutDay, onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedCheckOutDay = selectedDay;
                    _focusedCheckOutDay = focusedDay;
                  });
                }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BotonNavegacion(text: 'Anterior', onPressed: () {
                    context.go('/calendario');
                  }, screenWidth: screenWidth),
                  BotonNavegacion(text: 'Continuar', onPressed: () {
                    if (_selectedCheckOutDay.isBefore(_selectedCheckInDay)) {
                      _showErrorDialog(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservaDetalladaScreen(),
                        ), // tu widget de destino
                      );

                    }
                  }, screenWidth: screenWidth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text, double screenWidth) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth * 0.042,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Fecha inválida'),
        content: const Text('La fecha de Check Out debe ser posterior a la de Check In.'),
        actions: [
          TextButton(
          //onPressed: () => Navigator.of(context).pop(),
          onPressed: null,
          
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}




