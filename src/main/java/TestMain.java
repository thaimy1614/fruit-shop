import model.CartDAO;

public class TestMain {
    public static void main(String[] args){
        CartDAO cd = new CartDAO();
        System.out.println(cd.countItemsInCart("thaine"));
    }
}
