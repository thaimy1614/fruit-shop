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
import model.Order;
import model.Order;
import model.OrderItem;
import model.OrderItem;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Order> getAllOrderByUser(String user) {
        List<Order> result = new ArrayList<>();
        String query = "SELECT [username], "
                + "[order_id],"
                + "[name],"
                + "[address],"
                + "[phone],"
                + "[total_quantity],"
                + "[total_amount],"
                + "[order_date] ,"
                + "[startus]\n"
                + "      ,[note],[pay]\n"
                + "  FROM [dbo].[Order]"
                + "Where username = ? "
                + "order by order_id desc";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while (rs.next()) {
                //int orderId, String name, String address, String phone, int quantity, float amount, String date, int statu
                result.add(new Order(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getFloat(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getInt(11)));
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

    public List<Order> getAllOrder() {
        List<Order> result = new ArrayList<>();
        String query = "SELECT [username]\n"
                + "      ,[order_id]\n"
                + "	  ,[name]\n"
                + "	  ,[address]\n"
                + "	  ,[phone]\n"
                + "	  ,[total_quantity]\n"
                + "	  ,[total_amount]\n"
                + "      ,[order_date]\n"
                + "      ,[startus]\n"
                + "      ,[note]\n"
                + "      ,[pay]\n"
                + "  FROM [Order]\n"
                + "order by order_id desc";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                //int orderId, String name, String address, String phone, int quantity, float amount, String date, int statu
                result.add(new Order(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getFloat(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getInt(11)));
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

    public boolean setPay(int orderId, int pay) {
        boolean rerult = false;
        String query = "  UPDATE [dbo].[Order]\n"
                + "       SET [pay] = ?\n"
                + "         WHERE [order_id] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, pay);
            ps.setInt(2, orderId);

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

    public List<OrderItem> getAllOrderItemById(int orderId) {
        List<OrderItem> result = new ArrayList<>();
        String query = "SELECT TOP (1000) o.[order_item_id]\n"
                + "      ,o.[order_id]\n"
                + "      ,o.[pId]\n"
                + "      ,o.[quantity],\n"
                + "	  p.[name],\n"
                + "	  p.price,\n"
                + "	  p.img,\n"
                + "	  o.amount\n"
                + "  FROM [dbo].[OrderItem] as o\n"
                + "  join Product as p on p.pId = o.pId\n"
                + "  where order_id = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                //int orderId, String name, String address, String phone, int quantity, float amount, String date, int statu
                result.add(new OrderItem(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getFloat(6),
                        rs.getString(7),
                        rs.getFloat(8)));
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

    public boolean addOrder(String user, String name, String address, String phone, int quantity, float amount, String note, String date, int pay) {

        boolean rerult = false;
        String query = "insert into [Order] (\n"
                + "      [username]\n"
                + "      ,[order_date]\n"
                + "      ,[total_amount]\n"
                + "      ,[total_quantity], [name], [address],[phone],note,[startus],[pay])\n"
                + "	  values (?,CAST(? AS DATE),?,?,?,?,?,?,1,?)";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, date);
            ps.setFloat(3, amount);
            ps.setInt(4, quantity);
            ps.setString(5, name);
            ps.setString(6, address);
            ps.setString(7, phone);
            ps.setString(8, note);
            ps.setInt(9, pay);

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

    public boolean addOrderItem(int pId, int quantity) {
        boolean rerult = false;
        String query = "insert into [dbo].[OrderItem] ([order_id]\n"
                + "      ,[pId]\n"
                + "      ,[quantity],amount)\n"
                + "	   \n"
                + "  values (1,? ,?,1); ";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, pId);
            ps.setInt(2, quantity);
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

    public boolean deleteAllCart(String user) {
        boolean resurl = false;
        String query = "delete from Cart where username = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            int effectRow = ps.executeUpdate();
            if (effectRow > 0) {
                resurl = true;
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
        return resurl;

    }

    public boolean huyOrder(int id) {
        boolean rerult = false;
        String query = "  UPDATE [dbo].[Order]\n"
                + "       SET [startus] = 0\n"
                + "         WHERE [order_id] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);

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

    public boolean xacthucOrder(int id) {
        boolean rerult = false;
        String query = "  UPDATE [dbo].[Order]\n"
                + "       SET [startus] = 2\n"
                + "         WHERE [order_id] = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);

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

    public boolean updateOrder(int orderid, String name, String address, String phone, String note) {
        boolean rerult = false;
        String query = "update [Order] set [name] = ? , \n"
                + "[phone] = ?,\n"
                + "[address] = ?,\n"
                + "[note] = ? \n"
                + "where order_id = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, note);
            ps.setInt(5, orderid);

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

    public int getTotalAmountEachMonth(int month) {
        String query = "SELECT SUM(total_amount) \n"
                + "FROM dbo.[Order] \n"
                + "WHERE MONTH(order_date) = ?;";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Product> topFruits() {
        List<Product> result = new ArrayList<>();
        String query = "SELECT TOP 10\n"
                + "    oi.pId,\n"
                + "	p.img,\n"
                + "    p.name,\n"
                + "	p.price,\n"
                + "	p.quantity,\n"
                + "	p.des,\n"
                + "    COUNT(oi.order_item_id) AS total_sold_out\n"
                + "FROM\n"
                + "    OrderItem oi\n"
                + "JOIN\n"
                + "    Product p ON oi.pId = p.pId\n"
                + "JOIN\n"
                + "    [Order] o ON oi.order_id = o.order_id\n"
                + "WHERE\n"
                + "    o.startus = 1 or o.startus = 2\n"
                + "GROUP BY\n"
                + "    oi.pId,\n"
                + "    p.name,\n"
                + "	p.img,\n"
                + "	p.price,\n"
                + "	p.quantity,\n"
                + "	p.des\n"
                + "ORDER BY\n"
                + "    total_sold_out DESC;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {

                //int pId, String pName, float pPrice, String pimg, String pDes,int quantity, String cname, int cId, int soldout
                result.add(new Product(
                        rs.getInt(1), rs.getString(3), rs.getInt(4), rs.getString(2), rs.getString(6), rs.getInt(5), "", 0, rs.getInt(7)
                ));
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
}
