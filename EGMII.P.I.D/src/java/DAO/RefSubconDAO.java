/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.RefSubcon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Gerard
 */
public class RefSubconDAO {
    public ArrayList<RefSubcon> searchSubcon(String subconName) throws SQLException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();

        String search = subconName + "%";

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM `ref_subcon` WHERE companyName LIKE ? group by companyName");
        ps.setString(1, search);

        ArrayList<RefSubcon> RefSubconList = new ArrayList();
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            RefSubcon RefSubconN = new RefSubcon();
            RefSubconN.setSubconID(rs.getInt("subconID"));
            RefSubconN.setService(rs.getString("service"));
            RefSubconN.setCompanyName(rs.getString("companyName"));
            RefSubconN.setCompanyAddress(rs.getString("companyAddress"));
            RefSubconN.setContactPerson(rs.getString("contactPerson"));
            RefSubconN.setContactNumber(rs.getFloat("contactNumber"));

            RefSubconList.add(RefSubconN);
        }
        conn.close();
        rs.close();
        return RefSubconList;

    }
}
