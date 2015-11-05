/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model.PurchaseOrderDetails;
import java.io.IOException;
import java.sql.SQLException;
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
 * @author Gerard
 */
public class EncodeSupplierPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<PurchaseOrderDetails> purchaseOrderDetailsList = new ArrayList<>();
        SupplierPurchaseOrderDAO supplierPurchaseOrderDAO = new SupplierPurchaseOrderDAO();

        //header
        String preparedBy = request.getParameter("preparedBy");
        String dateMade = request.getParameter("dateMade");
        String deliveryDate = request.getParameter("deliveryDate");
        String supplier = request.getParameter("supplierId");

        Boolean isSupplier = true;
        Boolean isCompleted = false;

        //details
        String[] itemCode = request.getParameterValues("itemCode");
        String[] qty = request.getParameterValues("volumeQty");
        double deliveredQty = 0.0;

        Integer poNumber = 0;
        try {
            poNumber = supplierPurchaseOrderDAO.getSupplierPurchaseOrderNumber();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean x = false;

        PurchaseOrder purchaseOrder = new PurchaseOrder();
        purchaseOrder.setPoNumber(poNumber);
        purchaseOrder.setIsSupplier(isSupplier);
        purchaseOrder.setSupplierID(Integer.parseInt(supplier));
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

        if (supplierPurchaseOrderDAO.EncodeSupplierPurchaseOrder(purchaseOrder)) {
            x = true;
        } else {
            x = false;
        }

        //encode purchaseOrderDetails
        if (x == true) {
            for (int y = 0; y < itemCode.length; y++) {
                PurchaseOrderDetails purchaseOrderDetails = new PurchaseOrderDetails();
                purchaseOrderDetails.setPoNumber(poNumber);
                purchaseOrderDetails.setItemCode(Integer.parseInt(itemCode[y]));
                purchaseOrderDetails.setQty(Integer.parseInt(qty[y]));
                purchaseOrderDetails.setDeliveredQty(deliveredQty);
                if (supplierPurchaseOrderDAO.EncodeSupplierPurchaseOrderDetails(purchaseOrderDetails)) {
                    x = true;
                    purchaseOrderDetailsList.add(purchaseOrderDetails);
                } else {
                    x = false;
                }
            }
        }

        if (x == true) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
            request.setAttribute("SupplierPurchaseOrder", purchaseOrder);
            request.setAttribute("SupplierPurchaseOrderDetailsList", purchaseOrderDetailsList);
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
            rd.forward(request, response);

        }

    }

}
