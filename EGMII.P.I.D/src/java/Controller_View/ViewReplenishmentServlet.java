package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import DAO.InventoryReportDAO;
import DAO.ReplenishmentDAO;
import Model.InventoryReportCom;
import Model_View.InventoryReportView;
import Model_View.RepRequestView;
import Model_View.WarehouseInventoryView;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class ViewReplenishmentServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReplenishmentDAO ReplenishmentDAO = new ReplenishmentDAO();
        ArrayList<InventoryReportView> irv = new ArrayList<InventoryReportView>();
        InventoryReportDAO inventoryReportDAO = new InventoryReportDAO();
        ArrayList<RepRequestView> RepRequestView = new ArrayList<RepRequestView>();
        String action = request.getParameter("action");
        ServletContext context = getServletContext();
        Integer repID = 0;

        try {
            irv = inventoryReportDAO.GetAllInventoryView();
        } catch (ParseException ex) {
            Logger.getLogger(ViewReplenishmentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (action.equalsIgnoreCase("create")) {
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ReplenishmentRequest.jsp");
            request.setAttribute("inventoryReports", irv);
            request.setAttribute("data", "null");
             request.setAttribute("info", "none");
            rd.forward(request, response);

        }else if (action.equalsIgnoreCase("created")) {
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ReplenishmentRequest.jsp");
            request.setAttribute("inventoryReports", irv);
            request.setAttribute("data", "null");
            
            String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
                request.setAttribute("info", "success");
            } else if (info.equalsIgnoreCase("error")) {
                request.setAttribute("info", "error");
            }
            rd.forward(request, response);

        } else if (action.equalsIgnoreCase("specific")) {
            ArrayList<InventoryReportCom> inventoryCom = new ArrayList<InventoryReportCom>();
            ArrayList<WarehouseInventoryView> warehouseView = new ArrayList<>();
            InventoryDAO invDAO = new InventoryDAO();

            try {
                warehouseView = invDAO.GetAllWarehouse();
            } catch (ParseException ex) {
                Logger.getLogger(ViewReplenishmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                String invId = request.getParameter("invId");
                inventoryCom = inventoryReportDAO.GetInventoryReportRep(invId);
                repID = ReplenishmentDAO.getReplenishmentNumber();
            } catch (SQLException ex) {
                Logger.getLogger(ViewReplenishmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ParseException ex) {
                Logger.getLogger(ViewReplenishmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ReplenishmentRequest.jsp");
            request.setAttribute("info", "none");
            request.setAttribute("data", "specific");
            request.setAttribute("inventoryReports", irv);
            request.setAttribute("InventoryReportCom", inventoryCom);
            request.setAttribute("repID", repID);
            request.setAttribute("warehouseView", warehouseView);
            rd.forward(request, response);

        } else if (action.equalsIgnoreCase("view")) {
            try {
                RepRequestView = ReplenishmentDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ViewReplenishmentRequest.jsp");
            request.setAttribute("data", "null");
            request.setAttribute("RepRequestView", RepRequestView);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("viewSpecific")) {

            try {
                RepRequestView = ReplenishmentDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            String reportID = request.getParameter("reportID");
            ArrayList<RepRequestView> RepRequestViewSpec = new ArrayList<RepRequestView>();
            try {
                RepRequestViewSpec = ReplenishmentDAO.ReplenishmentReportSpecView(Integer.parseInt(reportID));
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ViewReplenishmentRequest.jsp");
            request.setAttribute("data", "viewSpecific");
            request.setAttribute("RepRequestView", RepRequestView);
            request.setAttribute("RepRequestViewSpec", RepRequestViewSpec);
            rd.forward(request, response);
        }

    }
}
