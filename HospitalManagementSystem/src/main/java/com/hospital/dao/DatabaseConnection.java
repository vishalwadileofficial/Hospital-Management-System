package com.hospital.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Class
 * This class manages connection to MySQL database
 */
public class DatabaseConnection {
    
    // Database credentials (CHANGE THESE according to your MySQL setup)
    private static final String URL = "jdbc:mysql://localhost:3306/hospital_management_system";
    private static final String USERNAME = "root";  // Your MySQL username
    private static final String PASSWORD = "Vishal@789.";      // Your MySQL password
    
    // JDBC Driver
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    /**
     * Get database connection
     * @return Connection object
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName(DRIVER);
            
            // Establish connection
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection to database failed!");
            e.printStackTrace();
        }
        
        return connection;
    }
    
    /**
     * Close database connection
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.out.println("DATABASE ERROR:");
                e.printStackTrace();
            }

        }
    }
}