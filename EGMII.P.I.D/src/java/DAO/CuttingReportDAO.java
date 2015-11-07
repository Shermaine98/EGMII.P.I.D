/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
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
 * @author shermainesy
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
}
