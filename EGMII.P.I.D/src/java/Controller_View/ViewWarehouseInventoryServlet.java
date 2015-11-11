/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import Model_View.WarehouseInventoryView;
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
public class ViewWarehouseInventoryServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryDAO InventoryDAO = new InventoryDAO();
        ArrayList<WarehouseInventoryView> WarehouseInventoryList = new  ArrayList<> ();
        try {
            WarehouseInventoryList = InventoryDAO.GetWarehouseInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewWarehouseInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
       
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/WarehouseInventory.jsp");
        request.setAttribute("WarehouseInventoryList", WarehouseInventoryList);
        rd.forward(request, response); 
    }


}
