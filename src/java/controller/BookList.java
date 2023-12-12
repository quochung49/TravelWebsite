package controller;

import DAO.BookDAO;
import DAO.CategoryDAO;
import entity.model.Book;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;

public class BookList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pageSize = 4;
        int pageIndex;
        String pageIndexParam = request.getParameter("pageIndex");

        if (pageIndexParam != null && !pageIndexParam.isEmpty()) {
            pageIndex = Integer.parseInt(pageIndexParam);
        } else {
            // Default to page 1 if pageIndex parameter is not provided
            pageIndex = 1;
        }

        BookDAO dao = new BookDAO();
        CategoryDAO catDAO = new CategoryDAO();

        // Calculate the total number of records
        int totalRecords = dao.getAllBooks().size();

        // Calculate the total number of pages
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Query the database for the data
        List<Book> bookList = dao.getBooksByPage(pageSize, pageIndex);

        // Set the data and pagination information in request attributes
        request.getSession().setAttribute("categories", catDAO.getAllCategories());
        request.setAttribute("bookList", bookList);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        // Forward the request to the JSP page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Create an instance of the BookDAO
        BookDAO bookDAO = new BookDAO();

        // Fetch the list of books using the BookDAO
        List<Book> bookList = bookDAO.getAllBooks();

        // Set the bookList in the session
        HttpSession session = request.getSession();
        session.setAttribute("bookList", bookList);

        // Forward the request to the JSP page
        response.sendRedirect("index.jsp");
    }

}
