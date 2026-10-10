package com.campusconnect.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Centralized JDBC Database Connection Manager for CampusConnect.
 * 
 * Edit DB_URL, DB_USER, and DB_PASSWORD below or in db.properties if needed.
 */
public class DBConnection {

    // Central MySQL Configuration Parameters
    private static String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static String DB_URL = "jdbc:mysql://localhost:3306/campusconnect_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&createDatabaseIfNotExist=true";
    private static String DB_USER = "root";
    private static String DB_PASSWORD = "alihusain@123"; // Updated MySQL root password

    static {
        try {
            // Load db.properties dynamically if available
            InputStream inputStream = DBConnection.class.getClassLoader().getResourceAsStream("db.properties");
            if (inputStream != null) {
                Properties prop = new Properties();
                prop.load(inputStream);
                if (prop.getProperty("jdbc.driver") != null) DB_DRIVER = prop.getProperty("jdbc.driver");
                if (prop.getProperty("jdbc.url") != null) DB_URL = prop.getProperty("jdbc.url");
                if (prop.getProperty("jdbc.username") != null) DB_USER = prop.getProperty("jdbc.username");
                if (prop.getProperty("jdbc.password") != null) DB_PASSWORD = prop.getProperty("jdbc.password");
            }
            Class.forName(DB_DRIVER);
        } catch (Exception e) {
            System.err.println("Error initializing JDBC Driver: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Creates and returns a fresh JDBC Connection instance.
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
