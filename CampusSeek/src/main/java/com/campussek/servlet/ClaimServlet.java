package com.campussek.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;  // ✅ CHANGED!
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;  // ✅ This includes all jakarta.servlet.http classes

import com.campussek.bean.Claim;
import com.campussek.dao.ClaimDAO;

@WebServlet("/ClaimServlet")
public class ClaimServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClaimDAO claimDAO = new ClaimDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if ("claim".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String claimReason = request.getParameter("claimReason");
            
            // Check if already claimed
            if (claimDAO.hasUserClaimed(itemId, userId)) {
                response.sendRedirect("item-details.jsp?id=" + itemId + "&error=Already claimed!");
                return;
            }
            
            Claim claim = new Claim();
            claim.setItemId(itemId);
            claim.setUserId(userId);
            claim.setClaimReason(claimReason);
            
            if (claimDAO.addClaim(claim)) {
                response.sendRedirect("my-items.jsp?success=Claim submitted successfully!");
            } else {
                response.sendRedirect("item-details.jsp?id=" + itemId + "&error=Failed to submit claim!");
            }
        } else if ("approve".equals(action) || "reject".equals(action)) {
            // Admin actions
            int claimId = Integer.parseInt(request.getParameter("claimId"));
            String remarks = request.getParameter("remarks");
            String status = "approve".equals(action) ? "APPROVED" : "REJECTED";
            
            if (claimDAO.updateClaimStatus(claimId, status, remarks)) {
                response.sendRedirect("admin/verify-claims.jsp?success=Claim " + status.toLowerCase() + "!");
            } else {
                response.sendRedirect("admin/verify-claims.jsp?error=Failed to update claim!");
            }
        }
        
    }
}
