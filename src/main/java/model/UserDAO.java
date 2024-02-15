/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Duong Quoc Thai CE171563
 */
public class UserDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int countItemsInCart(){
        int count = 0;
        String query = "select count(*) as recordUser from Account where isCus = 1";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("recordUser");
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
