package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.DeliveryInvoiceDAO;
import DAO.InventoryReportDAO;
import DAO.ReplenishmentDAO;
import Model.ConsumptionReport;
import Model_View.ConsumptionReportView;
import Model_View.DeliveryInvoiceView;
import Model_View.InventoryReportView;
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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
public class ViewDeliveryInvoiceServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeliveryInvoiceDAO DeliveryInvoiceDAO = new DeliveryInvoiceDAO();
        ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new   ArrayList<DeliveryInvoiceView> ();
        String action = request.getParameter("action");
        ServletContext context = getServletContext();
        
        if (action.equalsIgnoreCase("create")) {
            
     //        DeliveryInvoiceView =  DeliveryInvoiceDAO.ReplenishmentReportView();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/DeliveryInvoice.jsp");
            //request.setAttribute("ProductionInventoryList", "");
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("approve")) {
            try {
                 DeliveryInvoiceView =  DeliveryInvoiceDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ApproveInvoice.jsp");
            //request.setAttribute("InventoryReportList", inventoryReportView);
            rd.forward(request, response);
        }else if (action.equalsIgnoreCase("view")) {
            try {
                DeliveryInvoiceView =  DeliveryInvoiceDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ViewDeliveryInvoice.jsp");
            request.setAttribute("DeliveryInvoiceView", DeliveryInvoiceView);
            rd.forward(request, response);
        }
        

    }
}
