package admin_controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import entity.model.Book;
import DAO.BookDAO;
import DAO.CategoryDAO;
import entity.model.Category;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class UpdateBook extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");
        String categoryIdStr = request.getParameter("categoryId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String quantityInStockStr = request.getParameter("quantity");
        String description = request.getParameter("description");
        Part imagePart = request.getPart("imageURL"); // Assuming the image is uploaded via a file input
        String imageURL = saveImage(imagePart); // Implement this method to save the image

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            float price = Float.parseFloat(priceStr);
            int quantityInStock = Integer.parseInt(quantityInStockStr);

            Category cat = new CategoryDAO().getCategoryById(categoryId);

            // Create a Book object with the form data
            // Add the new book to the database
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId);

            book.setTitle(title);
            book.setAuthor(author);
            book.setCategory(cat);
            book.setDescription(description);
            book.setPrice(price);
            book.setQuantityInStock(quantityInStock);

            if (!imageURL.equals("")) {
                // Save the uploaded image (you need to implement this)
                book.setImageURL(imageURL);
            }

            bookDAO.updateBook(book);

            List<Book> bookList = bookDAO.getAllBooks();

            // Set the bookList in the session
            HttpSession session = request.getSession();
            session.setAttribute("bookList", bookList);
            // Redirect to a success page or display a success message
            response.sendRedirect("administrator/product.jsp");
        } catch (Exception e) {
            // Handle exceptions and display an error message
            e.printStackTrace();
            request.setAttribute("error", "Failed to update the book.");
            // Retrieve categories for redisplaying
            RequestDispatcher dispatcher = request.getRequestDispatcher("administrator/product.jsp"); // Redirect to your add book page
            dispatcher.forward(request, response);
        }
    }

    private String saveImage(Part imagePart) {
        String fileName = "";
        if (imagePart != null) {
            fileName = imagePart.getSubmittedFileName();
            if (!fileName.equals("")) {
                try {

                    String path = getServletContext().getRealPath("") + "assets\\books";
                    File file = new File(path);
                    if (!file.exists()) {
                        file.mkdirs(); // Create the directory if it doesn't exist
                    }
                    imagePart.write("D:\\Java_code\\BookStore\\web\\assets\\books" + File.separator + fileName);
                    imagePart.write(path + File.separator + fileName);
                } catch (IOException ex) {
                    ex.printStackTrace();
                    return "";
                }
            }
        }
        return fileName;
    }

}
