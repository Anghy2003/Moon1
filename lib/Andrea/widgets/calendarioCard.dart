import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioCard extends StatelessWidget {
  const CalendarioCard({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  final DateTime selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime, DateTime) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 260, // Altura fija
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 129, 251, 251),
            theme.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        rowHeight: 33,
        daysOfWeekHeight: 18,
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.bold, // Negrita para los días normales
          ),
          weekendTextStyle: TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Negrita para los fines de semana
          ),
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(142, 255, 34, 0),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 11,
            fontWeight: FontWeight.bold, // Negrita para el día seleccionado
          ),
          outsideDaysVisible: false,
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, size: 18, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, size: 18, color: Colors.white),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold, // Negrita para días de semana
          ),
          weekendStyle: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Negrita para fines de semana
          ),
        ),
      ),
    );
  }
}
