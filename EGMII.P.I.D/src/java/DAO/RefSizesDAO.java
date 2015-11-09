/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnectionFactory;
import Model.ProductTypeSize;
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
public class RefSizesDAO {
    
    /**
 * Inset Sizes
 * @param newProductTypeSize
 * @return 
 */
    public boolean InsertSizes(ProductTypeSize newProductTypeSize) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "insert into ref_color(color) values (?)";
            PreparedStatement pstmt = conn.prepareStatement(query);

//            pstmt.setString(1, newRefColor.getColor());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
/**
 * Get All Sizes
 * @param productType
 * @return
 * @throws ParseException 
 */
    public ArrayList<String> GetAllSizes(String productType) throws ParseException {
        ArrayList<String> sizes = new ArrayList<>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT size from product_type_size where productType = ?");
            pstmt.setString(1, productType);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductTypeSize newProductTypeSize = new ProductTypeSize();
                newProductTypeSize.setSize(rs.getString("size"));
                sizes.add(newProductTypeSize.getSize());
            }

            pstmt.close();
            rs.close();
            conn.close();

            return sizes;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
    

