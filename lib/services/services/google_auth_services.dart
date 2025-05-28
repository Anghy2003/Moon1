import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final docRef = FirebaseFirestore.instance.collection('usuarios').doc(user.uid);
        final snapshot = await docRef.get();

        if (!snapshot.exists) {
          await docRef.set({
            'uid': user.uid,
            'nombre': user.displayName ?? 'Usuario desconocido',
            'correo': user.email ?? 'Correo no disponible',
            'fotoUrl': user.photoURL ?? '',
            'fechaRegistro': FieldValue.serverTimestamp(),
          });
        }
      }

      return userCredential;
    } catch (e) {
      // print("Error en signInWithGoogle: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // print("Error al cerrar sesión: $e");
    }
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}