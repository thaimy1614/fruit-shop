
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

public class MainShop {

    // Encrypt function using AES encryption
    public static String encrypt(String plainText, String key) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Decrypt function using AES encryption
    public static String decrypt(String encryptedText, String key) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
            return new String(decryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        String input = "Hello, world!";
        String key = "okimfinegwenchan";

        // Encryption
        String encryptedText = encrypt(input, key);
        System.out.println("Encrypted text: " + encryptedText);

        // Decryption
        String decryptedText = decrypt(encryptedText, key);
        System.out.println("Decrypted text: " + decryptedText);

        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // Chuỗi kết nối đến cơ sở dữ liệu
            String connectionString = "jdbc:sqlserver://localhost:1433;databaseName=ShopTraiCay;user=sa;password=170903;encrypt=false";
            conn = DriverManager.getConnection(connectionString);

            // Chuẩn bị câu lệnh SQL INSERT
            String sql = "INSERT INTO TransactionVnpay (code, username, order_id, bank_name, account_number, transaction_date, total_amount, order_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Đặt các tham số cho câu lệnh INSERT
            stmt.setString(1, "abc");
            stmt.setString(2, "thaine"); // Thay thế bằng tên người dùng thực sự
            stmt.setInt(3, 100000);
            stmt.setString(4, "NCB");
            stmt.setString(5, "123190729714124"); // Cần thay đổi tên tham số này thành tên thích hợp
            stmt.setString(6, "2024-02-16 17:40:30");
            stmt.setFloat(7, 100000);
            stmt.setString(8, "Test");

            // Thực thi câu lệnh INSERT
            stmt.executeUpdate();

            // Đóng kết nối
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    

    
    
}
}
