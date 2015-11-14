package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import DAO.SubconDeliveryReceiptDAO;
import DAO.SubconPurchaseOrderDAO;
import Model.DeliveryReceipt;
import Model.DeliveryReceiptDetails;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class EncodeSubconDRServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<DeliveryReceiptDetails> DeliveryReceiptDetails = new ArrayList<>();
        DeliveryReceipt DeliveryReceipt = new DeliveryReceipt();
        SubconDeliveryReceiptDAO DAO = new SubconDeliveryReceiptDAO();
        SubconPurchaseOrderDAO subDAO = new SubconPurchaseOrderDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();


        /*header*/
        String drNumber = request.getParameter("drNumber");
        String poNumber = request.getParameter("poNumber");
        String receivedBy = request.getParameter("receivedBy");
        String productionNumber = request.getParameter("productionNumber");

        /*details*/
        String[] itemCode = request.getParameterValues("itemCode");
        String[] qty = request.getParameterValues("receivedqty");
        String[] QtyOrdered = request.getParameterValues("QtyOrdered");
        String[] deliveredQty = request.getParameterValues("deliveredQty");

        boolean x = false;

        DeliveryReceipt.setDrNumber(Integer.parseInt(drNumber));
        DeliveryReceipt.setPoNumber(Integer.parseInt(poNumber));
        DeliveryReceipt.setReceivedBy(Integer.parseInt(receivedBy));
        DeliveryReceipt.setIsSupplier(false);
        DeliveryReceipt.setProductionNumber(Integer.parseInt(productionNumber));

        try {
            DeliveryReceipt.setDateReceived();
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSupplierDRServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (DAO.EncodeSubconDeliveryReceipt(DeliveryReceipt)) {
            x = true;
        } else {
            x = false;
        }

        /*start of encode details*/
        boolean complete = false;
        int checking = 0;
        if (x == true) {
            for (int y = 0; y < itemCode.length; y++) {
                DeliveryReceiptDetails deliveryReceiptDetails = new DeliveryReceiptDetails();
                deliveryReceiptDetails.setDrNumber(Integer.parseInt(drNumber));
                deliveryReceiptDetails.setItemCode(Integer.parseInt(itemCode[y]));
                deliveryReceiptDetails.setQty(Double.parseDouble(qty[y]));
                if (DAO.EncodeSubconDeliveryReceiptDetails(deliveryReceiptDetails)) {
                    try {
                        double currentDeliveredQty = Double.parseDouble(deliveredQty[y]) + Double.parseDouble(qty[y]);
                        if (DAO.updateDeliveredQty(currentDeliveredQty, Integer.parseInt(productionNumber), Integer.parseInt(itemCode[y]))) {
                            x = true;

                            WarehouseInventoryView rm = new WarehouseInventoryView();
                            rm = inventoryDAO.GetWarehouseInventorySpecific(deliveryReceiptDetails.getItemCode());
                            inventoryDAO.updateInventory(currentDeliveredQty + rm.getQty(), rm.getItemCode());
                            if (Double.parseDouble(QtyOrdered[y]) == currentDeliveredQty) {} 
                            else {
                                checking++;
                            }
                        } else {
                            x = false;
                        }
                    } catch (ParseException ex) {
                        Logger.getLogger(EncodeSupplierDRServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    x = true;
                    DeliveryReceiptDetails.add(deliveryReceiptDetails);
                } else {
                    x = false;
                }
            }
        }
        /*end of encode details*/

        /*check if purchase order is complete*/
         if(checking > 0){
            complete = false;
        } else{
            complete = true;
        }
         
        try {
            x = subDAO.updateIsComplete(complete, Integer.parseInt(poNumber));
            
            /*update consumption report status*/
            if(x){
                x = DAO.updateConsumptionStatus(Integer.parseInt(productionNumber), "fulfilled");
            }
            
            
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSubconDRServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*end of checking*/
        
        


        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/SetSubconPOReceivingServlet");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Error.jsp");
            request.setAttribute("Error", "Error");
            rd.forward(request, response);
        }
    }
}
