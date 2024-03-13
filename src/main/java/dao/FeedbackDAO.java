/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Message;

/**
 *
 * @author Duong Quoc Thai CE171563
 */
public class FeedbackDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Message> getAllMessagesSortedByNewest() {
        List<Message> result = new ArrayList<>();

        try {
            conn = DBConnect.getConnection();
            String query = "SELECT * FROM Feedback ORDER BY date_message DESC";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                // Get the Timestamp values from the ResultSet
                LocalDateTime dateMessage = rs.getTimestamp(5).toLocalDateTime();
                LocalDateTime dateResponse = null;
                if (rs.getTimestamp(6) != null) {
                    dateResponse = rs.getTimestamp(6).toLocalDateTime();
                }

                result.add(new Message(rs.getInt(7),
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        dateMessage,
                        dateResponse
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }

        return result;
    }

    public List<Message> getAllMessagesSortedByOldest() {
        List<Message> result = new ArrayList<>();

        try {
            conn = DBConnect.getConnection();
            String query = "SELECT * FROM Feedback ORDER BY date_message ASC";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                // Get the Timestamp values from the ResultSet
                LocalDateTime dateMessage = rs.getTimestamp(5).toLocalDateTime();
                LocalDateTime dateResponse = null;
                if (rs.getTimestamp(6) != null) {
                    dateResponse = rs.getTimestamp(6).toLocalDateTime();
                }

                result.add(new Message(rs.getInt(7),
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        dateMessage,
                        dateResponse
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return result;
    }

    public List<Message> getAllMessage() {
        List<Message> result = new ArrayList<>();
        String query = "SELECT * FROM Feedback";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Get the Timestamp values from the ResultSet
                LocalDateTime dateMessage = rs.getTimestamp(5).toLocalDateTime();
                LocalDateTime dateResponse = null;
                if (rs.getTimestamp(6) != null) {
                    dateResponse = rs.getTimestamp(6).toLocalDateTime();
                }

                result.add(new Message(rs.getInt(7),
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        dateMessage,
                        dateResponse
                ));
            }
        } catch (Exception e) {
            // Handle or log the exception appropriately
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }

        return result;
    }

    public boolean sendFeedback(String username, String message, String img, LocalDateTime date) {
        boolean result = false;
        String query = "INSERT INTO Feedback (username, message, img, date_message) VALUES (?, ?, ?, ?)";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, message);
            ps.setString(3, img);
            ps.setTimestamp(4, Timestamp.valueOf(date));

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                result = true;
            }
        } catch (Exception e) {
            // Handle or log the exception appropriately
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return result;
    }

    public boolean sendResponse(int responseTo, String response, LocalDateTime dateResponse) {
        boolean result = false;
        String query = "UPDATE Feedback\n"
                + "SET response = ?, date_response = ?\n"
                + "WHERE id = ?;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(3, responseTo);
            ps.setString(1, response);;
            ps.setTimestamp(2, Timestamp.valueOf(dateResponse));

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                result = true;
            }
        } catch (Exception e) {
            // Handle or log the exception appropriately
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return result;
    }

}
