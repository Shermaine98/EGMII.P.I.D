package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryReportDAO;
import Model.ConsumptionReport;
import Model_View.ConsumptionReportView;
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
public class ViewInventoryReportServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryReportDAO inventoryReportDAO = new InventoryReportDAO();
        ArrayList<InventoryReportView> inventoryReportView = new   ArrayList<InventoryReportView> ();
        String action = request.getParameter("action");
        ServletContext context = getServletContext();
        if (action.equalsIgnoreCase("create")) {
            
            
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/InventoryReport.jsp");
            request.setAttribute("ProductionInventoryList", "");
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("view")) {
            try {
                inventoryReportView =  inventoryReportDAO.InventoryReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/ViewInventoryReport.jsp");
            request.setAttribute("InventoryReportList", inventoryReportView);
            rd.forward(request, response);
        }

    }
}
