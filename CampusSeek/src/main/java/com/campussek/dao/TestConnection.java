
package com.campussek.dao;

public class TestConnection {
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        java.sql.Connection conn = DatabaseConnection.getConnection();
        
        if (conn != null) {
            System.out.println("✅ SUCCESS! Database connected!");
            try {
                conn.close();
                System.out.println("✅ Connection closed successfully");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ FAILED! Database connection is null");
        }
    }
}
