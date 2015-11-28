/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Approve;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryDAO;
import DAO.SubconPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
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
 * @author Gerard
 */
public class ApproveRejectSubconPOServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SubconPurchaseOrderDAO PurchaseOrderDAO = new SubconPurchaseOrderDAO();
        PurchaseOrder purchaseOrder = new PurchaseOrder();
        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();
        ArrayList<ConsumptionReportView> CRforRM = new ArrayList<>();
        ArrayList<ConsumptionReportView> CRforProduction = new ArrayList<>();
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("approve")) {
            int PoNumber = Integer.parseInt(request.getParameter("poNumber"));
            int employeeNumber = Integer.parseInt(request.getParameter("employeeNumber"));
            int productionNumber = Integer.parseInt(request.getParameter("productionNumber"));

            purchaseOrder.setApprovedBy(employeeNumber);
            purchaseOrder.setPoNumber(PoNumber);
            boolean x = false;

            try {
                CRforRM = DAO.getCRTotalForUpdate(productionNumber);
            } catch (ParseException ex) {
                Logger.getLogger(ApproveRejectSubconPOServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                if (PurchaseOrderDAO.updateApproval(purchaseOrder) && DAO.UpdateConsumptionStatus(productionNumber, "ordered")) {
                    x = true;
                    System.out.println("passed approval");
                    for (int i = 0; i < CRforRM.size(); i++) {
                        x = true;
                        RawMaterialsInventoryView rm = new RawMaterialsInventoryView();
                        rm = inventoryDAO.GetAAndPInventorySpecific(CRforRM.get(i).getItemCode());
                        inventoryDAO.updateInventory(rm.getQty() - CRforRM.get(i).getTotalQty(), rm.getItemCode());
                    }
                }
            } catch (ParseException ex) {
                Logger.getLogger(ApproveRejectSubconPOServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (x) {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSubconPurchaseOrderServlet?action=approved");
                request.setAttribute("info", "Success");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSubconPurchaseOrderServlet?action=approved");
                request.setAttribute("info", "Error");
                rd.forward(request, response);
            }

        } else if (action.equalsIgnoreCase("reject")) {
            int PoNumber = Integer.parseInt(request.getParameter("rPoNumber"));
            boolean x = PurchaseOrderDAO.rejectSubconPurchaseOrder(PoNumber);

            if (x) {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSubconPurchaseOrderServlet?action=rejected");
                request.setAttribute("info", "Rejected");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSubconPurchaseOrderServlet?action=rejected");
                request.setAttribute("info", "Error");
                rd.forward(request, response);
            }

        }

    }
}
