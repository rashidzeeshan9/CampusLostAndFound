package com.campussek.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;  // ✅ CHANGED!
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;  // ✅ This is correct - includes HttpServlet, HttpServletRequest, HttpServletResponse, HttpSession

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect("login.jsp?logout=You have been logged out successfully.");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
