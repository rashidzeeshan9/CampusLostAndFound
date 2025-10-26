package com.campussek.bean;

import java.sql.Timestamp;

public class Claim {
    private int id;
    private int itemId;
    private int userId;
    private String claimReason;
    private String status;            // PENDING, APPROVED, REJECTED
    private String adminRemarks;
    private Timestamp createdAt;      // ← ADD THIS FIELD!
    
    // Default constructor
    public Claim() {}
    
    // Constructor with parameters
    public Claim(int itemId, int userId, String claimReason) {
        this.itemId = itemId;
        this.userId = userId;
        this.claimReason = claimReason;
        this.status = "PENDING";
    }
    
    // ========== GETTERS & SETTERS ==========
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getItemId() {
        return itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getClaimReason() {
        return claimReason;
    }
    
    public void setClaimReason(String claimReason) {
        this.claimReason = claimReason;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getAdminRemarks() {
        return adminRemarks;
    }
    
    public void setAdminRemarks(String adminRemarks) {
        this.adminRemarks = adminRemarks;
    }
    
    // ← ADD THESE NEW METHODS!
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Claim [id=" + id + ", itemId=" + itemId + ", userId=" + userId 
               + ", status=" + status + ", createdAt=" + createdAt + "]";
    }
}
