import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Service/theme_service.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onToggle;
  final AppColors colors;
  const LoginWidget({super.key, required this.onToggle, required this.colors});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  Widget buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "И-мэйл",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: widget.colors.primary,
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
            fontStyle: FontStyle.italic,
            color: widget.colors.primary,
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
                  controller: passwordController,
                  obscureText: _isPasswordObscured,
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
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
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

  Widget buildLoginButton() {
    return SizedBox(
      width: 320,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: widget.colors.primary,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          print("Email: ${emailController.text}");
          print("Password: ${passwordController.text}");
        },
        child: Text(
          "Нэвтрэх",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildLoginHeader() {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Нэвтрэх",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.colors.primary,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: widget.onToggle,
                  child: Text(
                    "Бүртгүүлэх",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.colors.text.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(height: 3, color: widget.colors.primary),
              ),
              Expanded(
                child: Container(height: 3, color: widget.colors.secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLoginUI() {
    return Column(
      children: [
        buildLoginHeader(),
        SizedBox(height: 40),
        buildEmailField(),
        SizedBox(height: 16),
        buildPasswordField(),
        SizedBox(height: 24),
        buildLoginButton(),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Бүртгэл байхгүй бол",
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
                "Бүртгүүлэх",
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
    return buildLoginUI();
  }
}
