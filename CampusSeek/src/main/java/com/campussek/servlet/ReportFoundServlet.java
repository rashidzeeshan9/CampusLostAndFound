package com.campussek.servlet;

import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;                   // ✅ CHANGE THIS
import jakarta.servlet.annotation.WebServlet;             // ✅ CHANGE THIS
import jakarta.servlet.http.HttpServlet;                  // ✅ CHANGE THIS
import jakarta.servlet.http.HttpServletRequest;           // ✅ CHANGE THIS
import jakarta.servlet.http.HttpServletResponse;          // ✅ CHANGE THIS
import jakarta.servlet.http.HttpSession;                  // ✅ CHANGE THIS

import com.campussek.bean.Item;
import com.campussek.dao.ItemDAO;

@WebServlet("/ReportFoundServlet")
public class ReportFoundServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemDAO itemDAO = new ItemDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String dateStr = request.getParameter("dateLostFound");
        String contactInfo = request.getParameter("contactInfo");
        
        Item item = new Item();
        item.setName(name);
        item.setCategory(category);
        item.setDescription(description);
        item.setLocation(location);
        item.setDateLostFound(Date.valueOf(dateStr));
        item.setItemType("FOUND");
        item.setUserId(userId);
        item.setContactInfo(contactInfo);
        
        if (itemDAO.addItem(item)) {
            response.sendRedirect("my-items.jsp?success=Found item reported successfully!");
        } else {
            request.setAttribute("error", "Failed to report item. Please try again.");
            request.getRequestDispatcher("report-found.jsp").forward(request, response);
        }
    }
}
