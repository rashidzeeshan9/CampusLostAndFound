<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    
    ItemDAO itemDAO = new ItemDAO();
    String filterType = request.getParameter("type");
    
    List<Item> items;
    if(filterType != null && !filterType.isEmpty()) {
        items = itemDAO.getItemsByType(filterType);
    } else {
        items = itemDAO.getAllItems();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Items - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            padding: 30px;
        }
        .items-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .filter-buttons {
            margin-bottom: 20px;
        }
        .item-card {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            transition: transform 0.2s;
        }
        .item-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="items-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-list me-2"></i>All Reported Items</h2>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                </a>
            </div>

            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <a href="view-all-items.jsp" class="btn btn-outline-primary <%= filterType == null ? "active" : "" %>">
                    All Items
                </a>
                <a href="view-all-items.jsp?type=LOST" class="btn btn-outline-danger <%= "LOST".equals(filterType) ? "active" : "" %>">
                    Lost Items
                </a>
                <a href="view-all-items.jsp?type=FOUND" class="btn btn-outline-success <%= "FOUND".equals(filterType) ? "active" : "" %>">
                    Found Items
                </a>
            </div>

            <!-- Items List -->
            <% if(items != null && !items.isEmpty()) {
                for(Item item : items) { %>
                <div class="item-card">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5><%= item.getName() %></h5>
                            <p class="mb-1"><strong>Category:</strong> <%= item.getCategory() %></p>
                            <p class="mb-1"><strong>Location:</strong> <%= item.getLocation() %></p>
                            <p class="mb-0"><strong>Date:</strong> <%= item.getDateLostFound() %></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <% if("LOST".equals(item.getItemType())) { %>
                                <span class="badge bg-danger mb-2">LOST</span>
                            <% } else { %>
                                <span class="badge bg-success mb-2">FOUND</span>
                            <% } %>
                            <br>
                            <span class="badge bg-warning mb-2"><%= item.getStatus() %></span>
                            <br>
                            <a href="item-details.jsp?id=<%= item.getId() %>" class="btn btn-sm btn-primary mt-2">
                                <i class="fas fa-eye me-1"></i>View Details
                            </a>
                        </div>
                    </div>
                </div>
            <% }
            } else { %>
                <div class="alert alert-info text-center">
                    <i class="fas fa-info-circle me-2"></i>No items found
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
