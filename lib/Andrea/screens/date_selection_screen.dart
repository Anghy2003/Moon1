import 'package:flutter/material.dart';

import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/hotel-detalles_screen.dart';
import 'package:moon_aplication/Andrea/screens/reservation_detail_screen.dart';
import 'package:moon_aplication/Andrea/widgets/calendar_input.dart';
import 'package:moon_aplication/Andrea/widgets/calendarioCard.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
// Asegúrate de importar esto

class CalendarScreen extends StatefulWidget {
  final Hotel hotel;

  const CalendarScreen({super.key, required this.hotel});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedCheckInDay = DateTime.now();
  DateTime _selectedCheckInDay = DateTime.now();

  DateTime _focusedCheckOutDay = DateTime.now().add(const Duration(days: 1));
  DateTime _selectedCheckOutDay = DateTime.now().add(const Duration(days: 1));

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
            title: const Text('1/4',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _sectionLabel('Check In', screenWidth),
                CalendarioCard(
                  selectedDay: _selectedCheckInDay,
                  focusedDay: _focusedCheckInDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay.isBefore(DateTime.now())) {
                      _showErrorDialog(
                          context, 'La fecha de Check In no puede ser anterior a hoy.');
                      return;
                    }
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
                    if (selectedDay.isBefore(_selectedCheckInDay)) {
                      _showErrorDialog(context,
                          'La fecha de Check Out debe ser posterior a la de Check In.');
                      return;
                    }
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HoteldetallesScreen(idHotel: widget.hotel.id),
                          ),
                        );
                      },
                      screenWidth: screenWidth,
                    ),
                    BotonNavegacion(
                      text: 'Continuar',
                      onPressed: () {
                        if (_selectedCheckOutDay.isBefore(_selectedCheckInDay)) {
                          _showErrorDialog(context,
                              'La fecha de Check Out debe ser posterior a la de Check In.');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservaDetalladaScreen(
                                hotel: widget.hotel,
                                fechaCheckIn: _selectedCheckInDay,
                                fechaCheckOut: _selectedCheckOutDay,
                              ),
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

  void _showErrorDialog(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Cerrar',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
