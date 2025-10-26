<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.campussek.bean.Item" %>
<%
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
List<Item> items = (List<Item>) request.getAttribute("items");

String keyword = (String) request.getAttribute("keyword");
    String type = (String) request.getAttribute("type");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Items - CampusSeek</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #2C3E50;">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="fas fa-search-location me-2"></i>CampusSeek
            </a>
            <div class="navbar-nav ms-auto">
                <a href="dashboard.jsp" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                <a href="my-items.jsp" class="btn btn-outline-light btn-sm me-2">My Items</a>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <h2 class="mb-4"><i class="fas fa-search me-2"></i>Search Lost & Found Items</h2>

        <!-- Search Form -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <form action="SearchServlet" method="get" class="row g-3">
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="keyword" 
                               placeholder="Search by keyword..." value="<%= keyword != null ? keyword : "" %>">
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="type">
                            <option value="">All Types</option>
                            <option value="LOST" <%= "LOST".equals(type) ? "selected" : "" %>>Lost Items</option>
                            <option value="FOUND" <%= "FOUND".equals(type) ? "selected" : "" %>>Found Items</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-2"></i>Search
                        </button>
                    </div>
                    <div class="col-md-2">
                        <a href="SearchServlet" class="btn btn-secondary w-100">Clear</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Results -->
        <div class="row">
            <% 
            if(items != null && !items.isEmpty()) {
                for(Item item : items) {
                    String badgeClass = "LOST".equals(item.getItemType()) ? "bg-danger" : "bg-success";
            %>
                <div class="col-md-6 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h5 class="card-title"><%= item.getName() %></h5>
                                <span class="badge <%= badgeClass %>"><%= item.getItemType() %></span>
                            </div>
                            <p class="text-muted mb-2">
                                <i class="fas fa-tag me-2"></i><%= item.getCategory() %>
                            </p>
                            <p class="card-text"><%= item.getDescription() != null ? item.getDescription() : "No description" %></p>
                            <div class="mb-2">
                                <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                                <strong>Location:</strong> <%= item.getLocation() %>
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-calendar me-2 text-primary"></i>
                                <strong>Date:</strong> <%= item.getDateLostFound() %>
                            </div>
                            <a href="item-details.jsp?id=<%= item.getId() %>" class="btn btn-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>View Details
                            </a>
                        </div>
                    </div>
                </div>
            <% 
                }
            } else {
            %>
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        <i class="fas fa-info-circle me-2"></i>No items found. Try different search criteria.
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
