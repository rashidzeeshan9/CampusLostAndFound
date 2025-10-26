<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    
    ItemDAO itemDAO = new ItemDAO();
    UserDAO userDAO = new UserDAO();
    ClaimDAO claimDAO = new ClaimDAO();
    
    int lostItems = itemDAO.getItemCountByType("LOST");
    int foundItems = itemDAO.getItemCountByType("FOUND");
    int totalItems = lostItems + foundItems;
    int pendingClaims = claimDAO.getPendingClaimsCount();
    int totalUsers = userDAO.getTotalUsersCount();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Admin</title>
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
        .reports-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .stat-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            margin-bottom: 20px;
        }
        .stat-box h3 {
            font-size: 40px;
            font-weight: bold;
            margin: 10px 0;
        }
        .stat-box p {
            margin: 5px 0;
            opacity: 0.9;
        }
        .report-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reports-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-chart-bar me-2"></i>System Reports</h2>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                </a>
            </div>

            <!-- Overall Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-box">
                        <i class="fas fa-users fa-2x mb-3"></i>
                        <h3><%= totalUsers %></h3>
                        <p>Total Users</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <i class="fas fa-list fa-2x mb-3"></i>
                        <h3><%= totalItems %></h3>
                        <p>Total Items Reported</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <i class="fas fa-clock fa-2x mb-3"></i>
                        <h3><%= pendingClaims %></h3>
                        <p>Pending Claims</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <i class="fas fa-check-circle fa-2x mb-3"></i>
                        <h3style="color: #2ecc71;">0</h3>
                        <p>Success Rate</p>
                    </div>
                </div>
            </div>

            <!-- Detailed Reports -->
            <div class="row">
                <div class="col-md-6">
                    <div class="report-section">
                        <h5><i class="fas fa-exclamation-circle me-2"></i>Lost Items Report</h5>
                        <hr>
                        <p><strong>Total Lost Items:</strong> <span class="badge bg-danger"><%= lostItems %></span></p>
                        <p><strong>Category:</strong> Items reported as lost by users</p>
                        <p><strong>Status:</strong> Pending recovery and claims</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="report-section">
                        <h5><i class="fas fa-check-circle me-2"></i>Found Items Report</h5>
                        <hr>
                        <p><strong>Total Found Items:</strong> <span class="badge bg-success"><%= foundItems %></span></p>
                        <p><strong>Category:</strong> Items reported as found by users</p>
                        <p><strong>Status:</strong> Waiting for claims and verification</p>
                    </div>
                </div>
            </div>

            <!-- Claims Report -->
            <div class="report-section mt-4">
                <h5><i class="fas fa-file-contract me-2"></i>Claims Management Report</h5>
                <hr>
                <div class="row">
                    <div class="col-md-4">
                        <p><strong>Pending Claims:</strong></p>
                        <p class="text-muted">Awaiting admin verification</p>
                        <h4 class="text-warning"><%= pendingClaims %></h4>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Action Required:</strong></p>
                        <p class="text-muted">Review and process claims</p>
                        <a href="verify-claims.jsp" class="btn btn-sm btn-warning">
                            <i class="fas fa-tasks me-1"></i>Verify Claims
                        </a>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Last Updated:</strong></p>
                        <p class="text-muted"><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) %></p>
                    </div>
                </div>
            </div>

            <!-- System Summary -->
            <div class="alert alert-info mt-4">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Summary:</strong> The system has <%= totalItems %> items with <%= pendingClaims %> pending claims from <%= totalUsers %> users.
            </div>

            <!-- Quick Links -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <a href="view-all-items.jsp" class="btn btn-primary btn-lg w-100 mb-2">
                        <i class="fas fa-list me-2"></i>View All Items
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="verify-claims.jsp" class="btn btn-warning btn-lg w-100 mb-2">
                        <i class="fas fa-check me-2"></i>Verify Claims
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
