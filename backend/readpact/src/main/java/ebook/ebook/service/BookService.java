package ebook.ebook.service;

import ebook.ebook.model.Book;
import ebook.ebook.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    private final String UPLOAD_DIR = "uploads/";

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Optional<Book> getBookById(String id) {
        return bookRepository.findById(id);
    }

    public Book addBook(Book book, MultipartFile pdfFile) throws IOException {
        if (pdfFile != null && !pdfFile.isEmpty()) {
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = UUID.randomUUID().toString() + "_" + pdfFile.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR + fileName);
            Files.write(filePath, pdfFile.getBytes());
            book.setPdfFileName(fileName);
        }
        return bookRepository.save(book);
    }

    public File getBookPdf(String fileName) {
        return new File(UPLOAD_DIR + fileName);
    }
}
