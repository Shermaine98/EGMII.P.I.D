package DAO;

import Database.DBConnectionFactory;
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
import java.text.ParseException;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
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
                    + "VALUES(?,?,?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newSubconPurchaseOrder.getPoNumber());
            pstmt.setBoolean(1, newSubconPurchaseOrder.isIsSupplier());
            pstmt.setInt(2, newSubconPurchaseOrder.getSubconID());
            pstmt.setInt(3, newSubconPurchaseOrder.getProductionNumber());
            pstmt.setDate(4, newSubconPurchaseOrder.getDateMade());
            pstmt.setDate(5, newSubconPurchaseOrder.getDeliveryDate());
            pstmt.setInt(6, newSubconPurchaseOrder.getPreparedBy());
            pstmt.setBoolean(7, newSubconPurchaseOrder.isIsCompleted());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Subcontractor Purchase Order details
     *
     * @param newSubconPurchaseOrder
     * @return
     */
    public boolean EncodeSubconPurchaseOrderDeatils(PurchaseOrderDetails newPurchaseOrderDetails) {
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
            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

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

        rs.close();
        return i;
    }

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

            rs.close();
            return poList;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

//    
//    public ArrayList<SubconPurchaseOrder> MonitorSubconPurchaseOrder() throws ParseException {
//        ArrayList<SubconPurchaseOrder> SubconPurchaseOrder = new ArrayList<SubconPurchaseOrder>();
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM subcon_purchase_order");
//
//            ResultSet rs = pstmt.executeQuery();
//            while (rs.next()) {
//                SubconPurchaseOrder newSubconPurchaseOrder = new SubconPurchaseOrder();
//
//                newSubconPurchaseOrder.setPoNumber(rs.getInt("poNumber"));
//                newSubconPurchaseOrder.setProductionNumber(rs.getInt("productionNumber"));
//                newSubconPurchaseOrder.setProductID(rs.getInt("productID"));
//                newSubconPurchaseOrder.setSize(rs.getString("sizeType"));
//                newSubconPurchaseOrder.setDateMade(rs.getDate("dateMade"));
//                newSubconPurchaseOrder.setDeliveryDate(rs.getString("deliveryDate"));
//                newSubconPurchaseOrder.setPreparedBy(rs.getInt("preparedBy"));
//                newSubconPurchaseOrder.setApprovedby(rs.getInt("approvedBy"));
//                newSubconPurchaseOrder.setReceivingStatus(rs.getString("receivingStatus"));
//                newSubconPurchaseOrder.setReconcileStatus(rs.getString("reconcileStatus"));
//                newSubconPurchaseOrder.setSubcon(rs.getInt("subcon"));
//                newSubconPurchaseOrder.setService(rs.getString("service"));
//
//                SubconPurchaseOrder.add(newSubconPurchaseOrder);
//
//            }
//
//            pstmt.close();
//            rs.close();
//            conn.close();
//
//            return SubconPurchaseOrder;
//        } catch (SQLException ex) {
//            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//    
//      public ArrayList<SubconPurchaseOrder> getSubconPurchaseOrder(String poNumber) throws ParseException {
//        ArrayList<SubconPurchaseOrder> SubconPurchaseOrder = new ArrayList<SubconPurchaseOrder>();
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM subcon_purchase_order where poNumber = ?");
//            pstmt.setString(1, poNumber);
//            ResultSet rs = pstmt.executeQuery();
//            while (rs.next()) {
//                SubconPurchaseOrder newSubconPurchaseOrder = new SubconPurchaseOrder();
//
//                newSubconPurchaseOrder.setPoNumber(rs.getInt("poNumber"));
//                newSubconPurchaseOrder.setProductionNumber(rs.getInt("productionNumber"));
//                newSubconPurchaseOrder.setProductID(rs.getInt("productID"));
//                newSubconPurchaseOrder.setSize(rs.getString("sizeType"));
//                newSubconPurchaseOrder.setDateMade(rs.getDate("dataMade"));
//                newSubconPurchaseOrder.setDeliveryDate(rs.getString("deliveryDate"));
//                newSubconPurchaseOrder.setPreparedBy(rs.getInt("preparedBy"));
//                newSubconPurchaseOrder.setApprovedby(rs.getInt("approvedBy"));
//                newSubconPurchaseOrder.setReceivingStatus(rs.getString("receivingStatus"));
//                newSubconPurchaseOrder.setReconcileStatus(rs.getString("reconcilingStatus"));
//                newSubconPurchaseOrder.setSubcon(rs.getInt("subcon"));
//                newSubconPurchaseOrder.setService(rs.getString("service"));
//
//                SubconPurchaseOrder.add(newSubconPurchaseOrder);
//
//            }
//
//            pstmt.close();
//            rs.close();
//            conn.close();
//
//            return SubconPurchaseOrder;
//        } catch (SQLException ex) {
//            Logger.getLogger(SubconPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//    
}
