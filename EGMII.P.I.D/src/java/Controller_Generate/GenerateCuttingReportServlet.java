/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Generate;

import Controller_Base.BaseServlet;
import Controller_Json.SetSupplierReceivingServlet;
import DAO.ConsumptionReportDAO;
import DAO.CuttingReportDAO;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Geraldine
 */
public class GenerateCuttingReportServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConsumptionReportDAO ConsumptionReportDAO = new ConsumptionReportDAO();
        CuttingReportDAO CuttingReportDAO = new CuttingReportDAO();
        ArrayList<ConsumptionReportView> ConsumptionReportView = new ArrayList<>();

        String poNumber = request.getParameter("poNumber");

        try {
            ConsumptionReportView = CuttingReportDAO.GetConsumptionReportForCutting();
        } catch (ParseException ex) {
            Logger.getLogger(SetSupplierReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //TODO: FIX FIX       
        if (poNumber != null) {
            ArrayList<ConsumptionReportView> ConsumptionReportViewSpecific = new ArrayList<>();
            ArrayList<ConsumptionReportView> CRforCutting = new ArrayList();
            try {
                ConsumptionReportViewSpecific = ConsumptionReportDAO.GetAllConsumptionReportSpecific(Integer.parseInt(poNumber));
                CRforCutting = ConsumptionReportDAO.GetCRForCutting(Integer.parseInt(poNumber));
            } catch (ParseException ex) {
                Logger.getLogger(GenerateCuttingReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/GenerateCuttingReport.jsp");
            request.setAttribute("data", "CuttingReportSpecific");
            request.setAttribute("CuttingReportSpecific", ConsumptionReportViewSpecific);
            request.setAttribute("CRforCutting", CRforCutting);
            request.setAttribute("CuttingReport", ConsumptionReportView);
            rd.forward(request, response);
        } else {

            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/GenerateCuttingReport.jsp");
            request.setAttribute("data", "null");
            request.setAttribute("CuttingReport", ConsumptionReportView);
            rd.forward(request, response);
        }
    }
}
