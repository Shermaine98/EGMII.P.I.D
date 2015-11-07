/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model_View.DeliveryInvoiceView;
import Model_View.RepRequestView;
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
public class DeliveryInvoiceDAO {

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
            Logger.getLogger(ConsumptionReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
