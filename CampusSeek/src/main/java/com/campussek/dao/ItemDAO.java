package com.campussek.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.campussek.bean.Item;

public class ItemDAO {
    
    // Add new item (for Report Lost or Found)
    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (name, category, description, location, date_lost_found, " +
                     "item_type, status, user_id, contact_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, item.getName());
            pstmt.setString(2, item.getCategory());
            pstmt.setString(3, item.getDescription());
            pstmt.setString(4, item.getLocation());
            pstmt.setDate(5, item.getDateLostFound());
            pstmt.setString(6, item.getItemType());
            pstmt.setString(7, item.getStatus() != null ? item.getStatus() : "PENDING");
            pstmt.setInt(8, item.getUserId());
            pstmt.setString(9, item.getContactInfo());
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding item: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get item by ID
    public Item getItemById(int itemId) {
        String sql = "SELECT * FROM items WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, itemId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting item by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Get items by user ID
    public List<Item> getItemsByUser(int userId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting items by user: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Search items by keyword and optionally by type
    public List<Item> searchItems(String keyword, String type) {
        List<Item> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM items WHERE (name LIKE ? OR description LIKE ? OR category LIKE ? OR location LIKE ?)"
        );
        
        if (type != null && !type.trim().isEmpty()) {
            sql.append(" AND item_type = ?");
        }
        
        sql.append(" ORDER BY created_at DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            pstmt.setString(4, searchPattern);
            
            if (type != null && !type.trim().isEmpty()) {
                pstmt.setString(5, type);
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error searching items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Get items by type (LOST or FOUND)
    public List<Item> getItemsByType(String type) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE item_type = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, type);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting items by type: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Get all items
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY created_at DESC LIMIT 100";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting all items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Update item status
    public boolean updateItemStatus(int itemId, String status) {
        String sql = "UPDATE items SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, itemId);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating item status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete item
    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, itemId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting item: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get recent items (last 10)
    public List<Item> getRecentItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY created_at DESC LIMIT 10";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting recent items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Get total count of items by type
    public int getItemCountByType(String type) {
        String sql = "SELECT COUNT(*) FROM items WHERE item_type = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, type);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting item count: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get items by category
    public List<Item> getItemsByCategory(String category) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE category = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            rs.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting items by category: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    // Helper method to extract Item from ResultSet
    private Item extractItemFromResultSet(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setCategory(rs.getString("category"));
        item.setDescription(rs.getString("description"));
        item.setLocation(rs.getString("location"));
        item.setDateLostFound(rs.getDate("date_lost_found"));
        item.setItemType(rs.getString("item_type"));
        item.setStatus(rs.getString("status"));
        item.setUserId(rs.getInt("user_id"));
        item.setContactInfo(rs.getString("contact_info"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        return item;
    }
}
