package com.supermarket.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseUtil.class.getName());
    private static final Properties properties = new Properties();
    private static String url;
    private static String username;
    private static String password;

    static {
        try {
            // Try to load the properties file
            InputStream input = DatabaseUtil.class.getClassLoader().getResourceAsStream("database.properties");
            if (input == null) {
                LOGGER.severe("Unable to find database.properties in classpath");
                // Set default values for XAMPP MySQL
                url = "jdbc:mysql://localhost:3306/supermarket_management_system?useSSL=false&serverTimezone=UTC";
                username = "root";
                password = "";
                LOGGER.info("Using default database configuration");
            } else {
                properties.load(input);
                url = properties.getProperty("db.url", "jdbc:mysql://localhost:3306/supermarket_management_system?useSSL=false&serverTimezone=UTC");
                username = properties.getProperty("db.username", "root");
                password = properties.getProperty("db.password", "");
                LOGGER.info("Loaded database configuration from properties file");
            }
            
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.info("MySQL JDBC Driver loaded successfully");
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.severe("Error loading database configuration: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            LOGGER.info("Attempting to connect to database with URL: " + url);
            Connection conn = DriverManager.getConnection(url, username, password);
            LOGGER.info("Successfully connected to database");
            return conn;
        } catch (SQLException e) {
            LOGGER.severe("Error connecting to database: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}