<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campussek.bean.Item, com.campussek.dao.ItemDAO, com.campussek.dao.ClaimDAO" %>
<%
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int userId = (int) session.getAttribute("userId");
    int itemId = Integer.parseInt(request.getParameter("id"));
    
    ItemDAO itemDAO = new ItemDAO();
    ClaimDAO claimDAO = new ClaimDAO();
    Item item = itemDAO.getItemById(itemId);
    
    boolean alreadyClaimed = claimDAO.hasUserClaimed(itemId, userId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Details - CampusSeek</title>
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
        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-2"></i><%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <% if(item != null) { 
                    String badgeClass = "LOST".equals(item.getItemType()) ? "bg-danger" : "bg-success";
                %>
                    <div class="card shadow-lg">
                        <div class="card-header <%= "LOST".equals(item.getItemType()) ? "bg-danger" : "bg-success" %> text-white">
                            <h4 class="mb-0"><i class="fas fa-info-circle me-2"></i>Item Details</h4>
                        </div>
                        <div class="card-body p-4">
                            <div class="mb-4">
                                <h3><%= item.getName() %>
                                    <span class="badge <%= badgeClass %> ms-2"><%= item.getItemType() %></span>
                                </h3>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-tag me-2 text-primary"></i>Category:</strong> 
                                       <%= item.getCategory() %></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-info me-2 text-primary"></i>Status:</strong> 
                                       <span class="badge bg-warning"><%= item.getStatus() %></span></p>
                                </div>
                            </div>

                            <div class="mb-3">
                                <p><strong><i class="fas fa-align-left me-2 text-primary"></i>Description:</strong></p>
                                <p class="bg-light p-3 rounded"><%= item.getDescription() != null ? item.getDescription() : "No description provided" %></p>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-map-marker-alt me-2 text-primary"></i>Location:</strong> 
                                       <%= item.getLocation() %></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-calendar me-2 text-primary"></i>Date:</strong> 
                                       <%= item.getDateLostFound() %></p>
                                </div>
                            </div>

                            <div class="mb-4">
                                <p><strong><i class="fas fa-phone me-2 text-primary"></i>Contact:</strong> 
                                   <%= item.getContactInfo() %></p>
                            </div>

                            <% if(item.getUserId() != userId && "FOUND".equals(item.getItemType())) { %>
                                <% if(alreadyClaimed) { %>
                                    <div class="alert alert-info">
                                        <i class="fas fa-check-circle me-2"></i>You have already claimed this item. 
                                        Check My Items page for claim status.
                                    </div>
                                <% } else { %>
                                    <button type="button" class="btn btn-primary btn-lg w-100" data-bs-toggle="modal" data-bs-target="#claimModal">
                                        <i class="fas fa-hand-paper me-2"></i>Claim This Item
                                    </button>
                                <% } %>
                            <% } %>

                            <div class="mt-3">
                                <a href="SearchServlet" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Search
                                </a>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    <div class="alert alert-danger">Item not found!</div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Claim Modal -->
    <div class="modal fade" id="claimModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Claim This Item</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="ClaimServlet" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="itemId" value="<%= itemId %>">
                        <input type="hidden" name="action" value="claim">
                        
                        <div class="mb-3">
                            <label class="form-label">Why is this your item? *</label>
                            <textarea class="form-control" name="claimReason" rows="4" 
                                      placeholder="Provide proof of ownership..." required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Submit Claim</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
