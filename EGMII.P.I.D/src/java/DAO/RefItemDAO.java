package DAO;

import Database.DBConnectionFactory;
import Model.RefItem;
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

public class RefItemDAO {

/**
 * Add item to database
 * @param newRefItem
 * @return 
 */
    public boolean InsertItem(RefItem newRefItem) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "insert into ref_item(itemCode,itemName, inventoryType, unitMeasurement) "
                                                  + "values (?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newRefItem.getItemCode());
            pstmt.setString(2, newRefItem.getItemName());
            pstmt.setString(3, newRefItem.getInventoryType());
            pstmt.setString(4, newRefItem.getUnitMeasurement());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
/**
 * Get All Items
 * @return
 * @throws ParseException 
 */
    public ArrayList<RefItem> GetAllItem() throws ParseException {
        ArrayList<RefItem> RefItem = new ArrayList<RefItem>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ref_item");

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RefItem newRefItem = new RefItem();

                newRefItem.setItemCode(rs.getInt("itemCode"));
                newRefItem.setItemName(rs.getString("itemName"));
                newRefItem.setInventoryType(rs.getString("inventoryType"));
                newRefItem.setUnitMeasurement(rs.getString("unitMeasurement"));
               
                RefItem.add(newRefItem);
            }

            pstmt.close();
            rs.close();
            conn.close();

            return RefItem;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
/**
 * Search Item for Accessories Inventory
 * @param itemName
 * @return
 * @throws SQLException 
 */  

    public ArrayList<RefItem> searchAIitemName(String itemName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();

        String search = itemName + "%";

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM `ref_item` WHERE itemName LIKE ? AND inventoryType = 'accessories'");
        ps.setString(1, search);

        ArrayList<RefItem> RefItem = new ArrayList();
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            RefItem RefItemN = new RefItem();
            RefItemN.setItemCode(rs.getInt("itemCode"));
            RefItemN.setItemName(rs.getString("itemName"));
            RefItemN.setInventoryType(rs.getString("inventoryType"));
            RefItemN.setUnitMeasurement(rs.getString("unitMeasurement"));

            RefItem.add(RefItemN);
        }
        rs.close();
        return RefItem;

    }
    
    
/**
 * Search Item for Production Inventory
 * @param itemName
 * @return
 * @throws SQLException 
 */  

    public ArrayList<RefItem> searchPDItemName(String itemName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();

        String search = itemName + "%";

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM `ref_item` WHERE itemName LIKE ? AND inventoryType = 'production'");
        ps.setString(1, search);

        ArrayList<RefItem> RefItem = new ArrayList();
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            RefItem RefItemN = new RefItem();
            RefItemN.setItemCode(rs.getInt("itemCode"));
            RefItemN.setItemName(rs.getString("itemName"));
            RefItemN.setInventoryType(rs.getString("inventoryType"));
            RefItemN.setUnitMeasurement(rs.getString("unitMeasurement"));

            RefItem.add(RefItemN);
        }
        rs.close();
        return RefItem;

    }

}
