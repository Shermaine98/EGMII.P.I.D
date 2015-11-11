package Controller_SetFormNumber;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import java.io.IOException;
import java.sql.SQLException;
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
 *
 */
public class SetConsumptionNumberServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        Integer productionnumber=0;
        try {
            productionnumber = DAO.getProductionNumber();
        } catch (SQLException ex) {
            Logger.getLogger(SetConsumptionNumberServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ConsumptionReport.jsp");
        request.setAttribute("CRPRNumber", productionnumber);
        rd.forward(request, response);

    }
}
