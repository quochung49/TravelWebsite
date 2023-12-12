package controller;

import DAO.OrderDetailDAO;
import com.google.gson.Gson;
import entity.model.OrderDetail;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the orderId parameter from the request
        String orderId = request.getParameter("orderId");

        // Fetch the OrderDetail based on orderId (implement your logic)
        OrderDetail orderDetail = new OrderDetailDAO().getOrderDetailByOrderId(Integer.parseInt(orderId));

        // Convert the orderDetail to JSON
        String orderDetailJson = new Gson().toJson(orderDetail);

        // Set the response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Send the JSON response back to the client
        response.getWriter().write(orderDetailJson);
    }
}
