package DAO;

import Database.DBConnectionFactory;
import Model.PurchaseOrder;
import Model.PurchaseOrderDetails;
import Model_General.PurchaseOrderAll;
import Model_View.SupplierPurchaseOrderView;
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
public class SupplierPurchaseOrderDAO {

    /**
     * Encode Supplier Purchase Order
     *
     * @param newSupplierPurchaseOrder
     * @return
     */
    public boolean EncodeSupplierPurchaseOrder(PurchaseOrder newSupplierPurchaseOrder) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO purchase_order\n"
                    + "(poNumber,isSupplier, supplierID, dateMade, deliveryDate, preparedBy, isCompleted)\n"
                    + "VALUES(?,?,?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newSupplierPurchaseOrder.getPoNumber());
            pstmt.setBoolean(2, newSupplierPurchaseOrder.isIsSupplier());
            pstmt.setInt(3, newSupplierPurchaseOrder.getSupplierID());
            pstmt.setDate(4, newSupplierPurchaseOrder.getDateMade());
            pstmt.setDate(5, newSupplierPurchaseOrder.getDeliveryDate());
            pstmt.setInt(6, newSupplierPurchaseOrder.getPreparedBy());
            pstmt.setBoolean(7, newSupplierPurchaseOrder.isIsCompleted());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Supplier Purchase Order
     *
     * @param newSupplierPurchaseOrder
     * @return
     */
    public boolean EncodeSupplierPurchaseOrderDetails(PurchaseOrderDetails newPurchaseOrderDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO purchase_order_details\n"
                    + "(poNumber, itemCode, qty, deliveredQty)\n"
                    + "VALUES (?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newPurchaseOrderDetails.getPoNumber());
            pstmt.setInt(2, newPurchaseOrderDetails.getItemCode());
            pstmt.setDouble(3, newPurchaseOrderDetails.getQty());
            pstmt.setDouble(4, newPurchaseOrderDetails.getDeliveredQty());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Integer getSupplierPurchaseOrderNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(poNumber) from purchase_order where isSupplier = true";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(poNumber)");
        }
        if (i == 0) {
            i = 70000000;
        } else if (i == 79999999) {
            i = -1;
        } else {
            i += 1;
        }

        rs.close();
        return i;
    }

    public ArrayList<SupplierPurchaseOrderView> GetAllSupplierPurchaseOrderForApproval() {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();
            String query = "SELECT DISTINCT PO.poNumber, PO.preparedBy, PO.dateMade, PO.deliveryDate, S.companyName\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN ref_supplier S \n"
                    + "ON PO.supplierID = S.supplierID\n"
                    + "WHERE PO.isSupplier = TRUE AND PO.approvedBy IS NULL;";
            PreparedStatement ps = conn.prepareStatement(query);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SupplierPurchaseOrderView po = new SupplierPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setCompanyName(rs.getString("companyName"));
                poList.add(po);
            }
            
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
            
            public ArrayList<SupplierPurchaseOrderView> getSupplierPurchaseNumber(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();
            
            String query = "SELECT PO.poNumber, PO.preparedBy, PO.dateMade, PO.deliveryDate, S.companyName, PO.isSupplier,\n"
                    + "I.itemName, S.unitPrice, POD.qty, PO.approvedBy, PO.isCompleted\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN purchase_order_details POD\n"
                    + "ON PO.poNumber  =POD.poNumber\n"
                    + "JOIN ref_item I \n"
                    + "ON POD.itemCode = I.itemCode\n"
                    + "JOIN ref_supplier S \n"
                    + "ON I.itemCode = S.itemCode\n"
                    + "AND PO.supplierID = S.supplierID\n"
                    + "WHERE PO.poNumber = ? AND PO.isSupplier = TRUE AND PO.approvedBy IS NULL;";
            
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, poNumber);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SupplierPurchaseOrderView po = new SupplierPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setCompanyName(rs.getString("companyName"));
                po.setItemName(rs.getString("itemName"));
                po.setUnitPrice(rs.getDouble("unitPrice"));
                po.setQty(rs.getDouble("qty"));
                poList.add(po);
            }
            
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
            
         public ArrayList<SupplierPurchaseOrderView> getSPOReceiving(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();
            
            String query = "SELECT PO.poNumber, PO.preparedBy, PO.dateMade, PO.deliveryDate, S.companyName, PO.isSupplier,\n"
                    + "I.itemName, I.itemCode, S.unitPrice, POD.qty, PO.approvedBy, PO.isCompleted\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN purchase_order_details POD\n"
                    + "ON PO.poNumber  =POD.poNumber\n"
                    + "JOIN ref_item I \n"
                    + "ON POD.itemCode = I.itemCode\n"
                    + "JOIN ref_supplier S \n"
                    + "ON I.itemCode = S.itemCode\n"
                    + "AND PO.supplierID = S.supplierID\n"
                    + "WHERE PO.poNumber = ? AND PO.isSupplier = TRUE;";
            
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, poNumber);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SupplierPurchaseOrderView po = new SupplierPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setCompanyName(rs.getString("companyName"));
                po.setItemName(rs.getString("itemName"));
                po.setItemCode(rs.getInt("itemCode"));
                po.setUnitPrice(rs.getDouble("unitPrice"));
                po.setQty(rs.getDouble("qty"));
                poList.add(po);
            }
            
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }   
          
          public boolean updateApproval(PurchaseOrder newSupplierPurchaseOrder) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<PurchaseOrder> poList = new ArrayList<>();
            
            String query = "UPDATE purchase_order\n" +
