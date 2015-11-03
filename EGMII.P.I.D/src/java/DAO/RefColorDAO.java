package DAO;

import Database.DBConnectionFactory;
import Model.RefColor;
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

public class RefColorDAO {

/**
 * Add Color to database
 * @param newRefColor
 * @return 
 */
    public boolean InsertItem(RefColor newRefColor) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "insert into ref_color(color) values (?)";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setString(1, newRefColor.getColor());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
/**
 * Get All Items
 * @return
 * @throws ParseException 
 */
    public ArrayList<RefColor> GetAllColor() throws ParseException {
        ArrayList<RefColor> RefItem = new ArrayList<RefColor>();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ref_color");

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RefColor newRefColor = new RefColor();

                newRefColor.setColor(rs.getString("color"));
               

                RefItem.add(newRefColor);
            }

            pstmt.close();
            rs.close();
            conn.close();

            return RefItem;
        } catch (SQLException ex) {
            Logger.getLogger(RefItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
