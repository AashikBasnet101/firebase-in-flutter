import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';

class SelfieVerificationScreen extends StatefulWidget {
  const SelfieVerificationScreen({super.key});

  @override
  State<SelfieVerificationScreen> createState() =>
      _SelfieVerificationScreenState();
}

class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? selfieImage;
  bool agreed = false;

  Future<void> takeSelfie() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selfieImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // iOS-style back arrow + title
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Selfie Confirmation",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Click a selfie to verify. Upload a close, straight-faced photo.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Row(
              children: [
                Icon(Icons.remove_red_eye_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Remove your glasses, if necessary.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // uploaded selfie preview
            Center(
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  image: selfieImage != null
                      ? DecorationImage(
                          image: FileImage(File(selfieImage!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: selfieImage == null
                    ? Center(
                        child: Image.asset(
                          'assets/selfie.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // Checkbox on LHS
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text("I agree to the Terms & Conditions"),
              value: agreed,
              onChanged: (v) {
                setState(() {
                  agreed = v!;
                });
              },
            ),

            const Spacer(),

            // Confirm button
            CustomElevatedButton(
              width: double.infinity,
              height: 50,
              backgroundColor: const Color(0xFF4E86A0),
              borderRadius: 8,
              onPressed: agreed
                  ? () async {
                      await takeSelfie();
                    }
                  : null,
              child: const Text(
                "Confirm",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
