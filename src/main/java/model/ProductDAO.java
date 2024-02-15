/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProducts() {
        List<Product> result = new ArrayList<>();
        String query = "SELECT P.[pId], P.[name], P.[price], P.[img], P.[des], P.[quantity], C.[cName], P.cId\n"
                + "                FROM [dbo].[Product] AS P\n"
                + "               INNER JOIN Catelogy AS C ON P.[cId] = C.[cId]\n"
                + "                where [status] = 1"
                + "                 order by pId desc";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8)));
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

    public List<Product> searchProducts(String key) {
        List<Product> result = new ArrayList<>();
        String query = "SELECT P.[pId], P.[name], P.[price], P.[img], P.[des], P.[quantity], C.[cName], P.cId\n"
                + "                FROM [dbo].[Product] AS P\n"
                + "               INNER JOIN Catelogy AS C ON P.[cId] = C.[cId]\n"
                + "                where [status] = 1 and P.[name] like ?"
                + "                 order by pId desc";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + key + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8)));
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

    public List<Product> newProduct() {
        List<Product> result = new ArrayList<>();
        String query = "SELECT TOP 3 P.[pId], P.[name], P.[price], P.[img],P.[des],P.[quantity], C.[cName], P.cId\n"
                + "  FROM [dbo].[Product] AS P\n"
                + " INNER JOIN Catelogy AS C ON P.[cId] = C.[cId]\n"
                + "where [status] = 1\n"
                + "  ORDER BY pId DESC";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8)));
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

    public boolean deleteProduct(String Id) {
        boolean rerult = false;
        String query = "UPDATE [dbo].[Product]\n"
                + "                SET [status] = 0\n"
                + "                WHERE [pId] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, Id);

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

    public boolean createOrder(String name, float price, String img, String des, int cId, int quan) {
        boolean rerult = false;
        String query = " insert into [dbo].[Product] (\n"
                + "      [name]\n"
                + "      ,[price]\n"
                + "      ,[img]\n"
                + "      ,[des]\n"
                + "      ,[cId]\n"
                + "      ,[status]\n"
                + "      ,[quantity])\n"
                + "                 values\n"
                + "                	(?,?,?,?,?,1,?);";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setFloat(2, price);
            ps.setString(3, img);
            ps.setString(4, des);
            ps.setInt(5, cId);
            ps.setInt(6, quan);

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

    public boolean updateOrder(int Id, String name, int price, String img, String des, int cId, int quantity) {
        boolean rerult = false;
        String query = "UPDATE [dbo].[Product]\n"
                + "                SET [name] = ?,\n"
                + "                [price] = ?,\n"
                + "                [img] = ?,\n"
                + "                [des] = ?\n,"
                + "                [cId] = ?, [quantity] = ?"
                + "                WHERE [pId] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setInt(2, price);
            ps.setString(3, img);
            ps.setString(4, des);
            ps.setInt(5, cId);
            ps.setInt(6, quantity);
            ps.setInt(7, Id);
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

    public List<Product> getProductsByPage(int pageNumber, int pageSize, String filter) {
        List<Product> result = new ArrayList<>();
        String sql = "SELECT P.[pId], P.[name], P.[price], P.[img], P.[des], P.[quantity], C.[cName], P.cId\n"
                + "                FROM [dbo].[Product] AS P\n"
                + "               INNER JOIN Catelogy AS C ON P.[cId] = C.[cId]\n"
                + "                where [status] = 1"
                + "                 order by pId desc "
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT ? ROWS ONLY;";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, pageNumber);
            ps.setInt(2, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8)));
            }
            rs.close();
            ps.close();
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

}
