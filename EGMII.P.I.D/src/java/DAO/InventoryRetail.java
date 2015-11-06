/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.RetailInventory;
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
public class InventoryRetail {
    
     public ArrayList<RetailInventory> GetWarehouseInventory() throws ParseException {
        ArrayList<RetailInventory> RetailInventory = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            try (Connection conn = myFactory.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement("")) {

                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    RetailInventory newRetailInventory = new RetailInventory();

                    newRetailInventory.setItemCode(rs.getInt("itemCode"));
                    newRetailInventory.setQty(rs.getDouble("qty"));
                    RetailInventory.add(newRetailInventory);
                }

            }

            return RetailInventory;
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
