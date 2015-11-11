package DAO;

import Database.DBConnectionFactory;
import Model.ConsumptionReportDetails;
import Model.PurchaseOrder;
import Model.PurchaseOrderDetails;
import Model_View.SubconPurchaseOrderView;
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
public class SubconPurchaseOrderDAO {

    /**
     * Subcontractor Purchase Order
     *
     * @param newSubconPurchaseOrder
     * @return
     */
    public boolean EncodeSubconPurchaseOrder(PurchaseOrder newSubconPurchaseOrder) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO purchase_order\n"
                    + "(poNumber,isSupplier, subconID, productionNumber, dateMade, deliveryDate, preparedBy, isCompleted)\n"
                    + "VALUES(?,?,?,?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newSubconPurchaseOrder.getPoNumber());
            pstmt.setBoolean(2, newSubconPurchaseOrder.isIsSupplier());
            pstmt.setInt(3, newSubconPurchaseOrder.getSubconID());
            pstmt.setInt(4, newSubconPurchaseOrder.getProductionNumber());
            pstmt.setDate(5, newSubconPurchaseOrder.getDateMade());
            pstmt.setDate(6, newSubconPurchaseOrder.getDeliveryDate());
            pstmt.setInt(7, newSubconPurchaseOrder.getPreparedBy());
            pstmt.setBoolean(8, newSubconPurchaseOrder.isIsCompleted());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Subcontractor Purchase Order details
     *
     * @param newCRD
     * @return
     */
    public boolean UpdateSubconPurchaseOrderDetails(ConsumptionReportDetails newCRD) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "UPDATE cr_details\n"
                    + "SET deliveredQty = ?\n"
                    + "WHERE productionNumber = ? AND itemCode = ?;";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setDouble(1, newCRD.getDeliveredQty());
            pstmt.setInt(2, newCRD.getProductionNumber());
            pstmt.setDouble(3, newCRD.getItemCode());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get Subcon PurchaseOrderNumber
     *
     * @return
     * @throws SQLException
     */

    public Integer getSubconPurchaseOrderNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(poNumber) from purchase_order where isSupplier = false";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(poNumber)");
        }
        if (i == 0) {
            i = 50000000;
        } else if (i == 59999999) {
            i = -1;
        } else {
            i += 1;
        }
        conn.close();
        rs.close();
        return i;
    }

    /**
     * Get All SubconPurchase for Approval
     *
     * @return
     */

    public ArrayList<SubconPurchaseOrderView> GetAllSubconPurchaseOrderForApproval() {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SubconPurchaseOrderView> poList = new ArrayList<>();
            String query = "SELECT DISTINCT PO.poNumber, S.companyName, PO.dateMade, PO.deliveryDate, PO.preparedBy\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN ref_subcon S \n"
                    + "ON PO.subconID = S.subconID\n"
                    + "WHERE PO.isSupplier = FALSE AND PO.approvedBy IS NULL;";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubconPurchaseOrderView po = new SubconPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setCompanyName(rs.getString("companyName"));
                poList.add(po);
            }
            ps.close();
            conn.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
    
    /**
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
                    + "                           SET approvedBy = ?\n"
                    + "                           WHERE poNumber = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, newSupplierPurchaseOrder.getApprovedBy());
            pstmt.setInt(2, newSupplierPurchaseOrder.getPoNumber());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    /**
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<SubconPurchaseOrderView> GetSupplierPurchaseOrderForReceiving() throws ParseException {

        ArrayList<SubconPurchaseOrderView> DeliveryReceipt = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT "
                    + "PO.poNumber, S.companyName, PO.deliveryDate, "
                    + "CONCAT(u.firstName,\" \",u.lastName) as 'name' , "
                    + "PO.isCompleted  \n"
                    + "FROM Purchase_Order PO JOIN ref_subcon S \n"
                    + "ON PO.subconID = S.subconID JOIN user u "
                    + "ON PO.preparedBy = u.employeeID\n"
                    + "WHERE PO.approvedby IS NOT NULL AND "
                    + "PO.isSupplier = FALSE AND PO.isCompleted = FALSE GROUP BY Po.poNumber; ");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                SubconPurchaseOrderView SupplierPurchaseOrderView = new SubconPurchaseOrderView();
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
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    /**
     *
     * @param poNumber
     * @return
     */
    public ArrayList<SubconPurchaseOrderView> getSubconPurchaseNumberView(int poNumber) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SubconPurchaseOrderView> poList = new ArrayList<>();

            String query = "SELECT PO.poNumber, \n" +
                "PO.isSupplier, PO.subconID, S.companyName, CR.productionNumber, \n" +
                "PO.dateMade, PO.deliveryDate, PO.approvedBy, PO.preparedBy, \n" +
                "CRD.itemCode, P.productName, P.productType, P.color, P.size, \n" +
                "CRD.qty, CRD.deliveredQty\n" +
                "FROM ref_subcon S\n" +
                "JOIN purchase_order PO\n" +
                "ON PO.subconID = S.subconID\n" +
                "JOIN consumption_report CR \n" +
                "ON CR.productionNumber = PO.productionNumber\n" +
                "JOIN cr_details CRD \n" +
                "ON CR.productionNumber = CRD.productionNumber\n" +
                "JOIN product P\n" +
                "ON CRD.itemCode = P.itemCode\n" +
                "WHERE PO.poNumber AND PO.isSupplier = FALSE;";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, poNumber);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubconPurchaseOrderView po = new SubconPurchaseOrderView();
                po.setPoNumber(rs.getInt("poNumber"));
                po.setIsSupplier(rs.getBoolean("isSupplier"));
                po.setSubconID(rs.getInt("subconID"));
                po.setCompanyName(rs.getString("companyName"));
                po.setProductionNumber(rs.getInt("productionNumber"));
                po.setDateMade(rs.getDate("dateMade"));
                po.setDeliveryDate(rs.getDate("deliveryDate"));
                po.setApprovedBy(rs.getInt("approvedBy"));
                po.setPreparedBy(rs.getInt("preparedBy"));
                po.setItemCode(rs.getInt("itenCode"));
                po.setProductName(rs.getString("productName"));
                po.setProductType(rs.getString("productType"));
                po.setProductColor(rs.getString("color"));
                po.setProductSize(rs.getString("size"));
                po.setQty(rs.getDouble("qty"));
                po.setDeliveredQty(rs.getDouble("deliveredQty"));
                poList.add(po);
            }
            ps.close();
            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    /**
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
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
