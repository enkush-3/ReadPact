import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Service/theme_service.dart';
import '../../Providers/auth_provider.dart';
import 'Verify.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onToggle;
  final AppColors colors;
  const RegisterWidget({
    super.key,
    required this.onToggle,
    required this.colors,
  });

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPasswordObscured = true;
  bool _isConfirmObscured = true;

  Widget buildRegisterHeader() {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onToggle,
                  child: Text(
                    "Нэвтрэх",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.colors.text.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Бүртгүүлэх",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.colors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(height: 3, color: widget.colors.secondary),
              ),
              Expanded(
                child: Container(height: 3, color: widget.colors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "И-мэйл",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.colors.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 45,
          constraints: BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: widget.colors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.colors.border, width: 1.5),
          ),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.inter(color: widget.colors.text),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintText: "И-мэйл хаягаа оруулна уу",
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: widget.colors.text.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Нууц үг",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.colors.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 45,
          constraints: BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: widget.colors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.colors.border, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: _isPasswordObscured,
                  controller: passwordController,
                  style: GoogleFonts.inter(color: widget.colors.text),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12, right: 8),
                    hintText: "Нууц үгээ оруулна уу",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: widget.colors.text.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  color: widget.colors.primary,
                ),
                onPressed: () =>
                    setState(() => _isPasswordObscured = !_isPasswordObscured),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Нууц үг давтах",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.colors.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 45,
          constraints: BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: widget.colors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.colors.border, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: _isConfirmObscured,
                  controller: confirmPasswordController,
                  style: GoogleFonts.inter(color: widget.colors.text),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12, right: 8),
                    hintText: "Нууц үгээ дахин оруулна уу",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: widget.colors.text.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isConfirmObscured ? Icons.visibility_off : Icons.visibility,
                  color: widget.colors.primary,
                ),
                onPressed: () =>
                    setState(() => _isConfirmObscured = !_isConfirmObscured),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRegisterButton() {
    return SizedBox(
      width: 320,
      height: 45,
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              backgroundColor: widget.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: auth.isLoading
                ? null
                : () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    String confirmPassword = confirmPasswordController.text
                        .trim();

                    if (email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Бүх талбарыг бөглөнө үү'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Нууц үг таарахгүй байна'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Assuming username is part of email for now or added field
                    String username = email.split('@')[0];

                    final error = await context.read<AuthProvider>().register(
                      username,
                      email,
                      password,
                    );

                    if (error == null) {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerifyPage(colors: widget.colors, email: email),
                          ),
                        );
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
            child: auth.isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "Бүртгүүлэх",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget buildRegisterUI() {
    return Column(
      children: [
        buildRegisterHeader(),
        SizedBox(height: 40),
        buildEmailField(),
        SizedBox(height: 16),
        buildPasswordField(),
        SizedBox(height: 24),
        buildConfirmPasswordField(),
        SizedBox(height: 24),
        buildRegisterButton(),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Бүртгэлтэй бол",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: widget.colors.text.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: widget.onToggle,
              child: Text(
                "Нэвтрэх",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.colors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRegisterUI();
  }
}
