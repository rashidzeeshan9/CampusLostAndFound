package com.campussek.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campussek.bean.User;
import com.campussek.dao.UserDAO;

@WebServlet("/AdminLoginServlet")  // ✅ MUST HAVE THIS!
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        User admin = userDAO.adminLogin(email, password);
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminId", admin.getId());
            session.setAttribute("adminName", admin.getName());
            session.setAttribute("role", "ADMIN");
            
            response.sendRedirect("admin/admin-dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid admin credentials!");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
