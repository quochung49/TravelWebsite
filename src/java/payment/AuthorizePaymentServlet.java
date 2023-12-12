package payment;

import com.paypal.base.rest.PayPalRESTException;
import entity.model.Cart;
import entity.model.Item;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import entity.model.OrderDetail;
import java.util.List;

public class AuthorizePaymentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cart cart = (Cart) request.getSession().getAttribute("cart");
       
        List<Item> items = cart.getItems();
        
        OrderDetail orderDetail = new OrderDetail(items);
        
        try {
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(orderDetail);
            response.sendRedirect(approvalLink);
        } catch (PayPalRESTException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Order Details incorrect");
            request.getRequestDispatcher("cart/error.jsp").forward(request, response);
        }
        
    }
    
}
