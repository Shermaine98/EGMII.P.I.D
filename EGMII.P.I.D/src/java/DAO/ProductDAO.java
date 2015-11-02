package DAO;

import Database.DBConnectionFactory;
import Model.Product;
import Model.ProductBM;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
public class ProductDAO {

    /**
     * Encode Product Bill of Materials
     *
     * @param newBillOfMaterials
     * @return
     */
    public boolean EncodeProduct(Product newProduct) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO product \n"
                    + "(itemCode, productName, productType, size, color, inventoryType)\n"
                    + "VALUES (?,?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newProduct.getItemCode());
            pstmt.setString(2, newProduct.getProductName());
            pstmt.setString(3, newProduct.getProductType());
            pstmt.setString(4, newProduct.getSize());
            pstmt.setString(5, newProduct.getColor());
            pstmt.setString(6, newProduct.getInventoryType());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Product details
     *
     * @param newBillOfMaterials
     * @return
     */
    public boolean EncodeProductBM(ProductBM newProductBM) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO product_bm \n"
                    + "(productID, itemCode, qty)\n"
                    + "VALUES (?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newProductBM.getProductID());
            pstmt.setInt(2, newProductBM.getItemCode());
            pstmt.setDouble(3, newProductBM.getQty());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
 /**
  * Search Product for Consumption Report
  * @return
  * @throws SQLException 
  */   

//    public ArrayList<Product> searchProduct(String productID) throws SQLException {
//        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//        Connection conn = myFactory.getConnection();
//
//        String search = productID + "%";
//
//        PreparedStatement ps = conn.prepareStatement("SELECT *\n"
//                + "FROM product P \n"
//                + "JOIN product_bm PBM\n"
//                + "ON P.itemCode = PBM.productID\n"
//                + "WHERE productName = ?");
//        ps.setString(1, search);
//
//        ArrayList<Product> ProductList = new ArrayList();
//        ResultSet rs = ps.executeQuery();
//        while (rs.next()) {
//            Product newProduct = new Product();
//            newProduct.setProductName(rs.getInt("productID"));
//            newProduct.setItemCode(rs.getInt("itemCode"));
//            newProduct.setSize(size);
//            newProduct.(rs.getDouble("itemConsumption"));
//
//            ProductList.add(newProduct);
//
//        }
//        ps.close();
//        rs.close();
//        conn.close();
//        return ;
//
//    }

    public Integer getProductNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Integer i;
        try (Connection conn = myFactory.getConnection()) {
            i = 0;
            String query = "SELECT MAX(itemCode) from Product";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                i = rs.getInt("MAX(itemCode)");
            }
            if (i == 0) {
                i = 200000000;
            } else if (i == 299999999) {
                i = -1;
            } else {
                i += 1;
            }
            conn.close();
            pstmt.close();
            rs.close();
        }
        return i;
    }

}
