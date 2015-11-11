package DAO;

import Database.DBConnectionFactory;
import Model.PurchaseOrder;
import Model.PurchaseOrderDetails;
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
 * @author Dimaandal
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
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Supplier Purchase Order
     *
     * @param newPurchaseOrderDetails
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
            pstmt.close();
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
        ps.close();
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
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<SupplierPurchaseOrderView> GetAllSupplierPurchaseView() {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();
            String query = "SELECT DISTINCT PO.poNumber, PO.approvedBy, PO.preparedBy, PO.dateMade, PO.deliveryDate, S.companyName\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN ref_supplier S \n"
                    + "ON PO.supplierID = S.supplierID\n"
                    + "WHERE PO.isSupplier = TRUE AND PO.approvedBy IS NOT NULL;";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SupplierPurchaseOrderView po = new SupplierPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setCompanyName(rs.getString("companyName"));
                po.setApprovedBy(rs.getInt("approvedBy"));
                poList.add(po);
            }
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * NULL
     *
     * @param poNumber
     * @return
     */
    public ArrayList<SupplierPurchaseOrderView> getSupplierPurchaseNumber(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();

            String query = ""
                    + "SELECT PO.poNumber, PO.preparedBy, PO.dateMade, "
                    + "PO.deliveryDate, S.companyName, PO.isSupplier,\n"
                    + "I.itemName, S.unitPrice, POD.qty, PO.approvedBy, "
                    + "PO.isCompleted\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN purchase_order_details POD\n"
                    + "ON PO.poNumber  =POD.poNumber\n"
                    + "JOIN ref_item I \n"
                    + "ON POD.itemCode = I.itemCode\n"
                    + "JOIN ref_supplier S \n"
                    + "ON I.itemCode = S.itemCode\n"
                    + "AND PO.supplierID = S.supplierID\n"
                    + "WHERE PO.poNumber = ? AND PO.isSupplier = TRUE\n"
                    + "AND PO.approvedBy IS NULL;";

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
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * NOT NULL
     *
     * @param poNumber
     * @return
     */
    public ArrayList<SupplierPurchaseOrderView> getSupplierPurchaseNumberView(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();

            String query = ""
                    + "SELECT PO.poNumber, PO.preparedBy, PO.dateMade, "
                    + "PO.deliveryDate, S.companyName, PO.isSupplier,\n"
                    + "I.itemName, S.unitPrice, POD.qty, PO.approvedBy, "
                    + "PO.isCompleted\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN purchase_order_details POD\n"
                    + "ON PO.poNumber  =POD.poNumber\n"
                    + "JOIN ref_item I \n"
                    + "ON POD.itemCode = I.itemCode\n"
                    + "JOIN ref_supplier S \n"
                    + "ON I.itemCode = S.itemCode\n"
                    + "AND PO.supplierID = S.supplierID\n"
                    + "WHERE PO.poNumber = ? AND PO.isSupplier = TRUE\n"
                    + "AND PO.approvedBy IS NOT NULL;";

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
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * get SPO for Receiving
     *
     * @param poNumber
     * @return
     */
    public ArrayList<SupplierPurchaseOrderView> getSPOReceiving(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SupplierPurchaseOrderView> poList = new ArrayList<>();

            String query = "SELECT PO.poNumber, PO.preparedBy, "
                    + "PO.dateMade, PO.deliveryDate, "
                    + "S.companyName, PO.isSupplier,\n"
                    + "I.itemName, I.itemCode, S.unitPrice, "
                    + "POD.qty, PO.approvedBy, PO.isCompleted, POD.deliveredQty\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN purchase_order_details POD\n"
                    + "ON PO.poNumber  = POD.poNumber\n"
                    + "JOIN ref_item I \n"
                    + "ON POD.itemCode = I.itemCode\n"
                    + "JOIN ref_supplier S \n"
                    + "ON I.itemCode = S.itemCode\n"
                    + "AND PO.supplierID = S.supplierID\n"
                    + "WHERE PO.poNumber = ? AND PO.isSupplier = TRUE AND PO.approvedBy IS NOT NULL;";

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
                po.setDeliveredQty(rs.getDouble("deliveredQty"));
                poList.add(po);
            }
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get Supplier PurchaseOrder ForReceiving
     *
     * @param newSupplierPurchaseOrder
     * @return
     * @throws ParseException
     */
    public boolean updateApproval(PurchaseOrder newSupplierPurchaseOrder) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<PurchaseOrder> poList = new ArrayList<>();

            String query = "UPDATE purchase_order\n"
                    + "SET approvedBy = ?\n"
                    + "WHERE poNumber = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, newSupplierPurchaseOrder.getApprovedBy());
            pstmt.setInt(2, newSupplierPurchaseOrder.getPoNumber());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get Supplier PurchaseOrder ForReceiving
     *
     * @return
     * @throws ParseException
     */

    public ArrayList<SupplierPurchaseOrderView> GetSupplierPurchaseOrderForReceiving() throws ParseException {

        ArrayList<SupplierPurchaseOrderView> DeliveryReceipt = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT "
                    + "PO.poNumber, S.companyName, PO.deliveryDate, "
                    + "PO.deliveryDate, CONCAT(u.firstName,\" \",u.lastName) as 'name' , "
                    + "PO.isCompleted  \n"
                    + "FROM Purchase_Order PO JOIN ref_supplier S \n"
                    + "ON PO.SupplierID = S.SupplierID JOIN user u "
                    + "ON PO.preparedBy = u.employeeID\n"
                    + "WHERE PO.approvedby IS NOT NULL AND "
                    + "PO.isSupplier = TRUE AND PO.isCompleted = FALSE GROUP BY Po.poNumber; ");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                SupplierPurchaseOrderView SupplierPurchaseOrderView = new SupplierPurchaseOrderView();
                SupplierPurchaseOrderView.setPoNumber(rs.getInt("poNumber"));
                SupplierPurchaseOrderView.setCompanyName(rs.getString("companyName"));
                SupplierPurchaseOrderView.setDeliveryDate(rs.getDate("deliveryDate"));
                SupplierPurchaseOrderView.setPreparedByName(rs.getString("name"));
                SupplierPurchaseOrderView.setIsCompleted(rs.getBoolean("isCompleted"));
                DeliveryReceipt.add(SupplierPurchaseOrderView);
            }
            pstmt.close();
            conn.close();

            return DeliveryReceipt;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * update Is Complete
     *
     * @param x
     * @param poNumber
     * @return
     * @throws ParseException
     */
    public boolean updateIsComplete(boolean x, int poNumber) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<PurchaseOrder> poList = new ArrayList<>();

            String query = "UPDATE purchase_order\n"
                    + "   SET isCompleted = ?\n"
                    + "   WHERE poNumber = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setBoolean(1, x);
            pstmt.setInt(2, poNumber);

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
