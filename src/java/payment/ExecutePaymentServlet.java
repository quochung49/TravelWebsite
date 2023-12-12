package payment;

import DAO.BookDAO;
import DAO.OrderDAO;
import DAO.OrderDetailDAO;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import entity.model.Book;
import entity.model.Cart;
import entity.model.Item;
import entity.model.Order;
import entity.model.OrderDetail;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.Date;

public class ExecutePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        User user = (User) request.getSession().getAttribute("user");
        Cart cart = (Cart) request.getSession().getAttribute("cart");

        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);

            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);

            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);

            //TODO: store Order & Order Details to the database
            Order order = new Order(user.getId(), cart.getDescription(), "Paid", cart.getTotalAmount(), new Date(System.currentTimeMillis()));
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.createOrder(order);

            OrderDetail orderDetail = new OrderDetail(cart.getItems());
            orderDetail.setOrderId(order.getOrderId());
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            orderDetailDAO.createOrderDetails(orderDetail);
            BookDAO bookDAO = new BookDAO();
            for (Item item : cart.getItems()) {
                Book book = bookDAO.getBookById(item.getBook().getId());
                book.setQuantityInStock(book.getQuantityInStock() - item.getQuantity());
                bookDAO.updateBook(book);
            }

            request.getSession().removeAttribute("cart");
            request.getSession().setAttribute("successpayment", "Order Placed Successfully");

            BookDAO bd = new BookDAO();
            request.getSession().setAttribute("bookList", bd.getAllBooks());

            response.sendRedirect("cart/receipt.jsp");
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMsg", "Coud not execute payment");
            request.getRequestDispatcher("cart/error.jsp").forward(request, response);
        }
    }
}
