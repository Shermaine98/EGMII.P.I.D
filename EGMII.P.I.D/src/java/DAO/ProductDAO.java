package DAO;

import Database.DBConnectionFactory;
import Model.Product;
import Model.ProductBM;
import Model_General.ProductAll;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class ProductDAO {

    /**
     * Encode Product Bill of Materials
     *
     * @param newProduct
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
     * @param newProductBM
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
     *
     * @param productName
     * @return
     * @throws SQLException
     */
    public ArrayList<ProductAll> searchProduct(String productName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        ArrayList<ProductAll> ProductList = new ArrayList();
        String search = productName + "%";
        PreparedStatement ps = conn.prepareStatement("SELECT * \n"
                + "FROM product P \n"
                + "JOIN product_bm PBM\n"
                + "ON P.itemCode = PBM.productID\n"
                + "WHERE productName LIKE ? ");
        ps.setString(1, search);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductAll newProduct = new ProductAll();
            newProduct.setItemCode(rs.getInt("itemCode"));
            newProduct.setProductName(rs.getString("productName"));
            newProduct.setProductType(rs.getString("productType"));
            newProduct.setSize(rs.getString("size"));
            newProduct.setColor(rs.getString("color"));
            newProduct.setInventoryType(rs.getString("inventoryType"));
            newProduct.setProductID(rs.getInt("productID"));
            newProduct.setQty(rs.getInt("qty"));
            ProductList.add(newProduct);
        }
        conn.close();
        rs.close();
        return ProductList;

    }

    /**
     * Get Item Production for Consumption Report
     *
     * @param productName
     * @return
     * @throws SQLException
     */
    public ArrayList<ProductAll> GetProductionInventory(String productName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        ArrayList<ProductAll> ProductList = new ArrayList();
        PreparedStatement ps = conn.prepareStatement("SELECT P.itemCode, P.productName, P.productType, P.color, P.size, I.itemName, BM.qty, I.unitMeasurement\n"
                + "FROM product P\n"
                + "JOIN product_bm BM\n"
                + "ON P.itemCode = BM.productID\n"
                + "JOIN ref_item I \n"
                + "ON BM.itemCode = I.itemCode\n"
                + "WHERE P.productName = ? AND I.inventoryType = 'production'\n"
                + "GROUP BY P.size,I.itemName ORDER BY I.itemName ;");
        ps.setString(1, productName);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductAll newProduct = new ProductAll();
            newProduct.setItemCode(rs.getInt("itemCode"));
            newProduct.setProductName(rs.getString("productName"));
            newProduct.setProductType(rs.getString("productType"));
            newProduct.setSize(rs.getString("size"));
            newProduct.setColor(rs.getString("color"));
            newProduct.setItemName(rs.getString("itemName"));
            newProduct.setQty(rs.getDouble("qty"));
            newProduct.setUnitMeasurement(rs.getString("unitMeasurement"));
            ProductList.add(newProduct);
        }
        conn.close();
        rs.close();
        return ProductList;

    }

    /**
     * Get Item Accessories for Consumption Report
     *
     * @param productName
     * @param search productName
     * @return
     * @throws SQLException
     */
    public ArrayList<ProductAll> GetAccessoriesInventory(String productName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        ArrayList<ProductAll> ProductList = new ArrayList();
        PreparedStatement ps = conn.prepareStatement("SELECT P.itemCode, P.productName, P.productType, P.color, P.size, I.itemName, BM.qty, I.unitMeasurement\n"
                + "FROM product P\n"
                + "JOIN product_bm BM\n"
                + "ON P.itemCode = BM.productID\n"
                + "JOIN ref_item I \n"
                + "ON BM.itemCode = I.itemCode\n"
                + "WHERE P.productName = ? AND I.inventoryType = 'accessories' GROUP BY I.itemName ORDER BY P.itemCode ;");
        ps.setString(1, productName);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductAll newProduct = new ProductAll();
            newProduct.setItemCode(rs.getInt("itemCode"));
            newProduct.setProductName(rs.getString("productName"));
            newProduct.setProductType(rs.getString("productType"));
            newProduct.setSize(rs.getString("size"));
            newProduct.setColor(rs.getString("color"));
            newProduct.setItemName(rs.getString("itemName"));
            newProduct.setQty(rs.getDouble("qty"));
            newProduct.setUnitMeasurement(rs.getString("unitMeasurement"));

            ProductList.add(newProduct);
        }
        conn.close();
        rs.close();
        return ProductList;

    }
    /**
     * Get Product Code for item Name
     * @param productName
     * @param Color
     * @return
     * @throws SQLException 
     */
    
      public ArrayList<String> GetProductNumber(String productName, String Color) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        ArrayList<String> productNumberList = new ArrayList();
        PreparedStatement ps = conn.prepareStatement("SELECT p.itemCode FROM product P WHERE P.productName = ? AND P.Color = ?;");
      
        ps.setString(1, productName);
        ps.setString(2, Color);
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String productNumber;
            productNumber = rs.getString("itemCode");
            productNumberList.add(productNumber);
        }
        conn.close();
        rs.close();
        return productNumberList;

    }

    /**
     * Get last ProductNumber
     *
     * @return
     * @throws SQLException
     */
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
    
      /**
     * INSERT into Inventory
     *
     * @param qty
     * @param itemCode
     * @return
     * @throws ParseException
     */
    public boolean InsertInventory(double qty, int itemCode) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "INSERT INTO inventory \n"
                    + "(itemCode, qty) VALUES (?,?)";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, itemCode);
            pstmt.setDouble(2, qty);
            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    
}
