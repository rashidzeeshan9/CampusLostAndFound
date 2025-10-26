<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.campussek.bean.Item, com.campussek.bean.Claim, com.campussek.dao.*" %>
<%
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int userId = (int) session.getAttribute("userId");
    ItemDAO itemDAO = new ItemDAO();
    ClaimDAO claimDAO = new ClaimDAO();
    
    List<Item> myItems = itemDAO.getItemsByUser(userId);
    List<Claim> myClaims = claimDAO.getClaimsByUser(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Items - CampusSeek</title>
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
                <a href="SearchServlet" class="btn btn-outline-light btn-sm me-2">Search</a>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <h2 class="mb-4"><i class="fas fa-list me-2"></i>My Items $ Claims</h2>

        <% if(request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i><%= request.getParameter("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- My Reported Items -->
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>My Reported Items</h5>
            </div>
            <div class="card-body">
                <% if(myItems != null && !myItems.isEmpty()) { %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Category</th>
                                    <th>Type</th>
                                    <th>Location</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(Item item : myItems) { 
                                    String badgeClass = "LOST".equals(item.getItemType()) ? "bg-danger" : "bg-success";
                                %>
                                    <tr>
                                        <td><strong><%= item.getName() %></strong></td>
                                        <td><%= item.getCategory() %></td>
                                        <td><span class="badge <%= badgeClass %>"><%= item.getItemType() %></span></td>
                                        <td><%= item.getLocation() %></td>
                                        <td><%= item.getDateLostFound() %></td>
                                        <td><span class="badge bg-warning"><%= item.getStatus() %></span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <p class="text-muted text-center mb-0">You haven't reported any items yet.</p>
                <% } %>
            </div>
        </div>

        <!-- My Claims -->
        <div class="card shadow-sm">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0"><i class="fas fa-hand-paper me-2"></i>My Claims</h5>
            </div>
            <div class="card-body">
                <% if(myClaims != null && !myClaims.isEmpty()) { 
                    ItemDAO itemDAO2 = new ItemDAO();
                %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Item ID</th>
                                    <th>Claim Reason</th>
                                    <th>Status</th>
                                    <th>Admin Remarks</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(Claim claim : myClaims) { 
                                    String statusClass = "APPROVED".equals(claim.getStatus()) ? "bg-success" : 
                                                       "REJECTED".equals(claim.getStatus()) ? "bg-danger" : "bg-warning";
                                %>
                                    <tr>
                                        <td>#<%= claim.getItemId() %></td>
                                        <td><%= claim.getClaimReason() %></td>
                                        <td><span class="badge <%= statusClass %>"><%= claim.getStatus() %></span></td>
                                        <td><%= claim.getAdminRemarks() != null ? claim.getAdminRemarks() : "-" %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <p class="text-muted text-center mb-0">You haven't submitted any claims yet.</p>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>