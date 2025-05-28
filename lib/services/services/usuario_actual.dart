import 'package:firebase_auth/firebase_auth.dart';

class UsuarioActual {
  static String uid = '';
  static String nombre = '';
  static String correo = '';
  static String fotoUrl = '';
  static String ubicacion = '';//no  guardando en la Base (se calcula cada sesion)

  static void cargarDesdeFirebase(User user) {
    uid = user.uid;
    nombre = user.displayName ?? '';
    correo = user.email ?? '';
    fotoUrl = user.photoURL ?? '';
  }
}
