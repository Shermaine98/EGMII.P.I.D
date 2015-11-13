package DAO;

import Database.DBConnectionFactory;
import Model.DeliveryInvoice;
import Model.DeliveryInvoiceDetails;
import Model.PurchaseOrder;
import Model_View.DeliveryInvoiceView;
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
public class DeliveryInvoiceDAO {

    /**
     * View ReplenishmentReport All
     *
     * @return
     * @throws ParseException
     */
    /**
     * Get Replenishment View
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewApproval() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT di.diNumber, di.approvedBy, \n"
                    + "di.dateMade, di.deliveryDate, CONCAT(U.firstName,\" \",U.lastName) as 'name', l.branchName, l.address\n"
                    + "FROM delivery_invoice di \n"
                    + "JOIN delivery_invoice_details did\n"
                    + "		ON di.diNumber = did.diNumber\n"
                    + " JOIN USER U ON\n"
                    + "	U.employeeID = di.madeby "
                    + "JOIN ref_location l \n"
                    + "ON l.locationID = di.location \n"
                    + "WHERE di.approvedBy IS NULL GROUP BY di.diNumber\n"
                    + " ORDER BY di.deliveryDate;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                DeliveryInvoiceView temp = new DeliveryInvoiceView();
                temp.setDiNumber(rs.getInt("diNumber"));
                temp.setBranchName(rs.getString("branchName"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setAddress(rs.getString("address"));
                temp.setName(rs.getString("name"));
                temp.setApprovedBy(rs.getInt("approvedBy"));
                temp.setDeliveryDate(rs.getDate("deliveryDate"));
                DeliveryInvoiceView.add(temp);
            }
            pstmt.close();
            conn.close();
            return DeliveryInvoiceView;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    public ArrayList<DeliveryInvoiceView> DeliveryInvoiceView() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT di.diNumber, di.approvedBy, \n"
                    + "di.dateMade, di.deliveryDate, CONCAT(U.firstName,\" \",U.lastName) as 'name', l.branchName, l.address\n"
                    + "FROM delivery_invoice di \n"
                    + "JOIN delivery_invoice_details did\n"
                    + "		ON di.diNumber = did.diNumber\n"
                    + " JOIN USER U ON\n"
                    + "	U.employeeID = di.madeby"
                    + "JOIN ref_location l \n"
                    + "ON l.locationID = di.location \n"
                    + "WHERE di.approvedBy IS NOT NULL \n"
                    + "ORDER BY di.deliveryDate;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                DeliveryInvoiceView temp = new DeliveryInvoiceView();
                temp.setDiNumber(rs.getInt("diNumber"));
                temp.setBranchName(rs.getString("branchName"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setAddress(rs.getString("address"));
                temp.setName(rs.getString("name"));
                temp.setApprovedBy(rs.getInt("approvedBy"));
                temp.setDeliveryDate(rs.getDate("deliveryDate"));
                DeliveryInvoiceView.add(temp);
            }
            pstmt.close();
            conn.close();
            return DeliveryInvoiceView;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get Replenishment View
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewSpec(int diNumber) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT di.diNumber, di.approvedBy, \n"
                    + "di.dateMade, di.deliveryDate, \n"
                    + "p.itemCode, p.itemCode, p.productName,\n"
                    + "p.productType,\n"
                    + "p.size, p.color, CONCAT(U.firstName,\" \",U.lastName) as 'name',l.branchName, l.address, did.qty\n"
                    + "FROM delivery_invoice di \n"
                    + "JOIN delivery_invoice_details did\n"
                    + "		ON di.diNumber = did.diNumber\n"
                    + "JOIN Product p \n"
                    + "		ON did.itemCode = p.itemCode\n"
                    + "JOIN USER U ON\n"
                    + "	U.employeeID = di.madeby\n"
                    + "JOIN ref_location l\n"
                    + "	ON l.locationID = di.location\n"
                    + "WHERE di.diNumber = ? \n"
                    + "ORDER BY di.deliveryDate;");
            pstmt.setInt(1, diNumber);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                DeliveryInvoiceView temp = new DeliveryInvoiceView();
                temp.setDiNumber(rs.getInt("diNumber"));
                  temp.setProductID(rs.getInt("itemCode"));
                temp.setBranchName(rs.getString("branchName"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setAddress(rs.getString("address"));
                temp.setName(rs.getString("name"));
                temp.setApprovedBy(rs.getInt("approvedBy"));
                temp.setDeliveryDate(rs.getDate("deliveryDate"));
                temp.setProductName(rs.getString("productName"));
                temp.setProductType(rs.getString("productType"));
                 temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setQty(rs.getDouble("qty"));
                DeliveryInvoiceView.add(temp);
            }
            pstmt.close();
            conn.close();
            return DeliveryInvoiceView;
        } catch (SQLException ex) {
            Logger.getLogger(ReplenishmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<DeliveryInvoiceView> ReplenishmentReportView() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT DI.diNumber, DI.madeBy, DI.dateMade, DI.deliveryDate, L.branchName, \n"
                    + "L.address, P.productName, P.color, P.size, DID.qty, DI.approvedBy\n"
                    + "FROM delivery_invoice DI \n"
                    + "JOIN delivery_invoice_details DID \n"
                    + "ON DI.diNumber = DID.diNumber\n"
                    + "JOIN ref_location L\n"
                    + "ON DI.location = L.locationID\n"
                    + "JOIN product P \n"
                    + "ON DID.itemCode = P.itemCode\n"
                    + "WHERE DI.diNumber = ?;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                DeliveryInvoiceView temp = new DeliveryInvoiceView();
                temp.setDiNumber(rs.getInt("diNumber"));
                temp.setMadeBy(rs.getInt("madeBy"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setDeliveryDate(rs.getDate("deliveryDate"));
                temp.setBranchName(rs.getString("branchName"));
                temp.setAddress(rs.getString("address"));
                temp.setProductName(rs.getString("productName"));
                temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setQty(rs.getDouble("qty"));
                temp.setApprovedBy(rs.getInt("approvedBy"));
                DeliveryInvoiceView.add(temp);
            }
            pstmt.close();
            conn.close();
            return DeliveryInvoiceView;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Encode Delivery Invoice Details
     *
     * @param newDeliveryInvoice
     * @return
     */
    public boolean EncodeDeliveryInvoice(DeliveryInvoice newDeliveryInvoice) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO delivery_invoice"
                    + "(diNumber, location, madeby, dateMade, deliveryDate)"
                    + "VALUES (?, ?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryInvoice.getDiNumber());
            pstmt.setInt(2, newDeliveryInvoice.getLocation());
            pstmt.setInt(3, newDeliveryInvoice.getMadeBy());
            pstmt.setDate(4, newDeliveryInvoice.getDateMade());
            pstmt.setDate(5, newDeliveryInvoice.getDeliveryDate());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Product details
     *
     * @param newDeliveryInvoiceDetails
     * @return
     */
    public boolean EncodeDeliveryInvoiceDetails(DeliveryInvoiceDetails newDeliveryInvoiceDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO delivery_invoice_details"
                    + "(diNumber, itemCode, qty) "
                    + "VALUES (?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryInvoiceDetails.getDiNumber());
            pstmt.setDouble(2, newDeliveryInvoiceDetails.getItemCode());
            pstmt.setDouble(3, newDeliveryInvoiceDetails.getQty());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get delivery Number
     *
     * @return
     * @throws SQLException
     */
    public Integer getDirNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(diNumber) from delivery_invoice";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(diNumber)");
        }
        if (i == 0) {
            i = 90000000;
        } else if (i == 99999999) {
            i = -1;
        } else {
            i += 1;
        }
        conn.close();
        rs.close();
        return i;
    }
    
    public boolean updateApproval(DeliveryInvoice newDeliveryInvoice) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE delivery_invoice\n"
                    + "SET approvedBy = ?\n"
                    + "WHERE diNumber = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, newDeliveryInvoice.getApprovedBy());
            pstmt.setInt(2, newDeliveryInvoice.getDiNumber());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
