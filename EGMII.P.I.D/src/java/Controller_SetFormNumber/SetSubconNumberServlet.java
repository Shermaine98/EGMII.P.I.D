package Controller_SetFormNumber;

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
public class SetSubconNumberServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConsumptionReportDAO ConsumptionReportDAO = new ConsumptionReportDAO();
        ArrayList<ConsumptionReportView> ConsumptionReportView = new ArrayList<>();

        try {
            ConsumptionReportView = ConsumptionReportDAO.GetAllConsumptionReportGroupBy();
        } catch (ParseException ex) {
            Logger.getLogger(SetSubconNumberServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconPurchaseOrder.jsp");
        request.setAttribute("subconData", "null");
        request.setAttribute("ConsumptionList", ConsumptionReportView);
        rd.forward(request, response);

    }
}
