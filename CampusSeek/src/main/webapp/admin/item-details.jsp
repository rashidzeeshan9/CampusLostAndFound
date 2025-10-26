<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    
    ItemDAO itemDAO = new ItemDAO();
    String itemIdStr = request.getParameter("id");
    Item item = null;
    
    if(itemIdStr != null && !itemIdStr.isEmpty()) {
        try {
            int itemId = Integer.parseInt(itemIdStr);
            item = itemDAO.getItemById(itemId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Details - Admin</title>
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
        .details-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .detail-section {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .label-bold {
            font-weight: bold;
            color: #2C3E50;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="details-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-info-circle me-2"></i>Item Details</h2>
                <a href="view-all-items.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Items
                </a>
            </div>

            <% if(item != null) { %>
                <!-- Item Information -->
                <div class="detail-section">
                    <h5><i class="fas fa-cube me-2"></i>Item Information</h5>
                    <hr>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p><span class="label-bold">Item ID:</span> <%= item.getId() %></p>
                            <p><span class="label-bold">Name:</span> <%= item.getName() %></p>
                            <p><span class="label-bold">Category:</span> <%= item.getCategory() %></p>
                        </div>
                        <div class="col-md-6">
                            <p><span class="label-bold">Type:</span>
                                <% if("LOST".equals(item.getItemType())) { %>
                                    <span class="badge bg-danger">LOST</span>
                                <% } else { %>
                                    <span class="badge bg-success">FOUND</span>
                                <% } %>
                            </p>
                            <p><span class="label-bold">Status:</span> <span class="badge bg-warning"><%= item.getStatus() %></span></p>
                            <p><span class="label-bold">Date:</span> <%= item.getDateLostFound() %></p>
                        </div>
                    </div>
                </div>

                <!-- Location Information -->
                <div class="detail-section">
                    <h5><i class="fas fa-map-marker-alt me-2"></i>Location Information</h5>
                    <hr>
                    <p><span class="label-bold">Location:</span> <%= item.getLocation() %></p>
                </div>

                <!-- Description -->
                <div class="detail-section">
                    <h5><i class="fas fa-align-left me-2"></i>Description</h5>
                    <hr>
                    <p><%= item.getDescription() != null ? item.getDescription() : "No description provided" %></p>
                </div>

                <!-- Contact Information -->
                <div class="detail-section">
                    <h5><i class="fas fa-phone me-2"></i>Contact Information</h5>
                    <hr>
                    <p><span class="label-bold">Contact:</span> <%= item.getContactInfo() %></p>
                </div>

                <!-- Actions -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <a href="view-all-items.jsp" class="btn btn-primary">
                            <i class="fas fa-list me-1"></i>Back to Items
                        </a>
                        <a href="admin-dashboard.jsp" class="btn btn-secondary">
                            <i class="fas fa-home me-1"></i>Dashboard
                        </a>
                    </div>
                </div>

            <% } else { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <strong>Error:</strong> Item not found. Please go back and try again.
                </div>
                <a href="view-all-items.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Items
                </a>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
