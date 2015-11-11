package DAO;

import Database.DBConnectionFactory;
import Model.ConsumptionReport;
import Model.ConsumptionReportDetails;
import Model_View.ConsumptionReportView;
import java.sql.*;
import java.text.ParseException;
import java.util.*;
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
public class ConsumptionReportDAO {

    /**
     * Encode Consumption Report
     *
     * @param newConsumptionReport
     * @return
     */
    public boolean EncodeConsumptionReport(ConsumptionReport newConsumptionReport) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO consumption_report\n"
                    + "(productionNumber, preparedBy, dateMade, status)\n"
                    + "VALUES (?,?,?,?);";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newConsumptionReport.getProductionNumber());
            pstmt.setInt(2, newConsumptionReport.getPreparedBy());
            pstmt.setDate(3, newConsumptionReport.getDateMade());
            pstmt.setString(4, newConsumptionReport.getStatus());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ConsumptionReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Encode Consumption Report details
     *
     * @param newConsumptionReport
     * @return
     */
    public boolean EncodeConsumptionReportDetails(ConsumptionReportDetails newConsumptionReportDetails) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "INSERT INTO cr_details\n"
                    + "(productionNumber, itemCode, qty, deliveredQty)\n"
                    + "VALUES (?,?,?,?);";

            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newConsumptionReportDetails.getProductionNumber());
            pstmt.setInt(2, newConsumptionReportDetails.getItemCode());
            pstmt.setDouble(3, newConsumptionReportDetails.getQty());
            pstmt.setDouble(4, newConsumptionReportDetails.getDeliveredQty());

            int rows = pstmt.executeUpdate();
            conn.close();
            pstmt.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ConsumptionReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get Consumption Form Number
     *
     * @return - Consumption Number
     * @throws SQLException
     */
    public Integer getProductionNumber() throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        Integer i = 0;
        String query = "SELECT MAX(productionNumber) from consumption_report";
        PreparedStatement ps = conn.prepareStatement(query);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            i = rs.getInt("MAX(productionNumber)");
        }
        if (i == 0) {
            i = 300000000;
        } else if (i == 399999999) {
            i = -1;
        } else {
            i += 1;
        }
        ps.close();
        conn.close();
        rs.close();
        return i;
    }

    /**
     * Get All Consumption Report with ProductName and Details - HEADER
     *
     * @return @throws ParseException
     */
    public ArrayList<ConsumptionReportView> GetAllConsumptionReportGroupBy() throws ParseException {

        ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT CR.productionNumber, "
                    + "CR.dateMade, CR.status, \n"
                    + "CONCAT(u.firstName,\" \",u.lastName) as 'name', "
                    + "P.productType, P.productName ,P.color, P.itemCode "
                    + "FROM consumption_report CR\n"
                    + "JOIN cr_details CRD\n"
                    + "ON CR.productionNumber = CRD.productionNumber\n"
                    + "JOIN product P \n"
                    + "ON CRD.itemCode =  P.itemCode\n"
                    + "JOIN product_bm PBM\n"
                    + "ON P.itemCode = PBM.productID\n"
                    + "JOIN user u \n"
                    + "ON CR.preparedBy = u.employeeID\n"
                    + "group by CR.productionNumber;");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setStatus(rs.getString("status"));
                temp.setName(rs.getString("name"));
                temp.setProductType(rs.getString("productType"));
                temp.setProductName(rs.getString("productName"));
                temp.setColor(rs.getString("color"));
                temp.setProductNumber(rs.getInt("itemCode"));
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
     * Get Specific Consumption Report with All information - Details
     *
     * @param productionNumber
     * @return
     * @throws ParseException
     */
    public ArrayList<ConsumptionReportView> GetAllConsumptionReportSpecific(int productionNumber) throws ParseException {

        ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT DISTINCT CR.productionNumber,"
                    + "CR.dateMade, CR.status, CRD.itemCode, \n"
                    + "SUM(CRD.qty) as 'VolumeQty', CONCAT(u.firstName,\" \",u.lastName) as 'name', "
                    + "P.productType, P.productName ,P.color, P.size, I.itemName, I.inventoryType, "
                    + "I.unitMeasurement, SUM(PBM.qty) as 'ConsumptionQty'\n"
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
                    + "WHERE CR.productionNumber = ? GROUP BY I.itemCode;");
            pstmt.setInt(1, productionNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setStatus(rs.getString("status"));
                temp.setItemCode(rs.getInt("itemCode"));
                temp.setVolumeQty(rs.getInt("VolumeQty"));
                temp.setName(rs.getString("name"));
                temp.setProductType(rs.getString("productType"));
                temp.setProductName(rs.getString("productName"));
                temp.setItemName(rs.getString("itemName"));
                temp.setInventoryType(rs.getString("inventoryType"));
                temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setUnitMeasurement(rs.getString("unitMeasurement"));
                temp.setConsumptionQty(rs.getInt("ConsumptionQty"));
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
     *
     * @param productionNumber
     * @return
     * @throws ParseException
     */
    public ArrayList<ConsumptionReportView> GetCRforFabric(int productionNumber) throws ParseException {

        ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(""
                    + "SELECT CR.productionNumber,\n"
                    + "CR.dateMade, CR.status, CRD.itemCode,\n"
                    + "CRD.qty as 'VolumeQty', P.productType, P.productName ,\n"
                    + "P.color, P.size, I.itemName, I.inventoryType,\n"
                    + "I.unitMeasurement, PBM.qty as 'ConsumptionQty', (CRD.qty * PBM.qty) as 'totalQty'\n"
                    + "FROM consumption_report CR\n"
                    + "JOIN cr_details CRD\n"
                    + "ON CR.productionNumber = CRD.productionNumber\n"
                    + "JOIN product P\n"
                    + "ON CRD.itemCode =  P.itemCode\n"
                    + "JOIN product_bm PBM\n"
                    + "ON P.itemCode = PBM.productID\n"
                    + "JOIN ref_item I\n"
                    + "ON PBM.itemCode = I.itemCode\n"
                    + "WHERE CR.productionNumber = ? \n"
                    + "ORDER BY I.itemCode, P.itemCode;");
            pstmt.setInt(1, productionNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setStatus(rs.getString("status"));
                temp.setItemCode(rs.getInt("itemCode"));
                temp.setVolumeQty(rs.getDouble("VolumeQty"));
                temp.setProductName(rs.getString("productName"));
                temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setItemName(rs.getString("itemName"));
                temp.setInventoryType(rs.getString("inventoryType"));
                temp.setUnitMeasurement(rs.getString("unitMeasurement"));
                temp.setConsumptionQty(rs.getDouble("ConsumptionQty"));
                temp.setTotalQty(rs.getDouble("totalQty"));
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
     *
     * @param productionNumber
     * @return
     * @throws ParseException
     */
    public ArrayList<ConsumptionReportView> GetCRForCutting(int productionNumber) throws ParseException {

        ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT CR.productionNumber, \n"
                    + "CRD.itemCode,CR.dateMade, P.productName, \n"
                    + "RI.itemName, RI.itemCode as 'forItem', P.color, P.size, CRD.qty as 'VolumeQty', \n"
                    + "PBM.qty as 'ConsumptionQty', (CRD.qty * PBM.qty) as 'totalQty'\n"
                    + "FROM consumption_report CR\n"
                    + "JOIN cr_details CRD\n"
                    + "ON CR.productionNumber = CRD.productionNumber\n"
                    + "JOIN product P \n"
                    + "ON CRD.itemCode = P.itemCode\n"
                    + "JOIN product_bm PBM\n"
                    + "ON P.itemCode = PBM.productID\n"
                    + "JOIN ref_item RI \n"
                    + "ON PBM.itemCode = RI.itemCode\n"
                    + "WHERE RI.inventoryType = \"production\" AND CR.productionNumber = ? \n"
                    + "ORDER BY 5, P.itemCode;");
            pstmt.setInt(1, productionNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setProductionNumber(rs.getInt("productionNumber"));
                temp.setItemCode(rs.getInt("itemCode"));
                temp.setDateMade(rs.getDate("dateMade"));
                temp.setProductName(rs.getString("productName"));
                temp.setItemName(rs.getString("itemName"));
                temp.setItemCodeRM(rs.getInt("forItem"));
                temp.setColor(rs.getString("color"));
                temp.setSize(rs.getString("size"));
                temp.setVolumeQty(rs.getInt("VolumeQty"));
                temp.setConsumptionQty(rs.getInt("ConsumptionQty"));
                temp.setTotalQty(rs.getDouble("totalQty"));
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

    public ArrayList<ConsumptionReportView> GetCRForSizes(int productionNumber) throws ParseException {

        ArrayList<ConsumptionReportView> ConsumptionReport = new ArrayList<ConsumptionReportView>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT CRD.itemCode, CRD.qty, P.size\n" +
                "FROM cr_details CRD \n" +
                "JOIN product P \n" +
                "ON CRD.itemCode = P.itemCOde\n" +
                "WHERE productionNumber = ?\n" +
                "ORDER BY P.itemCode;");
            pstmt.setInt(1, productionNumber);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ConsumptionReportView temp = new ConsumptionReportView();
                temp.setItemCode(rs.getInt("itemCode"));
                temp.setVolumeQty(rs.getDouble("qty"));
                temp.setSize(rs.getString("size"));
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
