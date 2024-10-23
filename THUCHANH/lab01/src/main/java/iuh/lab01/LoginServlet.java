package iuh.lab01;

import iuh.lab01.beans.LoginBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginBean lg = new LoginBean();
        boolean result = lg.login(username, password);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (result) {
            out.println("<html><body>");
            out.println("<h1>Welcome, " + username + "!</h1>");
            out.println("</body></html>");
        } else {
            out.println("<html><body>");
            out.println("<h1>Login failed!</h1>");
            out.println("</body></html>");
        }
        out.close();
    }
}
