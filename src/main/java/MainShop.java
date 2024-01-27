import model.CartDAO;
import model.OrderDAO;

public class MainShop {
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        boolean rs = dao.addOrder("thaidq", "Thai", "CT", "0000000", 1, 45000,"2024-1-1", "2024-01-27", 0);

        System.out.println(rs);
    }
}