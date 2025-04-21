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
        try (InputStream input = DatabaseUtil.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to find database.properties");
                // Set default values for XAMPP MySQL
                url = "jdbc:mysql://localhost:3306/supermarket_management_system";
                username = "root";
                password = "";
            } else {
                properties.load(input);
                url = properties.getProperty("db.url", "jdbc:mysql://localhost:3306/supermarket_management_system");
                username = properties.getProperty("db.username", "root");
                password = properties.getProperty("db.password", "");
            }
            
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.severe("Error loading database configuration: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            LOGGER.severe("Error connecting to database: " + e.getMessage());
            throw e;
        }
    }
}