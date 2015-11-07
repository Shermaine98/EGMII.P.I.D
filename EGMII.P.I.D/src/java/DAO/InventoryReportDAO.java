/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.InventoryReport;
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
}
