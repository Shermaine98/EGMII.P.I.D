package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryReportDAO;
import Model.ConsumptionReport;
import Model_View.ConsumptionReportView;
import Model_View.InventoryReportView;
import Model_View.RetailInventoryView;
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
public class ViewSubconPurchaseOrderServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       

        String action = request.getParameter("action");
        ServletContext context = getServletContext();
        
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/ViewSubconPurchaseOrder.jsp");
            request.setAttribute("SubconPurchaseOrderList","SubconPurchaseOrderList" );
            rd.forward(request, response);
        

    }
}
