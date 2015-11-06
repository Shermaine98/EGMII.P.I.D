/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.PurchaseOrder;
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
    public ArrayList<SupplierPurchaseOrderView> GetPurchaseOrderForReceiving() throws ParseException {

        ArrayList<SupplierPurchaseOrderView> DeliveryReceipt = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT PO.poNumber, S.companyName, PO.deliveryDate, PO.isCompleted  \n" +
                                                            "FROM Purchase_Order PO JOIN ref_supplier S \n" +
                                                            "ON PO.SupplierID = S.SupplierID \n" +
                                                            "WHERE PO.approvedby IS NOT NULL AND PO.isCompleted = 0; ");
        
            ResultSet rs = pstmt.executeQuery();
           
            while (rs.next()) {

                SupplierPurchaseOrderView SupplierPurchaseOrderView = new SupplierPurchaseOrderView();
                SupplierPurchaseOrderView.setPoNumber(rs.getInt("poNumber"));
                SupplierPurchaseOrderView.setCompanyName(rs.getString("companyName"));
                SupplierPurchaseOrderView.setDeliveryDate(rs.getDate("deliveryDate"));
                SupplierPurchaseOrderView.setDeliveryDate(rs.getDate("isCompleted"));
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
}
