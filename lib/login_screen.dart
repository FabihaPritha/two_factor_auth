import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  void loginUser(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (verificationId, resendToken) {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => OTPScreen(verificationId: verificationId),
        ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: '+8801930925470'),
            ),
            ElevatedButton(
              onPressed: () => loginUser(context),
              child: Text('Send OTP'),
            )
          ],
        ),
      ),
    );
  }
}
