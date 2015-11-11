package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryReportDAO;
import Model.ConsumptionReport;
import Model.User;
import Model_View.ConsumptionReportView;
import Model_View.InventoryReportView;
import Model_View.RetailInventoryView;
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

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryReportDAO inventoryReportDAO = new InventoryReportDAO();
        Integer reportID = 0;
        
        String action = request.getParameter("action");
        ServletContext context = getServletContext();
        User user = (User) request.getSession().getAttribute("login");
        if (action.equalsIgnoreCase("create")) {
            ArrayList<RetailInventoryView> retailInventoryView = new ArrayList<>();
            try {
                retailInventoryView = inventoryReportDAO.InventoryReportCreateView(user.getLocationID());
                reportID = inventoryReportDAO.getReportId();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/InventoryReport.jsp");
            request.setAttribute("retailInventoryView", retailInventoryView);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("view")) {
            ArrayList<InventoryReportView> inventoryReportView = new ArrayList<InventoryReportView>();
            try {
                inventoryReportView = inventoryReportDAO.InventoryReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/ViewInventoryReport.jsp");
            request.setAttribute("InventoryReportList", inventoryReportView);
            rd.forward(request, response);
        }

    }
}
