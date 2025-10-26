<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campussek.bean.*, com.campussek.dao.*" %>
<%
    // Check if admin is logged in
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    
    String adminName = (String) session.getAttribute("adminName");
    String adminEmail = (String) session.getAttribute("adminEmail");
    
    // Get statistics
    ItemDAO itemDAO = new ItemDAO();
    UserDAO userDAO = new UserDAO();
    ClaimDAO claimDAO = new ClaimDAO();
    
    int totalLostItems = itemDAO.getItemCountByType("LOST");
    int totalFoundItems = itemDAO.getItemCountByType("FOUND");
    int pendingClaims = claimDAO.getPendingClaimsCount();
    int totalUsers = userDAO.getTotalUsersCount();
    
    // Get recent items
    List<Item> recentItems = itemDAO.getRecentItems();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CampusSeek</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --sidebar-bg: #1a1d2e;
            --sidebar-hover: #252937;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        /* Sidebar Styling */
        .sidebar {
            background: var(--sidebar-bg);
            min-height: 100vh;
            padding: 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.3);
        }
        
        .sidebar-header {
            padding: 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            text-align: center;
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .sidebar-menu a {
            color: #b8b8b8;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 15px 20px;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }
        
        .sidebar-menu a:hover {
            background: var(--sidebar-hover);
            border-left-color: var(--primary-color);
            color: white;
        }
        
        .sidebar-menu a.active {
            background: var(--sidebar-hover);
            border-left-color: var(--primary-color);
            color: white;
        }
        
        .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
        }
        
        /* Main Content */
        .main-content {
            padding: 30px;
            background: rgba(255,255,255,0.05);
        }
        
        /* Top Bar */
        .top-bar {
            background: white;
            padding: 15px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        /* Stat Cards */
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        
        .stat-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        /* Quick Action Cards */
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
        }
        
        .action-icon {
            font-size: 50px;
            margin-bottom: 20px;
        }
        
        /* Recent Items Table */
        .recent-items {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .table-responsive {
            max-height: 400px;
            overflow-y: auto;
        }
        
        .badge-lost {
            background: #e74c3c;
        }
        
        .badge-found {
            background: #27ae60;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar">
                <div class="sidebar-header">
                    <i class="fas fa-shield-alt fa-2x mb-2"></i>
                    <h5 class="mb-0">CampusSeek</h5>
                    <small>Admin Panel</small>
                </div>
                
                <div class="sidebar-menu">
                    <a href="admin-dashboard.jsp" class="active">
                        <i class="fas fa-home"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="view-all-items.jsp">
                        <i class="fas fa-list"></i>
                        <span>All Items</span>
                    </a>
                    <a href="verify-claims.jsp">
                        <i class="fas fa-check-circle"></i>
                        <span>Verify Claims</span>
                    </a>
                    <a href="manage-users.jsp">
                        <i class="fas fa-users"></i>
                        <span>Manage Users</span>
                    </a>
                    <a href="reports.jsp">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                    <a href="../LogoutServlet" onclick="return confirm('Are you sure you want to logout?')">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 main-content">
                <!-- Top Bar -->
                <div class="top-bar">
                    <div>
                        <h4 class="mb-0">Welcome back, <%= adminName %>!</h4>
                        <small class="text-muted"><i class="fas fa-envelope me-1"></i><%= adminEmail %></small>
                    </div>
                    <div>
                        <span class="badge bg-success me-2">
                            <i class="fas fa-circle me-1"></i>Online
                        </span>
                        <a href="../LogoutServlet" class="btn btn-outline-danger btn-sm">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-card">
                            <div class="stat-icon text-primary">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-number text-primary"><%= totalUsers %></div>
                            <div class="stat-label">Total Users</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card">
                            <div class="stat-icon text-danger">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <div class="stat-number text-danger"><%= totalLostItems %></div>
                            <div class="stat-label">Lost Items</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card">
                            <div class="stat-icon text-success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-number text-success"><%= totalFoundItems %></div>
                            <div class="stat-label">Found Items</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card">
                            <div class="stat-icon text-warning">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-number text-warning"><%= pendingClaims %></div>
                            <div class="stat-label">Pending Claims</div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h5 class="text-white mb-3">
                            <i class="fas fa-bolt me-2"></i>Quick Actions
                        </h5>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="action-card">
                            <div class="action-icon text-primary">
                                <i class="fas fa-list"></i>
                            </div>
                            <h5>View All Items</h5>
                            <p class="text-muted">Browse all reported lost and found items</p>
                            <a href="view-all-items.jsp" class="btn btn-primary">
                                <i class="fas fa-arrow-right me-1"></i>View Items
                            </a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="action-card">
                            <div class="action-icon text-warning">
                                <i class="fas fa-check-double"></i>
                            </div>
                            <h5>Verify Claims</h5>
                            <p class="text-muted">Review and approve pending user claims</p>
                            <a href="verify-claims.jsp" class="btn btn-warning">
                                <i class="fas fa-arrow-right me-1"></i>Verify Claims
                            </a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="action-card">
                            <div class="action-icon text-info">
                                <i class="fas fa-users"></i>
                            </div>
                            <h5>Manage Users</h5>
                            <p class="text-muted">View and manage registered users</p>
                            <a href="manage-users.jsp" class="btn btn-info">
                                <i class="fas fa-arrow-right me-1"></i>Manage Users
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Recent Items -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="recent-items">
                            <h5 class="mb-4">
                                <i class="fas fa-history me-2"></i>Recent Items
                            </h5>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Item Name</th>
                                            <th>Category</th>
                                            <th>Type</th>
                                            <th>Location</th>
                                            <th>Status</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if(recentItems != null && !recentItems.isEmpty()) {
                                            for(Item item : recentItems) { %>
                                            <tr>
                                                <td><%= item.getId() %></td>
                                                <td><%= item.getName() %></td>
                                                <td><%= item.getCategory() %></td>
                                                <td>
                                                    <% if("LOST".equals(item.getItemType())) { %>
                                                        <span class="badge badge-lost">LOST</span>
                                                    <% } else { %>
                                                        <span class="badge badge-found">FOUND</span>
                                                    <% } %>
                                                </td>
                                                <td><%= item.getLocation() %></td>
                                                <td><span class="badge bg-warning"><%= item.getStatus() %></span></td>
                                                <td><%= item.getDateLostFound() %></td>
                                                <td>
                                                    <a href="item-details.jsp?id=<%= item.getId() %>" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        <% }
                                        } else { %>
                                            <tr>
                                                <td colspan="8" class="text-center text-muted">No items found</td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
