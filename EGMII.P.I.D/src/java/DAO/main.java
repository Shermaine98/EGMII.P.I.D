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
    public static void main (String args[]) throws SQLException, ParseException{
    ConsumptionReportDAO  ConsumptionReportDAO = new ConsumptionReportDAO();
    ArrayList<String> productAll = new ArrayList<String>();
      ConsumptionReportDAO.GetConsumptionReportForCutting();
     System.out.println(ConsumptionReportDAO.GetConsumptionReportForCutting());
    }
    
}
