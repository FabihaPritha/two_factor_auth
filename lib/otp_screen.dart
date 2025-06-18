import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OTPScreen extends StatelessWidget {
  final String verificationId;
  final TextEditingController otpController = TextEditingController();

  OTPScreen({super.key, required this.verificationId});

  void verifyOTP(BuildContext context) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verified!')));
      // Navigate to Dashboard here
    } catch (e) {
      print("Error verifying OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: otpController,
            decoration: InputDecoration(hintText: 'Enter OTP'),
          ),
          ElevatedButton(
            onPressed: () => verifyOTP(context),
            child: Text('Verify'),
          )
        ],
      ),
    );
  }
}
