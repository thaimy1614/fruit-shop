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
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class CategoryDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Category> getAllCategories() {
        List<Category> result = new ArrayList<>();
        String query = "SELECT * FROM Category";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Category(rs.getInt(1), rs.getString(2)));
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

    public List<Category> searchCategory(String key) {
        List<Category> result = new ArrayList<>();
        String query = "SELECT * FROM Category WHERE cName like ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + key + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Category(rs.getInt(1), rs.getString(2)));
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

    public boolean deleteCategory(int Id) {
        boolean rerult = false;
        String query = "Delete Category\n"
                + "where cId = ?;";
        String query1 = "Delete Product\n"
                + "where cId = ?;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query1);
            ps.setInt(1, Id);
            int effectRow = ps.executeUpdate();
            
            ps = conn.prepareStatement(query);
            ps.setInt(1, Id);

            effectRow = ps.executeUpdate();

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

    public boolean createCategory(int id, String name) {
        boolean rerult = false;
        String query = "insert into Category(cId, cName) values (?, ?)";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.setString(2, name);

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

    public boolean updateCategory(int Id, String name) {
        boolean rerult = false;
        String query = "UPDATE [dbo].[Category]\n"
                + "                SET [cName] = ?\n"
                + "                WHERE [cId] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setInt(2, Id);
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

    public int selectMaxId() {
        int result = 0;
        String query = "Select max(cId) from Category";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
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
        return result;
    }

}
