/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookDAO;
import DAO.CategoryDAO;
import entity.model.Book;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author FPT
 */
public class BookListCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pageSizeCat = 4;
        int pageIndexCat;
        int categoryId = Integer.parseInt(request.getParameter("catId"));
        String pageIndexParam = request.getParameter("pageIndexCat");

        if (pageIndexParam != null && !pageIndexParam.isEmpty()) {
            pageIndexCat = Integer.parseInt(pageIndexParam);
        } else {
            // Default to page 1 if pageIndex parameter is not provided
            pageIndexCat = 1;
        }

        BookDAO dao = new BookDAO();
        CategoryDAO catDAO = new CategoryDAO();

        // Calculate the total number of records
        int totalRecords = dao.getBooksByCatId(categoryId).size();

        // Calculate the total number of pages
        int totalPagesCat = (int) Math.ceil((double) totalRecords / pageSizeCat);

        // Query the database for the data
        List<Book> bookListCat = dao.getBooksByPageAndCatID(pageSizeCat, pageIndexCat, categoryId);
        // Set the data and pagination information in request attributes
        request.setAttribute("catName", catDAO.getCategoryById(categoryId).getName());
        request.setAttribute("categoriesCat", catDAO.getAllCategories());
        request.setAttribute("bookListCat", bookListCat);
        request.setAttribute("pageIndexCat", pageIndexCat);
        request.setAttribute("pageSizeCat", pageSizeCat);
        request.setAttribute("totalPagesCat", totalPagesCat);

        // Forward the request to the JSP page
        request.getRequestDispatcher("book_list_category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
