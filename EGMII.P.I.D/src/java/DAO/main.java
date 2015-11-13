/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import Model_General.ProductAll;

/**
 *
 * @author shermainesy
 */
public class main {

    /**
     *
     * @param args
     * @throws SQLException
     * @throws ParseException
     */
    public static void main (String args[]) throws SQLException, ParseException{
    ReplenishmentDAO  ReplenishmentDAO = new ReplenishmentDAO();
    //InventoryDAO InventoryDAO = new InventoryDAO();
   // InventoryDAO.checkRMInventory(300000000);
    System.out.print(ReplenishmentDAO.ReplenishmentReportSpecView(80000000));
   
      
    }
    
}
