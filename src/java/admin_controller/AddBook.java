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

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class AddBook extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIdStr = request.getParameter("categoryId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String quantityInStockStr = request.getParameter("quantityInStock");
        String description = request.getParameter("description");
        Part imagePart = request.getPart("imageURL"); // Assuming the image is uploaded via a file input

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            float price = Float.parseFloat(priceStr);
            int quantityInStock = Integer.parseInt(quantityInStockStr);
            
            Category cat = new CategoryDAO().getCategoryById(categoryId);

            // Save the uploaded image (you need to implement this)
            String imageURL = saveImage(imagePart); // Implement this method to save the image

            // Create a Book object with the form data
            Book newBook = new Book(title, author, description, price, quantityInStock, imageURL, cat);
            // Add the new book to the database
            BookDAO bookDAO = new BookDAO();
            bookDAO.addBook(newBook);
            
            request.getSession().setAttribute("bookList", bookDAO.getAllBooks());
            // Redirect to a success page or display a success message
            response.sendRedirect("administrator/productinsert.jsp");
        } catch (Exception e) {
            // Handle exceptions and display an error message
            e.printStackTrace();
            request.setAttribute("error", "Failed to add the book.");
            // Retrieve categories for redisplaying
            RequestDispatcher dispatcher = request.getRequestDispatcher("administrator/productinsert.jsp"); // Redirect to your add book page
            dispatcher.forward(request, response);
        }
    }
    
    private String saveImage(Part imagePart) {
        String fileName = imagePart.getSubmittedFileName();
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
        }
        return fileName;
    }
    
}
