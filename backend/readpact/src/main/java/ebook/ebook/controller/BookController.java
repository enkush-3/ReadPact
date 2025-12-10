package ebook.ebook.controller;

import ebook.ebook.model.Book;
import ebook.ebook.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable String id) {
        Optional<Book> book = bookService.getBookById(id);
        return book.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> addBook(
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description,
            @RequestParam("createYear") int createYear,
            @RequestParam("pageCount") int pageCount,
            @RequestParam("rating") double rating,
            @RequestParam("price") double price,
            @RequestParam("category") String category,
            @RequestParam("file") MultipartFile file) {
        try {
            Book book = new Book(title, author, description, createYear, pageCount, rating, price, category, null);
            Book savedBook = bookService.addBook(book, file);
            return ResponseEntity.ok(savedBook);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("Error uploading file: " + e.getMessage());
        }
    }

    @GetMapping("/download/{id}")
    public ResponseEntity<Resource> downloadBook(@PathVariable String id) {
        Optional<Book> bookOptional = bookService.getBookById(id);
        if (bookOptional.isPresent()) {
            Book book = bookOptional.get();
            if (book.getPdfFileName() != null) {
                File file = bookService.getBookPdf(book.getPdfFileName());
                if (file.exists()) {
                    Resource resource = new FileSystemResource(file);
                    return ResponseEntity.ok()
                            .contentType(MediaType.APPLICATION_PDF)
                            .header(HttpHeaders.CONTENT_DISPOSITION,
                                    "attachment; filename=\"" + book.getPdfFileName() + "\"")
                            .body(resource);
                }
            }
        }
        return ResponseEntity.notFound().build();
    }
}
