<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin</title>
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
        .users-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .user-card {
            border-left: 4px solid #667eea;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            background: #f8f9fa;
            transition: all 0.3s;
        }
        .user-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateX(5px);
        }
        .user-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="users-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-users me-2"></i>Manage Users</h2>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                </a>
            </div>

            <!-- Stats -->
            <div class="alert alert-info mb-4">
                <i class="fas fa-info-circle me-2"></i>
                <strong>User Management:</strong> View all registered users and their details.
            </div>

            <!-- User Features List -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-list fa-2x text-primary mb-2"></i>
                            <h6>View All Users</h6>
                            <p class="text-muted small">See complete user list</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-line fa-2x text-success mb-2"></i>
                            <h6>User Activity</h6>
                            <p class="text-muted small">Track user behavior</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-lock fa-2x text-warning mb-2"></i>
                            <h6>Manage Permissions</h6>
                            <p class="text-muted small">Control access rights</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Coming Soon Message -->
            <div class="alert alert-warning">
                <i class="fas fa-clock me-2"></i>
                <strong>Enhanced features coming soon:</strong>
                <ul class="mb-0 mt-2">
                    <li>Block/Unblock users functionality</li>
                    <li>View detailed user activity logs</li>
                    <li>Manage user roles and permissions</li>
                    <li>Send notifications to users</li>
                </ul>
            </div>

            <!-- Quick Links -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <a href="admin-dashboard.jsp" class="btn btn-primary btn-lg w-100">
                        <i class="fas fa-home me-2"></i>Dashboard
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="reports.jsp" class="btn btn-info btn-lg w-100">
                        <i class="fas fa-chart-bar me-2"></i>View Reports
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
