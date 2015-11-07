/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model_View.ConsumptionReportView;
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
public class ReplenishmentDAO {

    public ArrayList<RepRequestView> ReplenishmentReportView() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<RepRequestView> ConsumptionReport = new ArrayList<RepRequestView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT RR.repID, RRD.version, L.branchName, "
                    + "RR.supervisor, RR.dateMade, P.productName, P.color, P.size, RRD.qty\n"
                    + "FROM rep_request RR \n"
                    + "JOIN rep_request_details RRD\n"
                    + "ON RR.repID = RRD.repID\n"
                    + "JOIN product P\n"
                    + "ON RRD.itemCode = P.itemCode\n"
                    + "JOIN ref_location L\n"
                    + "ON RR.location = L.locationID\n"
                    + "WHERE RR.repID = ?;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                RepRequestView temp = new RepRequestView();
                temp.setRepID(rs.getInt("repID"));
                temp.setVersion(rs.getInt("version"));
                temp.setBranchName(rs.getString("branchName"));
                temp.setSupervisor(rs.getInt("supervisor"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setProductName(rs.getString("productName"));
                temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setQty(rs.getDouble("qty"));
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
