/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Approve;

import Controller_Base.BaseServlet;
import DAO.DeliveryInvoiceDAO;
import DAO.InventoryDAO;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.DeliveryInvoice;
import Model.PurchaseOrder;
import Model_View.SubconPurchaseOrderView;
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
 * @author Geraldine
 */
public class ApproveDeliveryInvoiceSerlvet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeliveryInvoiceDAO DeliveryInvoiceDAO = new DeliveryInvoiceDAO();
        DeliveryInvoice DeliveryInvoice = new DeliveryInvoice();
         int diNumber = Integer.parseInt(request.getParameter("diNumber"));
         int employeeNumber = Integer.parseInt(request.getParameter("approvedBy"));
         DeliveryInvoice.setApprovedBy(employeeNumber);
         DeliveryInvoice.setDiNumber(diNumber);
         boolean x = false;
         
         String[] itemCode = request.getParameterValues("itemCode");
         String[] qty = request.getParameterValues("qty");
         
         InventoryDAO DAO = new InventoryDAO();
         for(int i=0; i<itemCode.length;i++){
            WarehouseInventoryView  view = new WarehouseInventoryView();
            try {
                view = DAO.GetWarehouseInventorySpecific(Integer.parseInt(itemCode[i]));
            } catch (ParseException ex) {
                Logger.getLogger(ApproveDeliveryInvoiceSerlvet.class.getName()).log(Level.SEVERE, null, ex);
            }
                double newQty = view.getQty() - Double.parseDouble(qty[i]);
            try {
                if(DAO.updateInventory(newQty, Integer.parseInt(itemCode[i]))){
                
                x = true;
                }else{
                
                
                x=false;
                }
                    
            } catch (ParseException ex) {
                Logger.getLogger(ApproveDeliveryInvoiceSerlvet.class.getName()).log(Level.SEVERE, null, ex);
            }
                
                 
          }
        try {
            if(x){
            x = DeliveryInvoiceDAO.updateApproval(DeliveryInvoice);
            }else{
            
            x=false;
            }
        } catch (ParseException ex) {
            Logger.getLogger(ApproveDeliveryInvoiceSerlvet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if(x){
         ServletContext context = getServletContext();
         RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
           request.setAttribute("Approval", "Approved");
        rd.forward(request, response); 
        }
    }
}
