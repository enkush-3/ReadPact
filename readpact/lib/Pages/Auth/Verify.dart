import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Service/theme_service.dart';

class VerifyPage extends StatefulWidget {
  final AppColors colors;
  const VerifyPage({super.key, required this.colors});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isVerified = false;
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  Widget buildAppTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Read",
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: widget.colors.text,
          ),
        ),
        SizedBox(width: 4),
        Text(
          "Pact",
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: widget.colors.primary,
          ),
        ),
      ],
    );
  }

  Widget buildOtpBox(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: widget.colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.colors.text, width: 1.5),
      ),
      child: TextField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: widget.colors.text,
        ),
        decoration: InputDecoration(counterText: "", border: InputBorder.none),
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  Widget buildVerifyUI() {
    return Column(
      children: [
        Text(
          "Баталгаажуулах",
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.colors.text,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Таны и-мэйл хаяг руу баталгаажуулах код илгээсэн. Кодоо оруулна уу.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: widget.colors.text.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) => buildOtpBox(index)),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 320,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              backgroundColor: widget.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              setState(() {
                isVerified = true;
              });
            },
            child: Text(
              "Баталгаажуулах",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Код дахин илгээлээ")));
          },
          child: Text(
            "Дахин илгээх",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildVerifiedUI() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.colors.primary.withValues(alpha: 0.1),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 60,
            color: widget.colors.primary,
          ),
        ),
        SizedBox(height: 24),
        Text(
          "Амжилттай!",
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.colors.text,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Таны бүртгэл амжилттай баталгаажлаа.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: widget.colors.text.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 320,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              backgroundColor: widget.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              // Navigate to Home or Login
              Navigator.pop(context); // For now pop back to Auth
            },
            child: Text(
              "Үргэлжлүүлэх",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: widget.colors.text),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 40),
              buildAppTitle(),
              SizedBox(height: 80),
              isVerified ? buildVerifiedUI() : buildVerifyUI(),
            ],
          ),
        ),
      ),
    );
  }
}
