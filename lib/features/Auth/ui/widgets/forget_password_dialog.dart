import 'package:flutter/material.dart';
import 'package:bookmarker/features/Auth/data/auth.dart';
import 'package:bookmarker/core/theming/colors.dart';

class ForgetPasswordDialog extends StatefulWidget {
  @override
  _ForgetPasswordDialogState createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String response = await Auth.forgetPassword(_emailController.text.trim());
    setState(() {
      _isLoading = false;
      _errorMessage = response == "Forget password success" ? null : response;
    });

    if (_errorMessage == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password reset email sent"),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _resetPassword,
                    child: Text("Reset Password"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.coco,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
