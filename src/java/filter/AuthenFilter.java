package filter;

import entity.model.Cart;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.user.User;

public class AuthenFilter implements Filter {

    private static final String LOGIN_PAGE = "validation/login.jsp";
    private static final String ACCESS_DENIED = "error/access_denied.jsp";

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    public AuthenFilter() {
        // Add admin & User action to the list
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String uri = req.getRequestURI();
            System.out.println(uri);

            if (res.getStatus() == HttpServletResponse.SC_NOT_FOUND) {
                res.sendRedirect("http://localhost:8080/Assignment/error/404.jsp"); // Redirect to the custom error page
                return;
            }

            int index = uri.lastIndexOf("/");
            String source = uri.substring(index + 1);
            if (source.equals("")) {
                if (uri.contains("/administrator/") || uri.contains("/customer/")) {
                    res.sendRedirect("profile.jsp");
                } else {
                    res.sendRedirect("http://localhost:8080/Assignment/index.jsp");
                }

            }
            HttpSession session = req.getSession();

            User user = (User) session.getAttribute("user");
            if (source.equals("index.jsp")) {
                chain.doFilter(request, response);
                return;
            }

            if (uri.contains("/cart/")
                    || uri.contains("/administrator/")
                    || uri.contains("/customer/")) {
                if (user == null) {
                    res.sendRedirect("../" + LOGIN_PAGE);
                } else {
                    if (uri.contains("/administrator/") && user.getRole().getId() == 1) {
                        chain.doFilter(request, response);
                    } else if (uri.contains("/customer/") && user.getRole().getId() == 2) {
                        chain.doFilter(request, response);
                    } else if (uri.contains("/cart/")) {
                        chain.doFilter(request, response);

                    } else {
                        req.setAttribute("accessError", "You don't have permission to access this page.");
                        req.getRequestDispatcher("../" + ACCESS_DENIED).forward(request, response);
                    }
                }
            } else {
                chain.doFilter(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
