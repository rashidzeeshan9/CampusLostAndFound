<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Found Item - CampusSeek</title>
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
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-lg">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0"><i class="fas fa-check-circle me-2"></i>Report Found Item</h4>
                    </div>
                    <div class="card-body p-4">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>

                        <form action="ReportFoundServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label">Item Name *</label>
                                <input type="text" class="form-control" name="name" 
                                       placeholder="e.g., Black Backpack, Student ID" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Category *</label>
                                <select class="form-select" name="category" required>
                                    <option value="">Select Category</option>
                                    <option value="ID Card">ID Card</option>
                                    <option value="Electronics">Electronics</option>
                                    <option value="Books">Books</option>
                                    <option value="Accessories">Accessories</option>
                                    <option value="Clothing">Clothing</option>
                                    <option value="Keys">Keys</option>
                                    <option value="Wallet">Wallet</option>
                                    <option value="Bag">Bag</option>
                                    <option value="Others">Others</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="3" 
                                          placeholder="Provide detailed description of the found item..."></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Location Found *</label>
                                    <input type="text" class="form-control" name="location" 
                                           placeholder="e.g., Parking Lot, Classroom" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Date Found *</label>
                                    <input type="date" class="form-control" name="dateLostFound" 
                                           max="<%= java.time.LocalDate.now() %>" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Contact Information *</label>
                                <input type="text" class="form-control" name="contactInfo" 
                                       placeholder="Phone number or email" required>
                            </div>

                            <button type="submit" class="btn btn-success btn-lg w-100">
                                <i class="fas fa-paper-plane me-2"></i>Report Found Item
                            </button>

                            <div class="text-center mt-3">
                                <a href="dashboard.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
