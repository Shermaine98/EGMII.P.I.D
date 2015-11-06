/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import Model_View.RawMaterialsInventoryView;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shermainesy
 */
public class ViewAccessoriesInventoryServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryDAO AccessoriesInventoryDAO = new InventoryDAO();
        ArrayList<RawMaterialsInventoryView> AccessoriesInventoryList = new  ArrayList<RawMaterialsInventoryView> ();
        try {
            AccessoriesInventoryList = AccessoriesInventoryDAO.GetAccessoriesInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewAccessoriesInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
       
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/AccessoriesInventory.jsp");
        request.setAttribute("AccessoriesInventoryList", AccessoriesInventoryList);
        rd.forward(request, response); 
    }
}
