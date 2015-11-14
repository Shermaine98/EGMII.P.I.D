/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.ConsumptionReportDetails;
import Model.DeliveryReceipt;
import Model.DeliveryReceiptDetails;
import Model_View.ConsumptionReportView;
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
 * @author Gerard
 */
public class SubconDeliveryReceiptDAO {

    public boolean EncodeSubconDeliveryReceipt(DeliveryReceipt newDeliveryReceipt) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO delivery_receipt\n"
                    + "(drNumber, poNumber, isSupplier, productionNumber, receivedBy, dateReceived)\n"
                    + "VALUES(?,?,?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newDeliveryReceipt.getDrNumber());
            pstmt.setInt(2, newDeliveryReceipt.getPoNumber());
            pstmt.setBoolean(3, newDeliveryReceipt.isIsSupplier());
            pstmt.setInt(4, newDeliveryReceipt.getProductionNumber());
            pstmt.setInt(5, newDeliveryReceipt.getReceivedBy());
            pstmt.setDate(6, newDeliveryReceipt.getDateReceived());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean EncodeSubconDeliveryReceiptDetails(DeliveryReceiptDetails newDeliveryReceiptDetails) {
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
            pstmt.close();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateDeliveredQty(double qty, int productionNumber, int itemCode) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE cr_details\n"
                    + "SET deliveredQty = ?\n"
                    + "WHERE productionNumber = ? AND itemCode = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setDouble(1, qty);
            pstmt.setInt(2, productionNumber);
            pstmt.setInt(3, itemCode);

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateConsumptionStatus(int productionNumber, String status) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE consumption_report\n"
                    + "SET status = ?\n"
                    + "WHERE productionNumber = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setString(1, status);
            pstmt.setInt(2, productionNumber);

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateWarehouseInventory(int itemCode, double qty) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "UPDATE inventory\n"
                    + "SET qty = ?\n"
                    + "WHERE itemCode = ?;";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setDouble(1, qty);
            pstmt.setInt(2, itemCode);

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<ConsumptionReportDetails> getConsumptionQuantity(int productionNumber) throws ParseException {

        ArrayList<ConsumptionReportDetails> ConsumptionReport = new ArrayList<ConsumptionReportDetails>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT productionNumber, itemCode, qty, deliveredQty\n"
                    + "FROM cr_details\n"
                    + "WHERE productionNumber = ?;");
            pstmt.setInt(1, productionNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportDetails temp = new ConsumptionReportDetails();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setItemCode(rs.getInt("itemCode"));
                temp.setQty(rs.getDouble("qty"));
                temp.setDeliveredQty(rs.getDouble("deliveredQty"));
                ConsumptionReport.add(temp);
            }
            pstmt.close();
            conn.close();
            return ConsumptionReport;
        } catch (SQLException ex) {
            Logger.getLogger(SubconDeliveryReceiptDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
