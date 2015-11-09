package DAO;

import Database.DBConnectionFactory;
import Model.RetailInventory;
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
public class InventoryRetail {
    /**
     * Get Retail Inventory
     * @return
     * @throws ParseException 
     */

    public ArrayList<RetailInventory> GetRetailInventory() throws ParseException {
        ArrayList<RetailInventory> RetailInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT IR.reportID ,L.branchName, IR.promo, IR.dateMade, P.productName, \n"
                    + "P.color, P.size, RI.qty, IRD.pulledOutQty, IRD.soldQty\n"
                    + "FROM product P\n"
                    + "JOIN retail_inventory RI\n"
                    + "ON P.itemCode = RI.itemCode \n"
                    + "JOIN ref_location L \n"
                    + "ON RI.locationID = L.locationID\n"
                    + "JOIN inventory_report IR \n"
                    + "ON RI.location = IR.location\n"
                    + "JOIN inventory_report_details IRD\n"
                    + "ON IR.reportID = IRD.reportID\n"
                    + "WHERE IR.reportID = ?;");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                RetailInventory newRetailInventory = new RetailInventory();

                newRetailInventory.setItemCode(rs.getInt("reportID"));
                newRetailInventory.setQty(rs.getDouble("qty"));
                RetailInventory.add(newRetailInventory);

            }
            conn.close();
            pstmt.close();
            return RetailInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryRetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
/**
 * Update Retails Inventory Quantity
 * @param qty
 * @param locationID
 * @param itemCode
 * @return
 * @throws ParseException 
 */
    public boolean updateRetailInventoryQty(double qty, int locationID, int itemCode) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE retail_inventory \n"
                    + "SET qty = ? \n"
                    + "WHERE locationID = ? AND itemCode = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setDouble(1, qty);
            pstmt.setInt(2, locationID);
            pstmt.setInt(3, itemCode);

            int rows = pstmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryRetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
