package com.campussek.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.campussek.bean.Claim;

public class ClaimDAO {
    
    // Add new claim
    public boolean addClaim(Claim claim) {
        String sql = "INSERT INTO claims (item_id, user_id, claim_reason, status) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, claim.getItemId());
            pstmt.setInt(2, claim.getUserId());
            pstmt.setString(3, claim.getClaimReason());
            pstmt.setString(4, claim.getStatus() != null ? claim.getStatus() : "PENDING");
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding claim: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get claim by ID
    public Claim getClaimById(int claimId) {
        String sql = "SELECT * FROM claims WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, claimId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractClaimFromResultSet(rs);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting claim by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all pending claims (for admin to verify)
    public List<Claim> getPendingClaims() {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT * FROM claims WHERE status='PENDING' ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                claims.add(extractClaimFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting pending claims: " + e.getMessage());
            e.printStackTrace();
        }
        return claims;
    }
    
    // Get all claims
    public List<Claim> getAllClaims() {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT * FROM claims ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                claims.add(extractClaimFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting all claims: " + e.getMessage());
            e.printStackTrace();
        }
        return claims;
    }
    
    // Get claims by user
    public List<Claim> getClaimsByUser(int userId) {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT * FROM claims WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                claims.add(extractClaimFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting claims by user: " + e.getMessage());
            e.printStackTrace();
        }
        return claims;
    }
    
    // Get claims for item
    public List<Claim> getClaimsByItem(int itemId) {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT * FROM claims WHERE item_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, itemId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                claims.add(extractClaimFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting claims by item: " + e.getMessage());
            e.printStackTrace();
        }
        return claims;
    }
    
    // Update claim status with remarks
    public boolean updateClaimStatus(int claimId, String status, String remarks) {
        String sql = "UPDATE claims SET status = ?, admin_remarks = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, remarks);
            pstmt.setInt(3, claimId);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating claim status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if user already claimed an item
    public boolean hasUserClaimed(int itemId, int userId) {
        String sql = "SELECT COUNT(*) FROM claims WHERE item_id = ? AND user_id = ? AND status != 'REJECTED'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, itemId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error checking user claim: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Get pending claims count (for statistics)
    public int getPendingClaimsCount() {
        String sql = "SELECT COUNT(*) FROM claims WHERE status='PENDING'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting pending claims count: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get approved claims count
    public int getApprovedClaimsCount() {
        String sql = "SELECT COUNT(*) FROM claims WHERE status='APPROVED'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting approved claims count: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get rejected claims count
    public int getRejectedClaimsCount() {
        String sql = "SELECT COUNT(*) FROM claims WHERE status='REJECTED'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting rejected claims count: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Delete claim
    public boolean deleteClaim(int claimId) {
        String sql = "DELETE FROM claims WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, claimId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting claim: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to extract Claim from ResultSet
    private Claim extractClaimFromResultSet(ResultSet rs) throws SQLException {
        Claim claim = new Claim();
        claim.setId(rs.getInt("id"));
        claim.setItemId(rs.getInt("item_id"));
        claim.setUserId(rs.getInt("user_id"));
        claim.setClaimReason(rs.getString("claim_reason"));
        claim.setStatus(rs.getString("status"));
        claim.setAdminRemarks(rs.getString("admin_remarks"));
        claim.setCreatedAt(rs.getTimestamp("created_at"));
        return claim;
    }
}
