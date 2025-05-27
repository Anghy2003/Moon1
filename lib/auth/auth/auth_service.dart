import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Inicio de sesión cancelado');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Guardar datos del usuario en Firestore si es nuevo
    final user = userCredential.user;
    if (user != null) {
      final docRef = FirebaseFirestore.instance.collection('usuarios').doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'uid': user.uid,
          'nombre': user.displayName,
          'correo': user.email,
          'fotoUrl': user.photoURL,
          'fechaRegistro': FieldValue.serverTimestamp(),
        });
      }
    }

    return userCredential;
  }
}
