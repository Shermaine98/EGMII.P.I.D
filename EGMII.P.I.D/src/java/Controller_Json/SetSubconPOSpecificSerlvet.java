/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
import Model_View.SubconPurchaseOrderView;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
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
public class SetSubconPOSpecificSerlvet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ArrayList<ConsumptionReportView> ConsumptionReportView = new ArrayList<>();
   //     SubconPurchaseOrderDAO SubconPurchaseOrderDAO = new SubconPurchaseOrderDAO();
        ConsumptionReportDAO ConsumptionReportDAO = new ConsumptionReportDAO();
        String productionNumber = request.getParameter("hiddenValue");
       
        try {
            ConsumptionReportView = ConsumptionReportDAO.GetAllConsumptionReportGroupBy();
        } catch (ParseException ex) {
            Logger.getLogger(SetSubconPOSpecificSerlvet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ArrayList<ConsumptionReportView> ConsumptionSpecific = new ArrayList<>();

        try {
            ConsumptionSpecific = ConsumptionReportDAO.GetAllConsumptionReportSpecific(Integer.parseInt(productionNumber));
        } catch (ParseException ex) {
            Logger.getLogger(SetSupplierSpecificReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconPurchaseOrder.jsp");
      
        request.setAttribute("ConsumptionList", ConsumptionReportView);
        request.setAttribute("subconData", "consumption");
        request.setAttribute("ConsumptionSpecific",ConsumptionSpecific );
        
        rd.forward(request, response);

    }

}
