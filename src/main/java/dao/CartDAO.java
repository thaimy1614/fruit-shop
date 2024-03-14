/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Cart;

/**
 *
 * @author ADMIN
 */
public class CartDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Cart> getAllCart(String user) {
        List<Cart> result = new ArrayList<>();
        String query = "SELECT p.pId, p.name, p.price, p.img, c.quantity, c.total_quantity\n"
                + "FROM Cart AS c\n"
                + "INNER JOIN Product AS p ON c.pId = p.pId\n"
                + "WHERE c.username = ? AND p.status = 1;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Cart(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getFloat(6)));
            }
        } catch (Exception e) {
            System.out.println(e);
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

    public boolean createCart(String user, int pId, int quantity) {
        boolean rerult = false;
        String query = "MERGE INTO Cart AS target\n"
                + "USING (SELECT ? AS username, ? AS pId) AS source\n"
                + "ON target.username = source.username AND target.pId = source.pId\n"
                + "WHEN MATCHED THEN\n"
                + "    UPDATE SET target.quantity = target.quantity + ?\n"
                + "WHEN NOT MATCHED THEN\n"
                + "    INSERT (username, pId, quantity, total_quantity)\n"
                + "    VALUES (source.username, source.pId, ?, 1);";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setInt(2, pId);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                rerult = true;
            }
        } catch (Exception e) {
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
        return rerult;

    }

    public boolean deleteCart(int Id, String user) {
        boolean rerult = false;
        String query = "DELETE FROM [Cart] WHERE pId = ? AND username = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, Id);
            ps.setString(2, user);

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                rerult = true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        return rerult;
    }

    public boolean updateCart(int proId, String user, int quan) {
        boolean rerult = false;
        String query = "update Cart set quantity = ? where username = ? and pId = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, quan);
            ps.setString(2, user);
            ps.setInt(3, proId);

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                rerult = true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        return rerult;
    }
    public int countItemsInCart(String username){
        int count = 0;
        String query = "select count(*) as recordCount from Cart where username = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);

            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("recordCount");
            }
            return count;
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        return count;
    }
}
