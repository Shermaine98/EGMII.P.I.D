package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.DeliveryReceipt;
import Model.DeliveryReceiptDetails;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class EncodeSupplierDRServlet extends BaseServlet {

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
        SupplierDeliveryReceiptDAO SupplierDeliveryReceiptDAO = new SupplierDeliveryReceiptDAO();
        SupplierPurchaseOrderDAO SupplierPurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();

        //header
        String drNumber = request.getParameter("drNumber");
        String poNumber = request.getParameter("poNumber");
        String receivedBy = request.getParameter("receivedBy");
        //dateReceived

        //details
        String[] itemCode = request.getParameterValues("itemCode");
        String[] qty = request.getParameterValues("receivedqty");
        String[] QtyOrdered = request.getParameterValues("QtyOrdered");
        String[] deliveredQty = request.getParameterValues("deliveredQty");

        boolean x = false;

        DeliveryReceipt.setDrNumber(Integer.parseInt(drNumber));
        DeliveryReceipt.setPoNumber(Integer.parseInt(poNumber));
        DeliveryReceipt.setReceivedBy(Integer.parseInt(receivedBy));
        DeliveryReceipt.setIsSupplier(true);
        try {
            DeliveryReceipt.setDateReceived();
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSupplierDRServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (SupplierDeliveryReceiptDAO.EncodeSupplierDeliveryReceipt(DeliveryReceipt)) {
            x = true;
        } else {
            x = false;
        }

        boolean complete = false;
        int checking = 0;
        //encode supplierdetails
        if (x == true) {
            for (int y = 0; y < itemCode.length; y++) {
                DeliveryReceiptDetails deliveryReceiptDetails = new DeliveryReceiptDetails();
                deliveryReceiptDetails.setDrNumber(Integer.parseInt(drNumber));
                deliveryReceiptDetails.setItemCode(Integer.parseInt(itemCode[y]));
                deliveryReceiptDetails.setQty(Double.parseDouble(qty[y]));
                if (SupplierDeliveryReceiptDAO.EncodeSupplierDeliveryReceiptDetails(deliveryReceiptDetails)) {
                    try {
                        double currentDeliveredQty = Double.parseDouble(deliveredQty[y]) + Double.parseDouble(qty[y]);
                        if (SupplierDeliveryReceiptDAO.updateDeliveredQty(currentDeliveredQty, Integer.parseInt(poNumber), Integer.parseInt(itemCode[y]))) {
                            x = true;

                            RawMaterialsInventoryView rm = new RawMaterialsInventoryView();
                            rm = inventoryDAO.GetAAndPInventorySpecific(deliveryReceiptDetails.getItemCode());
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
        
        if(checking > 0){
            complete = false;
        } else{
            complete = true;
        }

        try {
            x = SupplierPurchaseOrderDAO.updateIsComplete(complete, Integer.parseInt(poNumber));
        } catch (ParseException ex) {
            Logger.getLogger(EncodeSupplierDRServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/SetSupplierReceivingServlet?action=re");
            request.setAttribute("info", "success");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/SetSupplierReceivingServlet?action=re");
            request.setAttribute("info", "Error");
            rd.forward(request, response);
        }

    }

}
