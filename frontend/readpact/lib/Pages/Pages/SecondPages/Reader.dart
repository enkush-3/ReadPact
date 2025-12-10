import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// PDF файлын байршлыг assets-аас түр зуурын файл руу хуулдаг функц.
// PDFView нь зөвхөн орон нутгийн (local) файлын зам шаарддаг тул энэ үйлдэл хэрэгтэй.
Future<String> _copyAssetFile(String assetPath) async {
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;
  final String filename = assetPath.split('/').last;
  final File file = File('$tempPath/$filename');

  if (await file.exists()) {
    return file.path;
  }

  // Asset-аас byte-аар уншиж, түр зуурын файл руу хуулах
  final ByteData data = await rootBundle.load(assetPath);
  final List<int> bytes = data.buffer.asUint8List();
  await file.writeAsBytes(bytes, flush: true);

  return file.path;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Зөвхөн PDF Reader дэлгэцийг Home болгож тохируулав
      home: const PdfReaderScreen(
        pdfAssetPath: 'assets/books/sample.pdf', // Таны PDF-ийн зам
        bookTitle: "Шидэт Мухлаг", // Номын нэр
      ),
    );
  }
}

// ====================================================================
// 📖 PDF READER ДЭЛГЭЦ
// ====================================================================

class PdfReaderScreen extends StatefulWidget {
  final String pdfAssetPath; // Assets доторх зам
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
    _loadPdfAsset();
  }

  // Asset-аас PDF-ийг ачаалах функц
  void _loadPdfAsset() async {
    try {
      String path = await _copyAssetFile(widget.pdfAssetPath);
      setState(() {
        _localPdfPath = path;
      });
    } catch (e) {
      print("PDF Ачаалах Алдаа: $e");
      // Хэрэглэгчид алдааг мэдэгдэх нэмэлт логик энд бичигдэнэ.
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
            if (_isReady && _localPdfPath != null)
              Text(
                "Хуудас: ${_currentPage + 1} / $_totalPages",
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
              swipeHorizontal: false, // Босоо чиглэлд гүйлгэх
              autoSpacing: true,
              pageFling: true,
              pageSnap: true,
              onRender: (pages) {
                setState(() {
                  _totalPages = pages!;
                  _isReady = true;
                });
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page!;
                });
              },
              onError: (error) {
                print("PDF View Error: $error");
              },
            ),
    );
  }
}
