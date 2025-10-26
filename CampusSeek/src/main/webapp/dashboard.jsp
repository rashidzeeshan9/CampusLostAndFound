<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.campussek.bean.Item" %>
<%
    // Check if user is logged in
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - CampusSeek</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .dashboard-container {
            padding: 40px 0;
        }
        .welcome-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            margin-bottom: 30px;
        }
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: transform 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 100%;
        }
        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        .action-icon {
            font-size: 50px;
            margin-bottom: 20px;
        }
        .navbar {
            background-color: #2C3E50;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="fas fa-search me-2"></i>CampusSeek
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="search-items.jsp">
                            <i class="fas fa-search"></i> Search Items
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="my-items.jsp">
                            <i class="fas fa-list"></i> My Items
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> <%= userName %>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container dashboard-container">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <h2>Welcome back, <%= userName %>! 👋</h2>
            <p class="text-muted mb-0">
                <i class="fas fa-envelope me-2"></i><%= userEmail %>
            </p>
            <p class="text-muted">What would you like to do today?</p>
        </div>

        <!-- Action Cards -->
        <div class="row g-4">
            <!-- Report Lost Item -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-danger">
                        <i class="fas fa-exclamation-circle"></i>
                    </div>
                    <h4>Report Lost Item</h4>
                    <p class="text-muted">Lost something? Report it here and we'll help you find it.</p>
                    <a href="report-lost.jsp" class="btn btn-danger btn-lg mt-3">
                        <i class="fas fa-plus me-2"></i>Report Lost
                    </a>
                </div>
            </div>

            <!-- Report Found Item -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-success">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h4>Report Found Item</h4>
                    <p class="text-muted">Found something? Help return it to its owner.</p>
                    <a href="report-found.jsp" class="btn btn-success btn-lg mt-3">
                        <i class="fas fa-plus me-2"></i>Report Found
                    </a>
                </div>
            </div>

            <!-- Search Items -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-primary">
                        <i class="fas fa-search"></i>
                    </div>
                    <h4>Search Items</h4>
                    <p class="text-muted">Browse all lost and found items on campus.</p>
                    <a href="search-items.jsp" class="btn btn-primary btn-lg mt-3">
                        <i class="fas fa-search me-2"></i>Search Now
                    </a>
                </div>
            </div>

            <!-- My Items -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-info">
                        <i class="fas fa-list"></i>
                    </div>
                    <h4>My Items</h4>
                    <p class="text-muted">View your reported items and claims.</p>
                    <a href="my-items.jsp" class="btn btn-info btn-lg mt-3">
                        <i class="fas fa-list me-2"></i>View My Items
                    </a>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-warning">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h4>Recent Activity</h4>
                    <p class="text-muted">Check recent lost and found reports.</p>
                    <a href="SearchServlet" class="btn btn-warning btn-lg mt-3">
                        <i class="fas fa-clock me-2"></i>View Activity
                    </a>
                </div>
            </div>

            <!-- Help & Support -->
            <div class="col-md-4">
                <div class="action-card">
                    <div class="action-icon text-secondary">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h4>Help Support</h4>
                    <p class="text-muted">Need help? Contact campus security.</p>
                    <a href="#" class="btn btn-secondary btn-lg mt-3">
                        <i class="fas fa-question-circle me-2"></i>Get Help
                    </a>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="welcome-card mt-4">
            <h4 class="mb-4"><i class="fas fa-chart-bar me-2"></i>Quick Statistics</h4>
            <div class="row text-center">
                <div class="col-md-3">
                    <h2 class="text-danger">0</h2>
                    <p class="text-muted">Items You Reported</p>
                </div>
                <div class="col-md-3">
                    <h2 class="text-success">0</h2>
                    <p class="text-muted">Active Claims</p>
                </div>
                <div class="col-md-3">
                    <h2 class="text-primary">0</h2>
                    <p class="text-muted">Items Found</p>
                </div>
                <div class="col-md-3">
                    <h2 class="text-info">0</h2>
                    <p class="text-muted">Total Items</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
