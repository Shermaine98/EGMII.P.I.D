package DAO;

import Database.DBConnectionFactory;
import Model_View.RawMaterialsInventoryView;
import Model_View.WarehouseInventoryView;
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
public class InventoryDAO {

    /**
     * Get All Accessories Inventory
     *
     * @return
     * @throws ParseException
     */

    public ArrayList<RawMaterialsInventoryView> GetAccessoriesInventory() throws ParseException {
        ArrayList<RawMaterialsInventoryView> AccessoriesInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, "
                    + "I.itemName, I.unitMeasurement, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN ref_item I\n"
                    + "ON INV.itemCode = I.itemCode\n"
                    + "WHERE I.inventoryType = \"accessories\"");

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RawMaterialsInventoryView newAccessoriesInventory = new RawMaterialsInventoryView();

                newAccessoriesInventory.setItemCode(rs.getInt("itemCode"));
                newAccessoriesInventory.setItemName(rs.getString("itemName"));
                newAccessoriesInventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                newAccessoriesInventory.setQty(rs.getDouble("qty"));
                AccessoriesInventory.add(newAccessoriesInventory);
            }

            conn.close();
            pstmt.close();
            return AccessoriesInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get Specific Accessories Inventory
     *
     * @param itemCode
     * @return
     * @throws ParseException
     */
    public RawMaterialsInventoryView GetAccessoriesInventorySpecific(int itemCode) throws ParseException {
        RawMaterialsInventoryView inventory = new RawMaterialsInventoryView();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, "
                    + "I.inventoryType, I.unitMeasurement, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN ref_item I\n"
                    + "ON INV.itemCode = I.itemCode\n"
                    + "WHERE I.inventoryType = \"accessories\" and"
                    + " INV.itemCode = ?;");

            pstmt.setInt(1, itemCode);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                inventory.setItemCode(rs.getInt("itemCode"));
                inventory.setInventoryType(rs.getString("inventoryType"));
                inventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                inventory.setQty(rs.getDouble("qty"));
            }
            conn.close();
            pstmt.close();
            return inventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
     /**
     * Get Specific Accessories Inventory
     *
     * @param itemCode
     * @return
     * @throws ParseException
     */
    public RawMaterialsInventoryView GetAAndPInventorySpecific(int itemCode) throws ParseException {
        RawMaterialsInventoryView inventory = new RawMaterialsInventoryView();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, "
                    + "I.inventoryType, I.unitMeasurement, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN ref_item I\n"
                    + "ON INV.itemCode = I.itemCode\n"
                    + "WHERE I.inventoryType != \"warehouse\" and"
                    + " INV.itemCode = ?;");

            pstmt.setInt(1, itemCode);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                inventory.setItemCode(rs.getInt("itemCode"));
                inventory.setInventoryType(rs.getString("inventoryType"));
                inventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                inventory.setQty(rs.getDouble("qty"));
            }
            conn.close();
            pstmt.close();
            return inventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }


    /**
     * Get Production Inventory
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<RawMaterialsInventoryView> GetProductionInventory() throws ParseException {
        ArrayList<RawMaterialsInventoryView> ProductionInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, "
                    + "I.itemName, I.unitMeasurement, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN ref_item I\n"
                    + "ON INV.itemCode = I.itemCode\n"
                    + "WHERE I.inventoryType = \"production\"");

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RawMaterialsInventoryView newProductionInventory = new RawMaterialsInventoryView();

                newProductionInventory.setItemCode(rs.getInt("itemCode"));
                newProductionInventory.setItemName(rs.getString("itemName"));
                newProductionInventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                newProductionInventory.setQty(rs.getDouble("qty"));
                ProductionInventory.add(newProductionInventory);

            }
            conn.close();
            pstmt.close();
            return ProductionInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get Warehouse Inventory
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<WarehouseInventoryView> GetWarehouseInventory() throws ParseException {
        ArrayList<WarehouseInventoryView> ProductionInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, "
                    + "P.productName, P.productType, P.color, P.size, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN product P\n"
                    + "ON INV.itemCode = P.itemCode\n"
                    + "WHERE P.inventoryType = \"warehouse\";");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                WarehouseInventoryView newWarehouseInventoryView = new WarehouseInventoryView();

                newWarehouseInventoryView.setItemCode(rs.getInt("itemCode"));
                newWarehouseInventoryView.setProductName(rs.getString("productName"));
                newWarehouseInventoryView.setProductType(rs.getString("productType"));
                newWarehouseInventoryView.setColor(rs.getString("color"));
                newWarehouseInventoryView.setSize(rs.getString("size"));
                newWarehouseInventoryView.setQty(rs.getDouble("qty"));
                ProductionInventory.add(newWarehouseInventoryView);

            }
            conn.close();
            pstmt.close();
            return ProductionInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get Specific Warehouse Inventory
     *
     * @param itemCode
     * @return
     * @throws ParseException
     */
    public WarehouseInventoryView GetWarehouseInventorySpecific(int itemCode) throws ParseException {
        WarehouseInventoryView ProductionInventory = new WarehouseInventoryView();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, P.productName, P.productType, P.color, P.size, INV.qty\n"
                    + "FROM inventory INV\n"
                    + "JOIN product P\n"
                    + "ON INV.itemCode = P.itemCode\n"
                    + "WHERE P.inventoryType = \"warehouse\" and"
                    + " INV.itemCode = ?;");

            pstmt.setInt(1, itemCode);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                WarehouseInventoryView newWarehouseInventoryView = new WarehouseInventoryView();

                newWarehouseInventoryView.setItemCode(rs.getInt("itemCode"));
                newWarehouseInventoryView.setProductName(rs.getString("productName"));
                newWarehouseInventoryView.setProductType(rs.getString("productType"));
                newWarehouseInventoryView.setColor(rs.getString("color"));
                newWarehouseInventoryView.setSize(rs.getString("size"));
                newWarehouseInventoryView.setQty(rs.getDouble("qty"));
                ProductionInventory = newWarehouseInventoryView;

            }
            conn.close();
            pstmt.close();
            return ProductionInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Update Inventory
     *
     * @param qty
     * @param itemCode
     * @return
     * @throws ParseException
     */
    public boolean updateInventory(double qty, int itemCode) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE inventory \n"
                    + "SET qty = ? \n"
                    + "WHERE itemCode = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setDouble(1, qty);
            pstmt.setInt(2, itemCode);

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<RawMaterialsInventoryView> checkRMInventory(int productionNumber) throws ParseException {
        ArrayList<RawMaterialsInventoryView> AccessoriesInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT Inv.itemCode, \n" +
                "itemName, totalQtyPerItem,\n" +
                "(inv.qty - totalQtyPerItem) AS 'BalQty'\n" +
                "FROM inventory Inv\n" +
                "INNER JOIN\n" +
                "(SELECT BM.itemCode, RI.itemName as 'itemName', SUM((BM.qty * CRD.qty)) as 'totalQtyPerItem'\n" +
                "FROM product_bm BM\n" +
                "JOIN cr_details CRD\n" +
                "ON BM.productID = CRD.itemCode\n" +
                "JOIN ref_item RI \n" +
                "ON BM.itemCode = RI.itemCode\n" +
                "WHERE productionNumber = ?\n" +
                "group by BM.itemCode) AS QN\n" +
                "ON Inv.itemCode = QN.itemCode;");
            
            pstmt.setInt(1, productionNumber);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                RawMaterialsInventoryView newAccessoriesInventory = new RawMaterialsInventoryView();

                newAccessoriesInventory.setItemCode(rs.getInt("itemCode"));
                newAccessoriesInventory.setItemName("itemName");
                newAccessoriesInventory.setQty(rs.getDouble("totalQtyPerItem"));
                newAccessoriesInventory.setQtyNeeded(rs.getDouble("BalQty"));
                AccessoriesInventory.add(newAccessoriesInventory);
            }

            conn.close();
            pstmt.close();
            return AccessoriesInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
