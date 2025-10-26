package com.campussek.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    
    // Database credentials - CHANGE PASSWORD!
    private static final String URL = "jdbc:mysql://localhost:3306/campusseek?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "athan907";  // ⚠️ PUT YOUR MYSQL PASSWORD HERE!
    
    // Get database connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Create connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            
            if (conn != null) {
                System.out.println("✅ Database connected: " + URL);
            }
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL Driver not found!");
            System.err.println("Make sure mysql-connector JAR is in classpath");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Database connection FAILED!");
            System.err.println("URL: " + URL);
            System.err.println("USER: " + USER);
            System.err.println("PASSWORD: " + (PASSWORD.isEmpty() ? "(empty)" : "(is set)"));
            System.err.println("Error: " + e.getMessage());
            System.err.println("\nCheck:");
            System.err.println("1. Is MySQL running? (services.msc)");
            System.err.println("2. Is password correct?");
            System.err.println("3. Does database 'campusseek' exist?");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Test connection
    public static void main(String[] args) {
        System.out.println("=== Testing Database Connection ===");
        System.out.println("URL: " + URL);
        System.out.println("USER: " + USER);
        System.out.println("PASSWORD: " + (PASSWORD.isEmpty() ? "(empty)" : "(set)"));
        System.out.println("---");
        
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("\n✅✅✅ SUCCESS! Database is working!");
            try {
                conn.close();
                System.out.println("Connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("\n❌❌❌ FAILED! Fix the issues above!");
        }
    }
}