"                           SET approvedBy = ?\n" +
"                           WHERE poNumber = ?;";
            
             PreparedStatement pstmt = conn.prepareStatement(query);
             pstmt.setInt(1, newSupplierPurchaseOrder.getApprovedBy());
             pstmt.setInt(2, newSupplierPurchaseOrder.getPoNumber());
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
//
//    public ArrayList<SupplierPurchaseOrder> GetAllSupplierPurchaseOrder() throws ParseException {
//
//        ArrayList<SupplierPurchaseOrder> newPurchaseOrder = new ArrayList<SupplierPurchaseOrder>();
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            PreparedStatement pstmt = conn.prepareStatement("select * from supplier_purchase_order");
//            ResultSet rs = pstmt.executeQuery();
//
//            while (rs.next()) {
//                SupplierPurchaseOrder temp = new SupplierPurchaseOrder();
//                temp.setPoNumber(rs.getInt("poNumber"));
//                temp.setItemCode(rs.getInt("itemCode"));
//                temp.setSupplier(rs.getInt("supplier"));
//                temp.setDateMade(rs.getDate("dateMade"));
//                temp.setDeliveryDate(rs.getDate("deliveryDate"));
//                temp.setPreparedBy(rs.getInt("preparedBy"));
//                temp.setApprovedBy(rs.getInt("approvedBy"));
//                temp.setReceivingStatus(rs.getString("receivingStatus"));
//                temp.setReconcileStatus(rs.getString("reconcileStatus"));
//                temp.setNote(rs.getString("notes"));
//                newPurchaseOrder.add(temp);
//            }
//            pstmt.close();
//            conn.close();
//
//            return newPurchaseOrder;
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    public ArrayList<SupplierPurchaseOrder> GetSupplierPurchaseOrders(String poNumber) throws ParseException {
//
//        ArrayList<SupplierPurchaseOrder> newPurchaseOrder = new ArrayList<SupplierPurchaseOrder>();
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            PreparedStatement pstmt = conn.prepareStatement("select * from supplier_purchase_order where poNumber = ?");
//            pstmt.setString(1, poNumber);
//            ResultSet rs = pstmt.executeQuery();
//            while (rs.next()) {
//                SupplierPurchaseOrder temp = new SupplierPurchaseOrder();
//                temp.setPoNumber(rs.getInt("poNumber"));
//                temp.setItemCode(rs.getInt("itemCode"));
//                temp.setSupplier(rs.getInt("supplier"));
//                temp.setDateMade(rs.getDate("dateMade"));
//                temp.setDeliveryDate(rs.getDate("deliveryDate"));
//                temp.setPreparedBy(rs.getInt("preparedBy"));
//                temp.setApprovedBy(rs.getInt("approvedBy"));
//                temp.setReceivingStatus(rs.getString("receivingStatus"));
//                temp.setReconcileStatus(rs.getString("reconcileStatus"));
//                temp.setNote(rs.getString("notes"));
//                newPurchaseOrder.add(temp);
//            }
//            pstmt.close();
//            conn.close();
//            rs.close();
//
//            return newPurchaseOrder;
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    public ArrayList<SupplierPurchaseOrder> GetSupplierPurchaseOrder(String poNumber) throws ParseException, SQLException {
//
//        ArrayList<SupplierPurchaseOrder> newPurchaseOrder = new ArrayList<SupplierPurchaseOrder>();
//        SupplierDeliveryReceiptDAO supplierDeliveryReceiptDAO = new SupplierDeliveryReceiptDAO();
//        boolean x = supplierDeliveryReceiptDAO.check(poNumber);
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            //no DR
//
//            if (x == false) {
//                PreparedStatement pstmt = conn.prepareStatement(
//                        "SELECT SPO.poNumber, SPO.itemCode, S.companyName, SPO.volumeQty, S.companyName, SPO.dateMade, \n"
//                        + "SPO.deliveryDate, U.lastName as preparedbyLastName , U.firstName as preparedbyFirstName, \n"
//                        + "S.unitPrice,I.itemName, I.unitMeasurement, I.inventoryType, SPO.notes, SPO.receivingStatus\n"
//                        + "FROM supplier_purchase_order SPO\n"
//                        + "JOIN ref_supplier S\n"
//                        + "ON SPO.itemCode = S.itemCode\n"
//                        + "AND SPO.supplier = S.supplierID\n"
//                        + "JOIN ref_item I\n"
//                        + "ON S.itemCode = I.itemCode\n"
//                        + "JOIN user U\n"
//                        + "ON SPO.preparedBy = U.employeeID\n"
//                        + "WHERE  SPO.poNumber = ? AND SPO.receivingStatus != 'complete';");
//                pstmt.setString(1, poNumber);
//
//                ResultSet rs = pstmt.executeQuery();
//                while (rs.next()) {
//                    SupplierPurchaseOrder temp = new SupplierPurchaseOrder();
//                    temp.setPoNumber(rs.getInt("poNumber"));
//                    temp.setItemCode(rs.getInt("itemCode"));
//                    temp.setCompanyName(rs.getString("companyName"));
//                    temp.setDateMade(rs.getDate("dateMade"));
//                    temp.setDeliveryDate(rs.getDate("deliveryDate"));
//                    temp.setItemName(rs.getString("itemName"));
//                    temp.setVolumeQty(rs.getDouble("volumeQty"));
//                    temp.setPreaparedLastName(rs.getString("preparedbyLastName"));
//                    temp.setPreparedFirstName(rs.getString("preparedbyFirstName"));
//                    temp.setUnitPrice(rs.getInt("unitPrice"));
//                    temp.setUnitMeasurement(rs.getString("unitMeasurement"));
//                    temp.setInventoryType(rs.getString("inventoryType"));
//                    temp.setReceivingStatus(rs.getString("receivingStatus"));
//                    temp.setNote(rs.getString("notes"));
//                    newPurchaseOrder.add(temp);
//                }
//                pstmt.close();
//                conn.close();
//                rs.close();
//            } // if exsiting, get delivery number with received
//            else if (x == true) {
//                PreparedStatement pstmt = conn.prepareStatement(
//                        "SELECT  SPO.poNumber, SDR.drNumber, SPO.itemCode, S.companyName, I.itemName, SDR.receivedQty, SDR.rejectedQty, SPO.volumeQty, SPO.dateMade, \n"
//                        + "SPO.deliveryDate,U.lastName as preparedbyLastName, U.firstName as preparedbyFirstName, \n"
//                        + "S.unitPrice, I.unitMeasurement, I.inventoryType, SPO.receivingStatus, SPO.notes\n"
//                        + "FROM supplier_purchase_order SPO\n"
//                        + "JOIN supplier_delivery_receipt SDR\n"
//                        + "ON	SPO.poNumber = SDR.poNumber\n"
//                        + "AND SPO.itemCode = SDR.itemCode\n"
//                        + "JOIN ref_supplier S\n"
//                        + "ON SPO.itemCode = S.itemCode\n"
//                        + "AND SPO.supplier = S.supplierID\n"
//                        + "JOIN ref_item I \n"
//                        + "ON S.itemCode = I.itemCode\n"
//                        + "JOIN user U \n"
//                        + "ON SPO.preparedBy = U.employeeID\n"
//                        + "WHERE SPO.poNumber = ? AND SPO.receivingStatus != 'complete';");
//
//                pstmt.setString(1, poNumber);
//                ResultSet rs = pstmt.executeQuery();
//                while (rs.next()) {
//                    SupplierPurchaseOrder temp = new SupplierPurchaseOrder();
//                    temp.setPoNumber(rs.getInt("poNumber"));
//                    temp.setDrNumber(rs.getInt("drNumber"));
//                    temp.setItemCode(rs.getInt("itemCode"));
//                    temp.setItemName(rs.getString("itemName"));
//                    temp.setReceivedQty(rs.getDouble("receivedQty"));
//                    temp.setRejectedQty(rs.getDouble("rejectedQty"));
//                    temp.setVolumeQty(rs.getDouble("volumeQty"));
//                    temp.setDateMade(rs.getDate("dateMade"));
//                    temp.setDeliveryDate(rs.getDate("deliveryDate"));
//                    temp.setCompanyName(rs.getString("companyName"));
//                    temp.setPreaparedLastName(rs.getString("preparedbyLastName"));
//                    temp.setPreparedFirstName(rs.getString("preparedbyFirstName"));
//                    temp.setUnitPrice(rs.getInt("unitPrice"));
//                    temp.setUnitMeasurement(rs.getString("unitMeasurement"));
//                    temp.setInventoryType(rs.getString("inventoryType"));
//                    temp.setReceivingStatus(rs.getString("receivingStatus"));
//                    temp.setNote(rs.getString("notes"));
//                    newPurchaseOrder.add(temp);
//                }
//                pstmt.close();
//                conn.close();
//                rs.close();
//            }
//            return newPurchaseOrder;
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
}
