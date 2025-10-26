package com.campussek.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campussek.bean.User;
import com.campussek.dao.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String universityId = request.getParameter("universityId");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        
        System.out.println("Registration attempt for: " + email);
        
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        User user = new User(name, email, universityId, password, phoneNumber);
        
        if (userDAO.registerUser(user)) {
            System.out.println("Registration successful for: " + email);
            response.sendRedirect("login.jsp?success=Registration successful! Please login.");
        } else {
            System.out.println("Registration failed for: " + email);
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
