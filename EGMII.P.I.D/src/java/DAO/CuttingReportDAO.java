package DAO;

import Database.DBConnectionFactory;
import Model.CuttingReport;
import Model.CuttingReportDetails;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */

public class CuttingReportDAO {
      /**
     * Get All RECEVIDE PRODUCTION 
     * @return
     * @throws ParseException 
     * @todo FIX FIX FIX SPO join SPOOOOOOOOOOOO
     */

    public ArrayList<ConsumptionReportView> GetConsumptionReportForCutting() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT CR.productionNumber, CR.preparedBy,"
                    + " CR.dateMade, CR.status, CRD.itemCode, \n"
                    + "CRD.qty as 'VolumeQty', CONCAT(u.firstName,\" \",u.lastName) as 'name',"
                    + " P.productName ,P.color, P.size, I.itemName, I.unitMeasurement, "
                    + "PBM.qty as 'Consumption'\n"
                    + "FROM consumption_report CR\n"
                    + "JOIN cr_details CRD\n"
                    + "ON CR.productionNumber = CRD.productionNumber\n"
                    + "JOIN product P \n"
                    + "ON CRD.itemCode =  P.itemCode\n"
                    + "JOIN product_bm PBM\n"
                    + "ON P.itemCode = PBM.productID\n"
                    + "JOIN ref_item I \n"
                    + "ON PBM.itemCode = I.itemCode\n"
                    + "JOIN user u \n"
                    + "ON CR.preparedBy = u.employeeID\n"
                    + "WHERE I.inventoryType = \"production\"\n"
                    + "group by CR.productionNumber;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setProductName(rs.getString("productName"));
                temp.setPreparedBy(rs.getInt("preparedBy"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setColor(rs.getString("color"));
                ConsumptionReport.add(temp);
            }
            pstmt.close();
            conn.close();
            return ConsumptionReport;
        } catch (SQLException ex) {
            Logger.getLogger(ConsumptionReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    /**
     * Get Cutting Report Number
     * @return
     * @throws SQLException 
     */
    public Integer getCuttingReportNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Integer i;
        try (Connection conn = myFactory.getConnection()) {
            i = 0;
            String query = "SELECT MAX(cuttingNumber) from cutting_report";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                i = rs.getInt("MAX(cuttingNumber)");
            }
            if (i == 0) {
                i = 500000000;
            } else if (i == 99999999) {
                i = -1;
            } else {
                i += 1;
            }
            conn.close();
            pstmt.close();
            rs.close();
        }
        return i;
    }
    
    /**
     * Encode Inventory Report
     *
     * @param newCuttingReport
     * @return
     */
    public boolean EncodeCuttingReport(CuttingReport newCuttingReport) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO cutting_report"
                    + "(cuttingNumber, productionNumber, cuttingMaster, dateMade)"
                    + "VALUES (?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newCuttingReport.getCuttingNumber());
            pstmt.setInt(2, newCuttingReport.getProductionNumber());
            pstmt.setInt(3, newCuttingReport.getCuttingMaster());
            pstmt.setDate(4, newCuttingReport.getDateMade());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();  
            return rows == 1;
         
        } catch (SQLException ex) {
            Logger.getLogger(CuttingReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Cutting Report details
     *
     * @param newCuttingReportDetails
     * @return
     */
    public boolean EncodeCuttingReportDetails(CuttingReportDetails newCuttingReportDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO cutting_report_details"
                    + "(cuttingNumber, poNumber, itemCode, Qty, notes) "
                    + "VALUES (?, ?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newCuttingReportDetails.getCuttingNumber());
            pstmt.setInt(2, newCuttingReportDetails.getPoNumber());
            pstmt.setDouble(3, newCuttingReportDetails.getItemCode());
            pstmt.setDouble(4, newCuttingReportDetails.getQty());
            pstmt.setString(4, newCuttingReportDetails.getNotes());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CuttingReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
}
