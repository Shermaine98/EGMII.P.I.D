/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.SubconPurchaseOrderDAO;
import Model.PurchaseOrder;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
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
public class EncodeSubconPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SubconPurchaseOrderDAO subconPurchaseOrderDAO = new SubconPurchaseOrderDAO();

        //header
        String preparedBy = request.getParameter("preparedBy");
        String deliveryDate = request.getParameter("deliveryDate");
        String subconID = request.getParameter("subconID");
        String productionNumber = request.getParameter("productionNumber");

        boolean isSupplier = false;
        boolean isCompleted = false;

        Integer poNumber = 0;
        try {
            poNumber = subconPurchaseOrderDAO.getSubconPurchaseOrderNumber();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean x = false;

        PurchaseOrder purchaseOrder = new PurchaseOrder();
        purchaseOrder.setPoNumber(poNumber);
        purchaseOrder.setIsSupplier(isSupplier);
        purchaseOrder.setSubconID(Integer.parseInt(subconID));
        purchaseOrder.setProductionNumber(Integer.parseInt(productionNumber));
        try {
            purchaseOrder.setDateMade();
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSupplierPurchaseOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            purchaseOrder.setDeliveryDate(deliveryDate);
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSupplierPurchaseOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        purchaseOrder.setPreparedBy(Integer.parseInt(preparedBy));
        purchaseOrder.setIsCompleted(isCompleted);

        if (subconPurchaseOrderDAO.EncodeSubconPurchaseOrder(purchaseOrder)) {
            x = true;
        } else {
            x = false;
        }

        if (x == true) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/SetSubconNumberServlet");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
            rd.forward(request, response);

        }

    }

}
