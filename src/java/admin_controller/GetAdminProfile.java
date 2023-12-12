/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import DAO.BookDAO;
import DAO.OrderDAO;
import DAO.UserDAO;
import entity.model.Order;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author FPT
 */
public class GetAdminProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        BookDAO bookDAO = new BookDAO();
        UserDAO userDAO = new UserDAO();

        int userId = ((User) request.getSession().getAttribute("user")).getId();

        List<Order> orders = orderDAO.getTodayOrders();
        int totalOrders = orderDAO.getTotalOrders();
        int totalBooks = bookDAO.getTotalBooks();
        int totalUsers = userDAO.getTotalUsers();
        int lowBooks = bookDAO.getLowQuantityBooks(7);

        
        
        List<User> users = userDAO.getAllUsers();
        request.getSession().setAttribute("allOrders", orderDAO.getAllOrders());
        request.getSession().setAttribute("users", users);
        request.getSession().setAttribute("totalOrders", totalOrders);
        request.getSession().setAttribute("totalBooks", totalBooks);
        request.getSession().setAttribute("totalUsers", totalUsers);
        request.getSession().setAttribute("lowBooks", lowBooks);
        request.getSession().setAttribute("orders", orders);

        response.sendRedirect("administrator/profile.jsp");
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
