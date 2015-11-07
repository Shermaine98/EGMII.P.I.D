/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.InventoryReport;
import Model.InventoryReportDetails;
import Model.RetailInventory;
import Model_View.InventoryReportView;
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
public class InventoryReportDAO {

    public ArrayList<InventoryReportView> InventoryReportView() throws ParseException {
        ArrayList<InventoryReportView> InventoryReport = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            try (Connection conn = myFactory.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(""
                            + "SELECT IR.reportID ,L.branchName, "
                            + "IR.promo, IR.dateMade, "
                            + "P.productName, \n"
                            + "P.color, P.size, RI.qty, "
                            + "IRD.pulledOutQty, IRD.soldQty\n"
                            + "FROM product P\n"
                            + "JOIN retail_inventory RI\n"
                            + "ON P.itemCode = RI.itemCode \n"
                            + "JOIN ref_location L \n"
                            + "ON RI.locationID = L.locationID\n"
                            + "JOIN inventory_report IR \n"
                            + "ON RI.location = IR.location\n"
                            + "JOIN inventory_report_details IRD\n"
                            + "ON IR.reportID = IRD.reportID\n"
                            + "WHERE IR.reportID = ?;")) {

                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    InventoryReportView newInventoryReport = new InventoryReportView();

                    newInventoryReport.setReportID(rs.getInt("reportID"));
                    newInventoryReport.setBranchName(rs.getString("branchName"));
                    newInventoryReport.setPromo(rs.getInt("promo"));
                    newInventoryReport.setDateMade(rs.getDate("dateMade"));
                    newInventoryReport.setProductName(rs.getString("productName"));
                    newInventoryReport.setColor(rs.getString("color"));
                    newInventoryReport.setSize(rs.getString("size"));
                    newInventoryReport.setQty(rs.getDouble("qty"));
                    newInventoryReport.setPulledOutQty(rs.getDouble("pulledOutQty"));
                    newInventoryReport.setSoldQty(rs.getDouble("soldQty"));
                    InventoryReport.add(newInventoryReport);
                }

            }

            return InventoryReport;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

//    public ArrayList<RetailInventory> InventoryReportCreateView() throws ParseException {
//        ArrayList<RetailInventory> InventoryReport = new ArrayList<>();
//
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            try (Connection conn = myFactory.getConnection();
//                    PreparedStatement pstmt = conn.prepareStatement("Select L.locationID, L.branchName, L.address, RI.itemCode, RI.qty, p.productName\n"
//                            + "from ref_location L \n"
//                            + "join retail_inventory RI \n"
//                            + "on L.locationID = RI.locationID \n"
//                            + "join product P \n"
//                            + "on RI.itemCode = P.itemCode")) {
//
//                ResultSet rs = pstmt.executeQuery();
//
//                while (rs.next()) {
//                    RetailInventory newIRetailInventory = new RetailInventory();
//
//                  
//                    newIRetailInventory.setBranchName(rs.getString("branchName"));
//                    newIRetailInventory.setPromo(rs.getInt("promo"));
//                    newIRetailInventory.setDateMade(rs.getDate("dateMade"));
//                    newIRetailInventory.setProductName(rs.getString("productName"));
//                    newIRetailInventory.setColor(rs.getString("color"));
//                    newIRetailInventory.setSize(rs.getString("size"));
//                    newIRetailInventory.setQty(rs.getDouble("qty"));
//                    newIRetailInventory.setPulledOutQty(rs.getDouble("pulledOutQty"));
//                    newIRetailInventory.setSoldQty(rs.getDouble("soldQty"));
//                    InventoryReport.add(newIRetailInventory);
//                }
//
//            }
//
//            return InventoryReport;
//        } catch (SQLException ex) {
//            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    /**
//     * Encode Inventory Report
//     *
//     * @param newBillOfMaterials
//     * @return
//     */
//    public boolean EncodeInventoryReport(InventoryReport newInventoryReport) {
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            String query = "";
//            PreparedStatement pstmt = conn.prepareStatement(query);
//
//            pstmt.setInt(1, newInventoryReport.getItemCode());
//            pstmt.setString(2, newInventoryReport.getProductName());
//            pstmt.setString(3, newInventoryReport.getProductType());
//            pstmt.setString(4, newInventoryReport.getSize());
//            pstmt.setString(5, newInventoryReport.getColor());
//            pstmt.setString(6, newInventoryReport.getInventoryType());
//
//            int rows = pstmt.executeUpdate();
//            pstmt.close();
//            conn.close();
//
//            return rows == 1;
//        } catch (SQLException ex) {
//            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//
//    /**
//     * Encode Product details
//     *
//     * @param newBillOfMaterials
//     * @return
//     */
//    public boolean EncodeInventoryReportDetials(InventoryReportDetails newInventoryReportDetails) {
//        try {
//            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
//            Connection conn = myFactory.getConnection();
//            String query = "";
//            PreparedStatement pstmt = conn.prepareStatement(query);
//
//            pstmt.setInt(1, newInventoryReportDetails.getItemCode());
//            pstmt.setString(2, newInventoryReportDetails.getProductName());
//            pstmt.setString(3, newInventoryReportDetails.getProductType());
//            pstmt.setString(4, newInventoryReportDetails.getSize());
//            pstmt.setString(5, newInventoryReportDetails.getColor());
//            pstmt.setString(6, newInventoryReportDetails.getInventoryType());
//
//            int rows = pstmt.executeUpdate();
//            pstmt.close();
//            conn.close();
//
//            return rows == 1;
//        } catch (SQLException ex) {
//            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }

}
