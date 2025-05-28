import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/reservation_detail_screen.dart';
import 'package:moon_aplication/Andrea/widgets/calendar_input.dart';
import 'package:moon_aplication/Andrea/widgets/calendarioCard.dart';

import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart'; 

class CalendarScreen extends StatefulWidget {
   final Hotel hotel;
  const CalendarScreen({super.key, required this.hotel});

  @override
  // ignore: library_private_types_in_public_api
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: GradienteColorFondo.backgroundGradient,
          ),
          child: AppBar(
            title: const Text(
              '1/4',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: GradienteColorFondo.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _sectionLabel('Check In', screenWidth),
                CalendarioCard(
                  selectedDay: _selectedCheckInDay,
                  focusedDay: _focusedCheckInDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedCheckInDay = selectedDay;
                      _focusedCheckInDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 15),
                _sectionLabel('Check Out', screenWidth),
                CalendarioCard(
                  selectedDay: _selectedCheckOutDay,
                  focusedDay: _focusedCheckOutDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedCheckOutDay = selectedDay;
                      _focusedCheckOutDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BotonNavegacion(
                      text: 'Anterior',
                      onPressed: () {
                        context.go('/calendario');
                      },
                      screenWidth: screenWidth,
                    ),
                    BotonNavegacion(
                      text: 'Continuar',
                      onPressed: () {
                        if (_selectedCheckOutDay.isBefore(_selectedCheckInDay)) {
                          _showErrorDialog(context);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservaDetalladaScreen(hotel: widget.hotel,
                                fechaCheckIn: _selectedCheckInDay,
                                fechaCheckOut: _selectedCheckOutDay,),
                            ),
                          );
                        }
                      },
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
              ],
            ),
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
