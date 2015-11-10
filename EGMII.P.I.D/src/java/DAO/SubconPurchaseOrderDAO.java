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
     * @param newPurchaseOrderDetails
     * @return
     */
    public boolean UpdateSubconPurchaseOrderDetails(ConsumptionReportDetails newCRD) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "UPDATE cr_details\n" +
                "SET deliveredQty = ?\n" +
                "WHERE productionNumber = ? AND itemCode = ?;";
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
     * @return 
     */

    public ArrayList<SubconPurchaseOrderView> GetAllSubconPurchaseOrderForApproval() {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            ArrayList<SubconPurchaseOrderView> poList = new ArrayList<>();
            String query = "SELECT PO.poNumber, S.companyName, PO.dateMade, PO.deliveryDate, PO.preparedBy\n"
                    + "FROM purchase_order PO\n"
                    + "JOIN ref_supplier S \n"
                    + "ON PO.supplierID = S.supplierID\n"
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
}
