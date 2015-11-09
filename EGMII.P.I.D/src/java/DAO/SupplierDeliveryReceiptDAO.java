/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.DeliveryReceipt;
import Model.DeliveryReceiptDetails;
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
 * @author shermainesy
 */
public class SupplierDeliveryReceiptDAO {

   

    public boolean EncodeSupplierDeliveryReceipt(DeliveryReceipt newDeliveryReceipt) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO delivery_receipt\n"
                    + "(drNumber, poNumber, isSupplier, receivedBy, dateReceived)\n"
                    + "VALUES(?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryReceipt.getDrNumber());
            pstmt.setInt(2, newDeliveryReceipt.getPoNumber());
            pstmt.setBoolean(3, newDeliveryReceipt.isIsSupplier());
            pstmt.setInt(4, newDeliveryReceipt.getReceivedBy());
            pstmt.setDate(5, newDeliveryReceipt.getDateReceived());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean EncodeSupplierDeliveryReceiptDetails(DeliveryReceiptDetails newDeliveryReceiptDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO delivery_receipt_details\n"
                    + "(drNumber, itemCode, qty)\n"
                    + "VALUES (?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryReceiptDetails.getDrNumber());
            pstmt.setInt(2, newDeliveryReceiptDetails.getItemCode());
            pstmt.setDouble(3, newDeliveryReceiptDetails.getQty());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

     public boolean updateDeliveredQty(double qty, int poNumber, int itemCode) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE purchase_order_details\n"
                              + "SET deliveredQty = ?\n"
                          + "WHERE poNumber = ? AND itemCode = ?;";
            
            PreparedStatement pstmt = conn.prepareStatement(query);
            
            pstmt.setDouble(1,qty);
            pstmt.setInt(2, poNumber);
            pstmt.setInt(3, itemCode);

            int rows = pstmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SupplierPurchaseOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
