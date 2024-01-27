/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import connect.DBConnect;

/**
 *
 * @author ADMIN
 */
public class Users {

    private String user;
    private String password;
    private String fullname;
    private String mail;
    private int isAdmin;
    private int isCus;
    private String phone;
    private String address;

    public Users(String user, String password) {
        this.user = user;
        this.password = password;
    }

    public Users() {
    }

    public Users(String user, String password, String fullname, String mail, int isAdmin, int isCus, String phone, String address) {
        this.user = user;
        this.password = password;
        this.fullname = fullname;
        this.mail = mail;
        this.isAdmin = isAdmin;
        this.isCus = isCus;
        this.phone = phone;
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public int getIsCus() {
        return isCus;
    }

    public void setIsCus(int isCus) {
        this.isCus = isCus;
    }

    private String md5(String passwordToHash) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(passwordToHash.getBytes());

            // Convert the byte array to a hexadecimal string
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            // Handle the exception
            return null;
        }

    }

    public boolean isValid() {
        Connection conn = null;
        CallableStatement callableStatement = null;
        Boolean loginState = false;

        try {
            conn = DBConnect.getConnection();
            callableStatement = conn.prepareCall("{call CheckLogin(?, ?)}");
            callableStatement.setString(1, this.user);
            callableStatement.setString(2, md5(this.password));
            ResultSet rs = callableStatement.executeQuery();
            while (rs.next()) {
                loginState = true;
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
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return loginState;
    }

    public Users getInfoAcount(String user) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Users result = null;
        String query = "Select * from Account Where username = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = new Users(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8));
            }
        } catch (Exception e) {
            System.out.println(e);
        }  finally {
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

    public boolean checkUser(String user) {

        Connection conn = null;
        PreparedStatement ps = null;
        Boolean loginState = false;

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareCall("select username from Account where username = ?");
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                loginState = true;
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
        return loginState;

    }

    public boolean createAcc(String username, String pass, String name, String email, String phone, String address) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean rerult = false;
        String query = " insert into [dbo].[Account] ( [username]\n"
                + "      ,[pass]\n"
                + "      ,[fullname]\n"
                + "      ,[email]\n"
                + "      ,[isAdmin]\n"
                + "      ,[isCus]\n"
                + "      ,[phone]\n"
                + "      ,[address])\n"
                + "	  values (?,?,?,?,0,1,?,?);";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, md5(pass));
            ps.setString(3, name);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);

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

    public boolean updateAcc(String username, String name, String email, String phone, String address) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean rerult = false;
        String query = "  update [Account] set \n"
                + "  fullname = ?,\n"
                + "  email = ?,\n"
                + "  phone = ?,\n"
                + "  [address] = ?\n"
                + "  where username = ?;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, username);

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                rerult = true;
            }
        } catch (Exception e) {
        }  finally {
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

    public boolean changePass(String user, String pass) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean rerult = false;
        String query = "  update [Account] set \n"
                + "  pass = ?\n"
                + "  where username = ?;";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, md5(pass));
            ps.setString(2, user);

            int effectRow = ps.executeUpdate();

            if (effectRow > 0) {
                rerult = true;
            }
        } catch (Exception e) {
        }  finally {
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

    public boolean checkMail(String mail) {
        Connection conn = null;
        PreparedStatement ps = null;
        Boolean loginState = false;

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareCall("select [email] from Account where [email] = ?");
            ps.setString(1, mail);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                loginState = true;
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
        return loginState;
    }

}
