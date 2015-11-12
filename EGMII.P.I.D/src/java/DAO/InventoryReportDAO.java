package DAO;

import Database.DBConnectionFactory;
import Model.InventoryReport;
import Model.InventoryReportCom;
import Model.InventoryReportDetails;
import Model.User;
import Model_View.InventoryReportView;
import Model_View.RetailInventoryView;
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
public class InventoryReportDAO {

    /**
     * View All Inventory Report
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<InventoryReportView> InventoryReportView(int empNum) throws ParseException {
        ArrayList<InventoryReportView> InventoryReport = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
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
                    + "ON L.locationID = IR.location\n"
                    + "JOIN inventory_report_details IRD\n"
                    + "ON IR.reportID = IRD.reportID\n"
                    + "WHERE IR.promo = ?;");

            pstmt.setInt(1, empNum);
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
            conn.close();
            pstmt.close();
            return InventoryReport;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Inventory Report View by Location
     *
     * @param locationId
     * @return
     * @throws ParseException
     */
    public ArrayList<RetailInventoryView> InventoryReportCreateView(int locationId) throws ParseException {
        ArrayList<RetailInventoryView> RetailInventoryView = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("Select "
                    + "L.locationID, L.branchName, "
                    + "L.address, RI.itemCode, "
                    + "RI.qty, p.productName, p.color, p.size\n"
                    + "from ref_location L \n"
                    + "join retail_inventory RI \n"
                    + "on L.locationID = RI.locationID \n"
                    + "join product P \n"
                    + "on RI.itemCode = P.itemCode"
                    + " WHERE L.locationID = ?;");

            pstmt.setInt(1, locationId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                RetailInventoryView newRetailInventoryView = new RetailInventoryView();

                newRetailInventoryView.setLocationID(rs.getInt("locationID"));
                newRetailInventoryView.setBranchName(rs.getString("branchName"));
                newRetailInventoryView.setAddress(rs.getString("address"));
                newRetailInventoryView.setItemCode(rs.getInt("itemCode"));
                newRetailInventoryView.setProductName(rs.getString("productName"));
                newRetailInventoryView.setColor(rs.getString("color"));
                newRetailInventoryView.setSize(rs.getString("size"));
                newRetailInventoryView.setQty(rs.getDouble("qty"));
                RetailInventoryView.add(newRetailInventoryView);

            }
            conn.close();
            pstmt.close();
            return RetailInventoryView;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * GetAll Inventory report group by
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<InventoryReportView> GetAllInventoryView() throws ParseException {
        ArrayList<InventoryReportView> InventoryReportView = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT r.reportID, r.promo, "
                    + "r.location, r.dateMade, "
                    + "rf.branchName, rf.address\n"
                    + "FROM inventory_report r \n"
                    + "JOIN ref_location rf\n"
                    + "on r.location = rf.locationID \n"
                    + "group by r.reportID;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                InventoryReportView newInventoryReport = new InventoryReportView();

                newInventoryReport.setReportID(rs.getInt("reportID"));
                newInventoryReport.setBranchName(rs.getString("branchName"));
                newInventoryReport.setPromo(rs.getInt("promo"));
                newInventoryReport.setDateMade(rs.getDate("DateMade"));
                newInventoryReport.setAddress(rs.getString("address"));
                InventoryReportView.add(newInventoryReport);

            }
            conn.close();
            pstmt.close();
            return InventoryReportView;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Encode Inventory Report
     *
     * @param newInventoryReport
     * @return
     */
    public boolean EncodeInventoryReport(InventoryReport newInventoryReport) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO inventory_report"
                    + "(reportID, promo, location, dateMade)"
                    + "VALUES (?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newInventoryReport.getReportID());
            pstmt.setInt(2, newInventoryReport.getPromo());
            pstmt.setInt(3, newInventoryReport.getLocation());
            pstmt.setDate(4, newInventoryReport.getDateMade());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Encode Inventory Report Details
     *
     * @param newInventoryReportDetails
     * @return
     */
    public boolean EncodeInventoryReportDetials(InventoryReportDetails newInventoryReportDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO inventory_report_details"
                    + "(reportID, itemCode, soldQty, pulledOutQty) "
                    + "VALUES (?, ?, ?, ?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newInventoryReportDetails.getReportID());
            pstmt.setInt(2, newInventoryReportDetails.getItemCode());
            pstmt.setDouble(3, newInventoryReportDetails.getSoldQty());
            pstmt.setDouble(4, newInventoryReportDetails.getPulledOutQty());

            int rows = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get Report ID
     *
     * @return
     * @throws SQLException
     */
    public Integer getReportId() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(reportID) from inventory_report";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(reportID)");
        }
        if (i == 0) {
            i = 800000000;
        } else if (i == 899999999) {
            i = -1;
        } else {
            i += 1;
        }

        rs.close();
        return i;
    }

    /**
     * GetAll Inventory report group by
     *
     * @return
     * @throws ParseException
     */
    public ArrayList<InventoryReportCom> GetInventoryReportRep(String Reportid) throws ParseException {
        ArrayList<InventoryReportCom> InventoryReportView = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT RL.locationID, RL.branchName, RL.address,\n"
                    + "IR.reportID, IR.promo, IR.dateMade, \n"
                    + "IRD.itemCode, P.productName,\n"
                    + "IRD.soldQty, IRD.pulledOutQty, RI.qty as 'currentQty',\n"
                    + "P.size, P.color, Concat(u.firstName,\" \", u.lastName) as 'name'\n"
                    + "FROM ref_location RL\n"
                    + "JOIN retail_inventory RI\n"
                    + "ON RL.locationID = RI.locationID\n"
                    + "JOIN inventory_report IR \n"
                    + "ON RI.locationID = IR.location\n"
                    + "JOIN inventory_report_details IRD\n"
                    + "ON IR.reportID =  IRD.reportID \n"
                    + "JOIN product P \n"
                    + "ON IRD.itemCode = P.itemCode\n"
                    + "JOIN user U \n"
                    + "ON IR.promo = U.employeeID  WHERE reportID = ?;");
            pstmt.setString(1, Reportid);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                InventoryReportCom inventoryReportCom = new InventoryReportCom();

                inventoryReportCom.setLocationID(rs.getInt("locationID"));
                inventoryReportCom.setBranchName(rs.getString("branchName"));
                inventoryReportCom.setPromoid(rs.getInt("promo"));
                inventoryReportCom.setDateMade(rs.getDate("DateMade"));
                inventoryReportCom.setAddress(rs.getString("address"));
                inventoryReportCom.setReportID(rs.getInt("reportID"));
                inventoryReportCom.setItemCode(rs.getInt("itemCode"));
                inventoryReportCom.setProductName(rs.getString("productName"));
                inventoryReportCom.setSoldQty(rs.getDouble("soldQty"));
                inventoryReportCom.setPulledQty(rs.getDouble("pulledOutQty"));
                inventoryReportCom.setCurrentQty(rs.getDouble("currentQty"));
                inventoryReportCom.setSize(rs.getString("size"));
                inventoryReportCom.setColor(rs.getString("color"));
                inventoryReportCom.setName(rs.getString("name"));
                InventoryReportView.add(inventoryReportCom);

            }
            conn.close();
            pstmt.close();
            return InventoryReportView;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
