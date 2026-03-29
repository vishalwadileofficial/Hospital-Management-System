package com.hospital.util;

import javax.servlet.http.HttpSession;

/**
 * SessionValidator - Utility class to validate user sessions
 */
public class SessionValidator {
    
    /**
     * Check if user is logged in
     * @param session HttpSession object
     * @return true if logged in
     */
    public static boolean isUserLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("userId") != null;
    }
    
    /**
     * Check if admin is logged in
     * @param session HttpSession object
     * @return true if admin logged in
     */
    public static boolean isAdminLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("adminId") != null;
    }
    
    /**
     * Get logged in user ID
     * @param session HttpSession object
     * @return User ID or -1 if not logged in
     */
    public static int getLoggedInUserId(HttpSession session) {
        if (isUserLoggedIn(session)) {
            return (int) session.getAttribute("userId");
        }
        return -1;
    }
    
    /**
     * Get logged in user name
     * @param session HttpSession object
     * @return User name or empty string
     */
    public static String getLoggedInUserName(HttpSession session) {
        if (isUserLoggedIn(session)) {
            Object name = session.getAttribute("userName");
            return name != null ? name.toString() : "";
        }
        return "";
    }
}