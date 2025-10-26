package com.campussek.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campussek.bean.Item;
import com.campussek.dao.ItemDAO;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemDAO itemDAO = new ItemDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        
        System.out.println("Search request - Keyword: " + keyword + ", Type: " + type);
        
        List<Item> items;
        
        try {
            if(keyword != null && !keyword.trim().isEmpty()) {
                // Search by keyword
                items = itemDAO.searchItems(keyword, type);
            } else if(type != null && !type.trim().isEmpty()) {
                // Filter by type only
                items = itemDAO.getItemsByType(type);
            } else {
                // Get all items
                items = itemDAO.getAllItems();
            }
            
            System.out.println("Found " + (items != null ? items.size() : 0) + " items");
            
            request.setAttribute("items", items);
            request.setAttribute("keyword", keyword);
            request.setAttribute("type", type);
            
            request.getRequestDispatcher("search-items.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in SearchServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading items: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
