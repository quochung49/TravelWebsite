/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package user_controller;

import DAO.OrderDAO;
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
public class GetUserProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDAO orderDAO = new OrderDAO();
        int userId = ((User) request.getSession().getAttribute("user")).getId();
        List<Order> totalorders = orderDAO.getOrdersByUserId(userId);
        List<Order> orders = orderDAO.getTodayOrdersByUserId(userId);

        request.getSession().setAttribute("totalOrdersUser", totalorders);
        request.getSession().setAttribute("ordersUser", orders);
        
        response.sendRedirect("customer/profile.jsp");

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
