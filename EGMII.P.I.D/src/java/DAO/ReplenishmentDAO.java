package DAO;

import Database.DBConnectionFactory;
import Model.RepRequest;
import Model.RepRequestDetails;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class ReplenishmentDAO {

    /**
     * Get Replenishment View
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<RepRequestView> ReplenishmentReportView() throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<RepRequestView> ConsumptionReport = new ArrayList<RepRequestView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT RR.repID, L.branchName, "
                    + "RR.supervisor, RR.dateMade, P.productName, P.color, P.size, RRD.qty\n"
                    + "FROM rep_request RR \n"
                    + "JOIN rep_request_details RRD\n"
                    + "ON RR.repID = RRD.repID\n"
                    + "JOIN product P\n"
                    + "ON RRD.itemCode = P.itemCode\n"
                    + "JOIN ref_location L\n"
                    + "ON RR.location = L.locationID GROUP BY RR.repID;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                RepRequestView temp = new RepRequestView();
                temp.setRepID(rs.getInt("repID"));
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
            Logger.getLogger(ReplenishmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    
    /**
     * Get Replenishment View
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<RepRequestView> ReplenishmentReportSpecView(int ReportID) throws ParseException {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            ArrayList<RepRequestView> ConsumptionReport = new ArrayList<RepRequestView>();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT "
                    + "RR.repID, L.branchName, "
                    + "RR.supervisor, RR.dateMade, P.productName, P.color, P.size, RRD.qty\n"
                    + "FROM rep_request RR \n"
                    + "JOIN rep_request_details RRD\n"
                    + "ON RR.repID = RRD.repID\n"
                    + "JOIN product P\n"
                    + "ON RRD.itemCode = P.itemCode\n"
                    + "JOIN ref_location L\n"
                    + "ON RR.location = L.locationID\n"
                    + "WHERE RR.repID = ?;");
            pstmt.setInt(1, ReportID);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                RepRequestView temp = new RepRequestView();
                temp.setRepID(rs.getInt("repID"));
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
            Logger.getLogger(ReplenishmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Encode Replenishment Request
     *
     * @param newRepRequest
     * @return
     */
    public boolean EncodeReplenishmentRequest(RepRequest newRepRequest) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO rep_request"
                    + "(repID, location, supervisor, dateMade)"
                    + "VALUES (?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newRepRequest.getRepID());
            pstmt.setInt(2, newRepRequest.getLocation());
            pstmt.setInt(3, newRepRequest.getSupervisor());
            pstmt.setDate(4, newRepRequest.getDateMade());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ReplenishmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Replenishment RequestDetails
     *
     * @param newRepRequestDetails
     * @return
     */
    public boolean EncodeReplenishmentRequestDetails(RepRequestDetails newRepRequestDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO rep_request_details"
                    + "(repID, itemCode, qty) "
                    + "VALUES  (?, ?, ?) ";
            PreparedStatement pstmt = conn.prepareStatement(query);
            
            pstmt.setDouble(1, newRepRequestDetails.getRepID());
            pstmt.setDouble(2, newRepRequestDetails.getItemCode());
            pstmt.setDouble(3, newRepRequestDetails.getQty());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ReplenishmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get Replenisment Number
     *
     * @return
     * @throws SQLException
     */
    public Integer getReplenishmentNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(repID) from rep_request";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(repID)");
        }
        if (i == 0) {
            i = 80000000;
        } else if (i == 89999999) {
            i = -1;
        } else {
            i += 1;
        }
        conn.close();
        rs.close();
        return i;
    }
}
