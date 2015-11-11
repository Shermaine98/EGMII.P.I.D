/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Json;

import Controller_Base.BaseServlet;
import Controller_View.ViewConsumptionReportServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryDAO;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
import Model_View.RawMaterialsInventoryView;
import Model_View.SubconPurchaseOrderView;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author shermainesy
 */
public class SetApprovalSubconPOServlet extends BaseServlet {

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
        ArrayList<SubconPurchaseOrderView> PurchaseOrderList = new ArrayList<>();
        PurchaseOrderList = PurchaseOrderDAO.GetAllSubconPurchaseOrderForApproval();
        
        String poNumber = request.getParameter("hiddenValue");
        
        
        ArrayList<SubconPurchaseOrderView> SubconPurchaseOrderSpecific = new ArrayList<>();

        // get Specific  details search using productioNumber
        
        // get inventory accessories
        
        //get fabric accesroies
        
        
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconPurchaseOrder.jsp");
        
        request.setAttribute("PurchaseOrderList", PurchaseOrderList);
        request.setAttribute("data", "subconApproval");
        request.setAttribute("", "");
        
        rd.forward(request, response);

    }

}
