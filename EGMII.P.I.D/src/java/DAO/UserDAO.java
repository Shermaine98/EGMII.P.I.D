package DAO;

import Model.User;
import Database.DBConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
public class UserDAO {

    public boolean register(User newUser) {
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "insert into user"
                    + "(employeeID,lastName,firstName,position,birthDate,entryDate,leftDate,email,password) "
                    + "values (?,?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setInt(1, newUser.getEmployeeNumber());
            pstmt.setString(2, newUser.getLastName());
            pstmt.setString(3, newUser.getFirstName());
            pstmt.setString(4, newUser.getPosition());
            pstmt.setDate(5, newUser.getBirthDate());
            pstmt.setDate(6, newUser.getEntryDate());
            pstmt.setDate(7, newUser.getLeftDate());
            pstmt.setString(8, newUser.getEmail());
            pstmt.setString(9, newUser.getPassword());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean authenticate(User User) {
        boolean valid = false;
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();

            String query = "select * from user where email = ? and password = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setString(1, User.getEmail());
            pstmt.setString(2, User.getPassword());

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                valid = true;
            }

            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valid;
    }
    
    public boolean changePassword(User user, String password){
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            String query = "update user set password = ? where email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);

            pstmt.setString(1, password);
            pstmt.setString(2, user.getEmail());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int getLastEmpNumber() {
        int lastEmployeeNumber = 0;
        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("select max(employeeID)as employeeID from user");

            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                lastEmployeeNumber = rs.getInt("employeeID");
                return lastEmployeeNumber;
            }
            
            pstmt.close();
            rs.close();
            conn.close();
            return lastEmployeeNumber;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public User getUser(String username, String password) throws ParseException {
        User User = new User();

        try {
            DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
            Connection conn = myFactory.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("select * from user where email= '"+ username +"' and password= '"+password+"'");

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {

               User.setEmployeeNumber(rs.getInt("employeeID"));
               User.setLastName(rs.getString("lastName"));
               User.setFirstName(rs.getString("firstName"));
               User.setPosition(rs.getString("position"));
               User.setBirthDate(rs.getString("birthDate"));
               User.setEntryDate(rs.getString("entryDate"));
               User.setEntryDate(rs.getString("entryDate"));
               User.setUserName(rs.getString("email"));
               User.setPassword(rs.getString("password"));

            }

            pstmt.close();
            rs.close();
            conn.close();

            return User;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
