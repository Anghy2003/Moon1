import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '1/4',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _sectionLabel('Check In', screenWidth),
              _calendarCard(
                selectedDay: _selectedCheckInDay,
                focusedDay: _focusedCheckInDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedCheckInDay = selectedDay;
                    _focusedCheckInDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 20),
              _sectionLabel('Check Out', screenWidth),
              _calendarCard(
                selectedDay: _selectedCheckOutDay,
                focusedDay: _focusedCheckOutDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedCheckOutDay = selectedDay;
                    _focusedCheckOutDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton('Anterior', () {
                    context.go('/calendario');
                  }, screenWidth),
                  _buildNavButton('Continuar', () {
                    if (_selectedCheckOutDay.isBefore(_selectedCheckInDay)) {
                      _showErrorDialog(context);
                    } else {
                      context.go('/datos-pago');
                    }
                  }, screenWidth),
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

  Widget _calendarCard({
    required DateTime selectedDay,
    required DateTime focusedDay,
    required void Function(DateTime, DateTime) onDaySelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyanAccent, Colors.cyan],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.blue),
          weekendTextStyle: TextStyle(color: Colors.red),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.red),
          weekdayStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed, double screenWidth) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 3,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.white,
            ),
          ),
        ),
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
