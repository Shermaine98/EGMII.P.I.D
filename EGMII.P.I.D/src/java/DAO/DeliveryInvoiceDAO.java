package DAO;

import Database.DBConnectionFactory;
import Model.DeliveryInvoice;
import Model.DeliveryInvoiceDetails;
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
 * @return
 * @throws ParseException 
 */
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
                    + "(diNumber, location, madeby, approvedby, dateMade, deliveryDate)"
                    + "VALUES (?, ?, ?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryInvoice.getDiNumber());
            pstmt.setInt(2, newDeliveryInvoice.getLocation());
            pstmt.setInt(3, newDeliveryInvoice.getMadeBy());
            pstmt.setInt(4, newDeliveryInvoice.getApprovedBy());
            pstmt.setDate(5, newDeliveryInvoice.getDateMade());
            pstmt.setDate(6, newDeliveryInvoice.getDeliveryDate());

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
                    + "(diNUmber, itemCoce, qty) "
                    + "VALUES (?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryInvoiceDetails.getDiNumber());
            pstmt.setDouble(3, newDeliveryInvoiceDetails.getItemCode());
            pstmt.setDouble(4, newDeliveryInvoiceDetails.getQty());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryInvoiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
