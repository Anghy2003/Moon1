import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Fechas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Check In',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildCalendar(_checkInDate, (date) {
              setState(() {
                _checkInDate = date;
              });
            }),
            SizedBox(height: 20),
            Text(
              'Check Out',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildCalendar(_checkOutDate, (date) {
              setState(() {
                _checkOutDate = date;
              });
            }),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción para el botón "Anterior"
                  },
                  child: Text('Anterior'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción para el botón "Continuar"
                    
                  },
                  child: Text('Continuar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(
    DateTime selectedDate,
    Function(DateTime) onDateSelected,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(8),
      child: CalendarCarousel(
        onDayPressed: (date, events) {
          onDateSelected(date);
        },
        selectedDateTime: selectedDate,
        weekendTextStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
