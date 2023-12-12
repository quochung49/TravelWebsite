package controller;

import DAO.UserDAO;
import DAO.UserRoleDAO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.model.UserRole;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.Normalizer;
import java.util.regex.Pattern;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

public class LoginGoogleHandler extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String code = request.getParameter("code");
            String accessToken = getToken(code);
            UserGoogleDto gUser = getUserInfo(accessToken);
            UserDAO userDAO = new UserDAO();
            
            if (userDAO.isEmailRegistered(gUser.getEmail())) {
                User user = userDAO.getUserByEmail(gUser.getEmail());
                user.setPassword("123");
                userDAO.updateUser(user);
                request.getSession().setAttribute("user", user);
                response.sendRedirect("index.jsp");
            } else {
                User user = new User(gUser.getEmail(), gUser.getId(), convertToNonDiacritic(gUser.getGiven_name()), convertToNonDiacritic(gUser.getFamily_name()), "Address", "999999", "City", "Country", "000000000");
                UserRole role = new UserRoleDAO().getRoleById(2);
                user.setRole(role);
                if (userDAO.userRegister(user)) {
                    
                    int uId = userDAO.getUserByEmail(user.getEmail()).getId();
                    user.setId(uId);
                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("index.jsp");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("loginFailMsg", "Login Fail");
            request.getRequestDispatcher("http://localhost:8080/BookStore/validation/login.jsp");
            
        }
        
    }
    
    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();
        
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        
        return accessToken;
    }
    
    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        
        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);
        
        return googlePojo;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private String convertToNonDiacritic(String input) {
        String temp = Normalizer.normalize(input, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        String nonDiacritic = pattern.matcher(temp).replaceAll("");

        // Custom mapping for Vietnamese characters
        nonDiacritic = nonDiacritic
                .replaceAll("Đ", "D")
                .replaceAll("đ", "d")
                .replaceAll("ạ", "a")
                .replaceAll("ả", "a")
                .replaceAll("ấ", "a")
                .replaceAll("ầ", "a")
                .replaceAll("ẩ", "a")
                .replaceAll("ậ", "a")
                .replaceAll("ắ", "a")
                .replaceAll("ằ", "a")
                .replaceAll("ẳ", "a")
                .replaceAll("ặ", "a")
                .replaceAll("ẫ", "a")
                .replaceAll("ã", "a")
                .replaceAll("á", "a")
                .replaceAll("à", "a")
                .replaceAll("ẻ", "e")
                .replaceAll("ẹ", "e")
                .replaceAll("ế", "e")
                .replaceAll("ề", "e")
                .replaceAll("ể", "e")
                .replaceAll("ễ", "e")
                .replaceAll("ề", "e")
                .replaceAll("ế", "e")
                .replaceAll("í", "i")
                .replaceAll("ị", "i")
                .replaceAll("ĩ", "i")
                .replaceAll("ỉ", "i")
                .replaceAll("ó", "o")
                .replaceAll("ò", "o")
                .replaceAll("õ", "o")
                .replaceAll("ỏ", "o")
                .replaceAll("ọ", "o")
                .replaceAll("ố", "o")
                .replaceAll("ồ", "o")
                .replaceAll("ổ", "o")
                .replaceAll("ộ", "o")
                .replaceAll("ơ", "o")
                .replaceAll("ớ", "o")
                .replaceAll("ờ", "o")
                .replaceAll("ỡ", "o")
                .replaceAll("ở", "o")
                .replaceAll("ú", "u")
                .replaceAll("ù", "u")
                .replaceAll("ũ", "u")
                .replaceAll("ủ", "u")
                .replaceAll("ụ", "u")
                .replaceAll("ứ", "u")
                .replaceAll("ừ", "u")
                .replaceAll("ữ", "u")
                .replaceAll("ử", "u")
                .replaceAll("ý", "y")
                .replaceAll("ỳ", "y")
                .replaceAll("ỷ", "y")
                .replaceAll("ỹ", "y")
                .replaceAll("ỵ", "y");
        
        return nonDiacritic;
    }
}
