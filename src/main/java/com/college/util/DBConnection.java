package com.college.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Simple JDBC connection helper.
 * Edit DB_URL / DB_USER / DB_PASSWORD to match your local MySQL setup.
 */
public class DBConnection {

    private static final String DB_URL =
            "DB-URL";
    private static final String DB_USER = "DB-USER";
    private static final String DB_PASSWORD = "DB-PASSWORD";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
