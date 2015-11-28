/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Base;

import DAO.ConsumptionReportDAO;
import DAO.CuttingReportDAO;
import DAO.DeliveryInvoiceDAO;
import DAO.InventoryDAO;
import DAO.InventoryReportDAO;
import DAO.ReplenishmentDAO;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.DeliveryInvoice;
import Model.User;
import Model_View.DeliveryInvoiceView;
import Model_View.InventoryReportView;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
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
 * @author Geraldine Atayan
 */
public class Home extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean notif = false;
        SupplierPurchaseOrderDAO suppo = new SupplierPurchaseOrderDAO();
        SubconPurchaseOrderDAO subpo = new SubconPurchaseOrderDAO();
        CuttingReportDAO crdao = new CuttingReportDAO();
        InventoryReportDAO irdao = new InventoryReportDAO();
        InventoryDAO invdao = new InventoryDAO();
        DeliveryInvoiceDAO didao = new DeliveryInvoiceDAO();
        ReplenishmentDAO repdao = new ReplenishmentDAO();
        User user = (User) request.getSession().getAttribute("login");

//        General Manager
        if (user.getPosition().equalsIgnoreCase("general manager")) {
            int size1 = suppo.GetAllSupplierPurchaseOrderForApproval().size();
            int size2 = subpo.GetAllSubconPurchaseOrderForApproval().size();
            if (size1 != 0 || size2 != 0) {
                notif = true;
            }
            request.setAttribute("Gen1", size1);
            request.setAttribute("Gen2", size2);
        } // Production Manager
        else if (user.getPosition().equalsIgnoreCase("production manager")) {
            int size1 = 0;
            try {
                size1 = subpo.GetSupplierPurchaseOrderForReceiving().size();
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (size1 != 0) {
                notif = true;
            }
            request.setAttribute("prodman", size1);
        } // Cutting Master
        else if (user.getPosition().equalsIgnoreCase("cutting master")) {
            int size1 = 0;
            try {
                size1 = crdao.GetConsumptionReportForCutting().size();
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (size1 != 0) {
                notif = true;
            }
            request.setAttribute("Cut", size1);
        } // Warehouse Manager
        else if (user.getPosition().equalsIgnoreCase("warehouse manager")) {
            int size1 = 0;
            try {
                for (int i = 0; i < invdao.GetWarehouseInventory().size(); i++) {
                    if (invdao.GetWarehouseInventory().get(i).getQty() <= 0) {
                        size1++;
                    }
                }
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (size1 <= 0) {
                notif = true;
            }
            request.setAttribute("Warehouse", size1);
        } // Promo
        else if (user.getPosition().equalsIgnoreCase("promoter")) {
            int size1 = 0;

            try {
                size1 = irdao.InventoryReportView(user.getEmployeeNumber()).size();
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (size1 != 0) {
                notif = true;
            }
            request.setAttribute("Promo", size1);
        } // Promo Supervisor
        else if (user.getPosition().equalsIgnoreCase("promoter supervisor")) {
            ArrayList<DeliveryInvoiceView> size0 = new ArrayList<>();
            try {
                size0 = didao.DeliveryInvoiceView();
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }

            ArrayList<Date> size1 = new ArrayList<>();
            for (int i = 0; i < size0.size(); i++) {
                size1.add(size0.get(i).getDeliveryDate());
            }

            if (size1.size() != 0) {
                notif = true;
            }
            request.setAttribute("Promo Sup", size1);
        } // Receipt Handler
        else if (user.getPosition().equalsIgnoreCase("receipt handler")) {
            int size1 = 0;
            try {
                size1 = repdao.ReplenishmentReportView().size();
            } catch (ParseException ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (size1 != 0) {
                notif = true;
            }
            request.setAttribute("receipth", size1);
        } // Assistant Prod Man
        else if (user.getPosition().equalsIgnoreCase("assistant production manager")) {
            int size1 = 0;
            
            size1 = suppo.GetAllSupplierPurchaseOrderForApproval().size();
            
            if (size1 != 0) {
                notif = true;
            }
            request.setAttribute("apm", size1);
        }

        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
        request.setAttribute("Notification", notif);
        rd.forward(request, response);

    }
}
