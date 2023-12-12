package controller;

import DAO.UserDAO;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Login extends HttpServlet {

    private static final String ENCRYPTION_KEY = "oAw0SYadOXTFfE7sI38a8Qq8z90YOWr8";
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO(); // Initialize the UserDAO in the servlet's init method
    }

    private String encryptAES(String value) {
        try {
            SecretKeySpec key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, key);

            byte[] encryptedBytes = cipher.doFinal(value.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("validation/login.jsp");
                
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String rememberMe = request.getParameter("rememberMe");
            User user = userDAO.login(email, password);

            HttpSession session = request.getSession();
            if (user != null) {
                session.setAttribute("user", user);

                if (rememberMe != null && rememberMe.equals("on")) {
                    String encryptedEmail = encryptAES(email);
                    String encryptedPassword = encryptAES(password);

                    // Set the encrypted values in cookies
                    Cookie emailCookie = new Cookie("rememberedEmail", encryptedEmail);
                    Cookie passwordCookie = new Cookie("rememberedPassword", encryptedPassword);

                    // Set cookies to expire after a week (in seconds)
                    emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                    passwordCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days

                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }

                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                session.setAttribute("loginFailMsg", "Invalid email or password");
                response.sendRedirect("validation/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("loginFailMsg", "Login Fail");
            response.sendRedirect("validation/login.jsp");
        }
    }
}
