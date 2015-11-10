/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import DAO.InventoryRetailDAO;
import Model_View.RetailInventoryView;
import Model_View.WarehouseInventoryView;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gerard
 */
public class ViewBoutiqueInventoryServlet extends BaseServlet {

     @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryRetailDAO InventoryDAO = new InventoryRetailDAO();
        ArrayList<RetailInventoryView> RBIList = new  ArrayList<> ();
        try {
            RBIList = InventoryDAO.GetRIforView();
        } catch (ParseException ex) {
            Logger.getLogger(ViewWarehouseInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
       
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/WarehouseInventory.jsp");
        request.setAttribute("RBIList", RBIList);
        rd.forward(request, response); 
    }


}
