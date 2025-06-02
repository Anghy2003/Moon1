import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UbicacionService {
  static Future<String> obtenerUbicacion() async {
    bool servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      return "GPS desactivado, activa el servicio de ubicación";
    }

    LocationPermission permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied || permiso == LocationPermission.deniedForever) {
      return "Permiso denegado, revisa la configuración";
    }

    try {
      Position posicion = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        posicion.latitude, posicion.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark lugar = placemarks.first;
        return "${(lugar.locality ?? '').isNotEmpty ? lugar.locality : lugar.subAdministrativeArea ?? ''}, ${lugar.administrativeArea ?? ''}, ${lugar.country ?? ''}";
      } else {
        return "Ubicación no encontrada";
      }
    } catch (e) {
      return "Error al obtener ubicación";
    }
  }
}