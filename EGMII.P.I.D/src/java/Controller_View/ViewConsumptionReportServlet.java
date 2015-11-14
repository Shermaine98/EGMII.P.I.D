package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import Model_View.ConsumptionReportView;
import java.io.IOException;
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
public class ViewConsumptionReportServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String productionNumber = request.getParameter("productionNumber");

        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        ArrayList<ConsumptionReportView> crList = new ArrayList();

        String goToC = request.getParameter("goToC");

        try {
            crList = DAO.GetAllConsumptionReportGroupBy();
        } catch (ParseException ex) {
            Logger.getLogger(ViewConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (productionNumber != null) {
            if (goToC.equalsIgnoreCase("ViewSpecific")) {
                Integer consumptionReportNumber = (Integer) request.getAttribute("consumptionReportNumber");
                productionNumber = String.valueOf(consumptionReportNumber);
            }

            ArrayList<ConsumptionReportView> crListSpecific = new ArrayList();
            ArrayList<ConsumptionReportView> CRforFabric = new ArrayList();
            ArrayList<ConsumptionReportView> CRforSizes = new ArrayList();

            try {
                crListSpecific = DAO.GetAllConsumptionReportSpecific(Integer.parseInt(productionNumber));
                CRforFabric = DAO.GetCRforFabric(Integer.parseInt(productionNumber));
                CRforSizes = DAO.GetCRForSizes(Integer.parseInt(productionNumber));
            } catch (ParseException ex) {
                Logger.getLogger(ViewConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ViewConsumptionReport.jsp");
            request.setAttribute("data", "ViewConsumptionReportSpecific");
            request.setAttribute("crListSpecific", crListSpecific);
            request.setAttribute("CRforFabric", CRforFabric);
            request.setAttribute("CRforSizes", CRforSizes);
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
