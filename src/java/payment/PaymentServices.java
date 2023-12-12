package payment;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;

import com.paypal.base.rest.PayPalRESTException;
import entity.model.Book;
import entity.model.OrderDetail;
import java.util.ArrayList;
import java.util.List;


public class PaymentServices {

    private static final String CLIENT_ID = "AWRiRn1v1KzbV5bQvUHkUDSB3-wiHn8lyIZtqM2ztPStnWLpRikino8oM952Oo6UxJT92SV31ciN_xT_";
    private static final String CLIENT_SECRET = "EMTHp1dyPQKIDlhCelcwa4STcalvm97yZ77AJUMk9RJLZAxhFYcu9JSEL3nOWUrPLHYM6Ca30hKPm9SU";
    private static final String MODE = "sandbox";

    public String authorizePayment(OrderDetail orderDetail) throws PayPalRESTException {
        Payer payer = getPayerInfo();
        RedirectUrls redirectUrls = getRedirectUrls();
        List<Transaction> listTransaction = getTransactionInfo(orderDetail);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction)
                .setRedirectUrls(redirectUrls)
                .setPayer(payer)
                .setIntent("authorize");

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment approvedPayment = requestPayment.create(apiContext);
        return getApprovalLink(approvedPayment);
    }

    private String getApprovalLink(Payment payment) {
        List<Links> links = payment.getLinks();
        String approvalLink = "";
        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();

            }
        }
        return approvalLink;
    }

    private List<Transaction> getTransactionInfo(OrderDetail orderDetail) {
        Amount amount = new Amount();
        amount.setCurrency("USD");

        // Calculate subtotal as the sum of item prices
        float subtotal = 0.0f;

        Transaction transaction = new Transaction();
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
        StringBuilder description = new StringBuilder();

        for (entity.model.Item item : orderDetail.getItems()) {
            Book book = item.getBook();
            int quantity = item.getQuantity();
            float itemPrice = book.getPrice() * quantity;

            subtotal += itemPrice;

            Item orderItem = new Item();
            orderItem.setCurrency("USD")
                    .setName(book.getTitle()) // Assuming a getTitle() method on your Book class
                    .setPrice(String.format("%.2f", book.getPrice())) // Assuming a getPrice() method on your Book class
                    .setQuantity(String.valueOf(quantity));
            items.add(orderItem);

            // Append each product's name to the description
            description.append(book.getTitle()).append(" x ").append(quantity).append(", ");
        }

        // Remove the trailing comma and space from the description
        if (description.length() > 2) {
            description.setLength(description.length() - 2);
        }

        // Set the calculated subtotal in details
        Details details = new Details();
        details.setSubtotal(String.format("%.2f", subtotal));

        // Calculate the total by adding the subtotal to the shipping cost, if any
        float total = subtotal + orderDetail.getShipping(); // Assuming a getShippingCost() method

        amount.setTotal(String.format("%.2f", total));
        amount.setDetails(details);

        // Set the description
        transaction.setDescription(description.toString());

        transaction.setAmount(amount);
        itemList.setItems(items);
        transaction.setItemList(itemList);

        List<Transaction> listTransactions = new ArrayList<>();
        listTransactions.add(transaction);

        return listTransactions;
    }

    private RedirectUrls getRedirectUrls() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/Assignment/cart/cancel.jsp");
        redirectUrls.setReturnUrl("http://localhost:8080/Assignment/review_payment");
        return redirectUrls;
    }

    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }

    public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);
        Payment payment = new Payment().setId(paymentId);
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return payment.execute(apiContext, paymentExecution);
    }

    private Payer getPayerInfo() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        PayerInfo payerInfo = new PayerInfo();
        payer.setPayerInfo(payerInfo);
        return payer;
    }

}
