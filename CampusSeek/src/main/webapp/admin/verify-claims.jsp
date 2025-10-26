<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    
    ClaimDAO claimDAO = new ClaimDAO();
    ItemDAO itemDAO = new ItemDAO();
    UserDAO userDAO = new UserDAO();
    
    List<Claim> claims = claimDAO.getAllClaims();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify Claims - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #E74C3C;">
        <div class="container">
            <a class="navbar-brand fw-bold" href="admin-dashboard.jsp">
                <i class="fas fa-user-shield me-2"></i>CampusSeek Admin
            </a>
            <div class="navbar-nav ms-auto">
                <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                <a href="../LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <h2 class="mb-4"><i class="fas fa-check-double me-2"></i>Verify Claims</h2>

        <% if(request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i><%= request.getParameter("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if(claims != null && !claims.isEmpty()) { %>
            <% for(Claim claim : claims) { 
                Item item = itemDAO.getItemById(claim.getItemId());
                User user = userDAO.getUserById(claim.getUserId());
                
                String statusClass = "APPROVED".equals(claim.getStatus()) ? "bg-success" : 
                                   "REJECTED".equals(claim.getStatus()) ? "bg-danger" : "bg-warning";
            %>
                <div class="card shadow-sm mb-3">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Claim #<%= claim.getId() %></h5>
                            <span class="badge <%= statusClass %>"><%= claim.getStatus() %></span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Item:</strong> <%= item != null ? item.getName() : "N/A" %></p>
                                <p><strong>Category:</strong> <%= item != null ? item.getCategory() : "N/A" %></p>
                                <p><strong>Claimant:</strong> <%= user != null ? user.getName() : "N/A" %></p>
                                <p><strong>Email:</strong> <%= user != null ? user.getEmail() : "N/A" %></p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Claim Reason:</strong></p>
                                <p class="bg-light p-2 rounded"><%= claim.getClaimReason() %></p>
                            </div>
                        </div>

                        <% if("PENDING".equals(claim.getStatus())) { %>
                            <hr>
                            <form action="../ClaimServlet" method="post" class="row g-2">
                                <input type="hidden" name="claimId" value="<%= claim.getId() %>">
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="remarks" 
                                           placeholder="Admin remarks..." required>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" name="action" value="approve" 
                                            class="btn btn-success w-100">
                                        <i class="fas fa-check me-1"></i>Approve
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" name="action" value="reject" 
                                            class="btn btn-danger w-100">
                                        <i class="fas fa-times me-1"></i>Reject
                                    </button>
                                </div>
                            </form>
                        <% } else { %>
                            <div class="mt-2">
                                <p class="mb-0"><strong>Admin Remarks:</strong> 
                                   <%= claim.getAdminRemarks() != null ? claim.getAdminRemarks() : "-" %></p>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <div class="alert alert-info text-center">
                <i class="fas fa-info-circle me-2"></i>No claims to display.
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
