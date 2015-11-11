/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Approve;

import Controller_Base.BaseServlet;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.SubconPurchaseOrderView;
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
 * @author Geraldine
 */
public class ApproveRejectSPOServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierPurchaseOrderDAO PurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        PurchaseOrder purchaseOrder = new PurchaseOrder();
         int PoNumber = Integer.parseInt(request.getParameter("poNumber"));
         int employeeNumber = Integer.parseInt(request.getParameter("employeeNumber"));
         purchaseOrder.setApprovedBy(employeeNumber);
         purchaseOrder.setPoNumber(PoNumber);
         boolean x = false;
        try {
           x =  PurchaseOrderDAO.updateApproval(purchaseOrder);
        } catch (ParseException ex) {
            Logger.getLogger(ApproveRejectSPOServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(x){
         ServletContext context = getServletContext();
         RequestDispatcher rd = context.getRequestDispatcher("/ApproveSupplierPurchaseOrderServlet");
           request.setAttribute("Approval", "Approved");
        rd.forward(request, response); 
        }
    }
}
