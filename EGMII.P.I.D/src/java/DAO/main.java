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
    ProductDAO  ProductDAO = new ProductDAO();
    ArrayList<ProductAll> productAll = new ArrayList<ProductAll>();
    productAll = ProductDAO.searchProduct("STYLE - 1001");
     System.out.println(productAll.get(0).getColor() );
    }
    
}
