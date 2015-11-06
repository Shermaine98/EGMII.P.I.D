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
 *
 */
public class InventoryDAO {

//    public boolean GetAccessoriesInventory(RawMaterialsInventoryView newRawMaterialsInventoryView) {
//        try {
//            ArrayList<RawMaterialsInventoryView> AccessoriesInv = new ArrayList<RawMaterialsInventoryView>();
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            int rows;
//            try (Connection conn = myFactory.getConnection()) {
//                String query = "SELECT INV.itemCode, I.itemName, I.inventoryType, I.unitMeasurement, INV.qty\n"
//                        + "FROM inventory INV\n"
//                        + "JOIN ref_item I\n"
//                        + "ON INV.itemCode = I.itemCode\n"
//                        + "WHERE I.inventoryType = \"accessories\"";
//                PreparedStatement pstmt = conn.prepareStatement(query);
//                pstmt.setInt(1, newInventoryReportView.getDrNumber());
//                pstmt.setInt(2, newInventoryReportView.getPoNumber());
//                pstmt.setInt(3, newInventoryReportView.getItemCode());
//                pstmt.setDate(4, newInventoryReportView.getDateUpdated());
//                pstmt.setDouble(5, newInventoryReportView.getQty());
//                pstmt.setInt(6, newInventoryReportView.getUpdatedBy());
//                rows = pstmt.executeUpdate();
//            }
//            return rows == 1;
//        } catch (SQLException ex) {
//            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
    public ArrayList<RawMaterialsInventoryView> GetAccessoriesInventory() throws ParseException {
        ArrayList<RawMaterialsInventoryView> AccessoriesInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            try (Connection conn = myFactory.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, I.itemName, I.inventoryType, I.unitMeasurement, INV.qty\n"
                            + "FROM inventory INV\n"
                            + "JOIN ref_item I\n"
                            + "ON INV.itemCode = I.itemCode\n"
                            + "WHERE I.inventoryType = \"accessories\"")) {

                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    RawMaterialsInventoryView newAccessoriesInventory = new RawMaterialsInventoryView();

                    newAccessoriesInventory.setItemCode(rs.getInt("itemCode"));
                    newAccessoriesInventory.setItemName(rs.getString("itemName"));
                    newAccessoriesInventory.setInventoryType(rs.getString("inventoryType"));
                    newAccessoriesInventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                    newAccessoriesInventory.setQty(rs.getDouble("qty"));
                    AccessoriesInventory.add(newAccessoriesInventory);
                }

            }

            return AccessoriesInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<RawMaterialsInventoryView> GetProductionInventory() throws ParseException {
        ArrayList<RawMaterialsInventoryView> ProductionInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            try (Connection conn = myFactory.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, I.itemName, I.inventoryType, I.unitMeasurement, INV.qty\n"
                            + "FROM inventory INV\n"
                            + "JOIN ref_item I\n"
                            + "ON INV.itemCode = I.itemCode\n"
                            + "WHERE I.inventoryType = \"production\";")) {

                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    RawMaterialsInventoryView newProductionInventory = new RawMaterialsInventoryView();

                    newProductionInventory.setItemCode(rs.getInt("itemCode"));
                    newProductionInventory.setItemName(rs.getString("itemName"));
                    newProductionInventory.setInventoryType(rs.getString("inventoryType"));
                    newProductionInventory.setUnitMeasurement(rs.getString("unitMeasurement"));
                    newProductionInventory.setQty(rs.getDouble("qty"));
                    ProductionInventory.add(newProductionInventory);
                }

            }

            return ProductionInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<WarehouseInventoryView> GetWarehouseInventory() throws ParseException {
        ArrayList<WarehouseInventoryView> ProductionInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            try (Connection conn = myFactory.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement("SELECT INV.itemCode, P.productName, P.productType, P.color, P.size, INV.qty\n"
                            + "FROM inventory INV\n"
                            + "JOIN product P\n"
                            + "ON INV.itemCode = P.itemCode\n"
                            + "WHERE P.inventoryType = \"warehouse\";")) {

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

            }

            return ProductionInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
