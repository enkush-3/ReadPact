import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// ====================================================================
// 📁 ASSETS-ААС PDF-ИЙГ ТҮР ЗУУРЫН ФАЙЛ РУУ ХУУЛАХ ФУНКЦ
// ====================================================================

Future<String> _copyAssetFile(String assetPath) async {
  // Апп-ын түр хавтасны замыг олж байна
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;
  final String filename = assetPath.split('/').last;
  final File file = File('$tempPath/$filename');

  // Хэрвээ өмнө нь хуулсан бол дахин хуулахгүйгээр шууд замыг буцаана
  if (await file.exists()) {
    return file.path;
  }

  // Assets-аас byte-аар уншиж, түр зуурын файл руу хуулах
  final ByteData data = await rootBundle.load(assetPath);
  final List<int> bytes = data.buffer.asUint8List();
  await file.writeAsBytes(bytes, flush: true);

  return file.path;
}

// ====================================================================
// 🚀 APP-ИЙГ ЭХЛҮҮЛЭХ ХЭСЭГ
// ====================================================================

void main() {
  // Flutter Widgets-ийг ашиглахын өмнө service-үүдийг идэвхжүүлэх
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Reader App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // PDF Reader дэлгэцийг үндсэн Home дэлгэц болгов
      home: const PdfReaderScreen(
        pdfAssetPath:
            'assets/books/sample.pdf', // ⬅️ ЭНД ТАНЫ ФАЙЛЫН ЗӨВ ЗАМ БАЙХ ЁСТОЙ
        bookTitle: "Шидэт Мухлаг",
      ),
    );
  }
}

// ====================================================================
// 📖 PDF READER ДЭЛГЭЦ (ХУУДАС БҮРЭЭР ХАРУУЛАХ)
// ====================================================================

class PdfReaderScreen extends StatefulWidget {
  final String pdfAssetPath;
  final String bookTitle;

  const PdfReaderScreen({
    super.key,
    required this.pdfAssetPath,
    this.bookTitle = "Номын Нэр",
  });

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  String? _localPdfPath;
  int _totalPages = 0;
  int _currentPage = 0;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    // Дэлгэц ачаалагдах үед PDF файлыг ачаалахыг дуудна
    _loadPdfAsset();
  }

  void _loadPdfAsset() async {
    try {
      String path = await _copyAssetFile(widget.pdfAssetPath);
      setState(() {
        _localPdfPath = path;
      });
    } catch (e) {
      print("PDF Ачаалах Алдаа: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.bookTitle,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            // Хуудасны дугаарыг харуулах
            if (_isReady && _localPdfPath != null)
              Text(
                "Хуудас: ${_currentPage + 1} / $_totalPages", // 0-өөс эхэлдэг тул +1
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
          ],
        ),
      ),
      body: _localPdfPath == null
          ? const Center(child: CircularProgressIndicator()) // Ачааллаж байна
          : PDFView(
              filePath: _localPdfPath!,
              enableSwipe: true,
              swipeHorizontal: false, // Босоо чиглэлд гүйлгэхээр тохируулсан
              pageFling: true,
              pageSnap: true,
              // PDF нийт хуудас тоог авах
              onRender: (pages) {
                setState(() {
                  _totalPages = pages!;
                  _isReady = true;
                });
              },
              // Хуудас солигдоход дуудагдах
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page!;
                });
              },
            ),
    );
  }
}
