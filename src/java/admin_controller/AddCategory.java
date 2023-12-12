package admin_controller;

import entity.model.Category;
import DAO.CategoryDAO;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddCategory extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the category name from the form
        String categoryName = request.getParameter("name");

        // Get the category ID from the URL
        int categoryId = Integer.parseInt(request.getParameter("id"));

        // Create a new category with the specified ID
        Category category = new Category(categoryId, categoryName);

        // Add the category to the database
        CategoryDAO categoryDAO = new CategoryDAO();
        categoryDAO.addCategory(category);
        request.getSession().setAttribute("categories", new CategoryDAO().getAllCategories());

        // Redirect to the category listing page or display a success message
        response.sendRedirect("administrator/productinsert.jsp");
    }
}
