package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import Model.ConsumptionReport;
import Model_View.ConsumptionReportView;
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
public class ViewConsumptionReportServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String productionNumber = request.getParameter("productionNumber");
        
        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
            ArrayList<ConsumptionReportView> crList = new ArrayList();

            try {
                crList = DAO.GetAllConsumptionReportGroupBy();
            } catch (ParseException ex) {
                Logger.getLogger(ViewConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        
        if (productionNumber != null) {
             ArrayList<ConsumptionReportView> crListSpecific = new ArrayList();
                
             try {
                crListSpecific = DAO.GetAllConsumptionReportSpecific(Integer.parseInt(productionNumber));
            } catch (ParseException ex) {
                Logger.getLogger(ViewConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

             
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ViewConsumptionReport.jsp");
            request.setAttribute("data", "ViewConsumptionReportSpecific");
           request.setAttribute("crListSpecific", crListSpecific);
            request.setAttribute("crList", crList);
            rd.forward(request, response);
            
        } else {
           
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ViewConsumptionReport.jsp");
            request.setAttribute("data", "ViewConsumptionReport");
            request.setAttribute("crList", crList);
            rd.forward(request, response);

        }
    }
}
