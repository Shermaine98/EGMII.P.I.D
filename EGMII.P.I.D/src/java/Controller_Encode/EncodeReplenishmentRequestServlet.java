package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryDAO;
import DAO.InventoryReportDAO;
import DAO.InventoryRetailDAO;
import DAO.ProductDAO;
import DAO.ReplenishmentDAO;
import Model.ConsumptionReport;
import Model.ConsumptionReportDetails;
import Model.InventoryReport;
import Model.InventoryReportDetails;
import Model.RepRequest;
import Model.User;
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
 *
 */
public class EncodeReplenishmentRequestServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        boolean x = false;
        ReplenishmentDAO ReplenishmentDAO = new ReplenishmentDAO();
        RepRequest repRequest = new RepRequest();
        String locationID = request.getParameter("location");
        String supervisor = request.getParameter("supervisor");

        Integer repID = 0;
        try {
            repID = ReplenishmentDAO.getReplenishmentNumber();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeReplenishmentRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        //header
        repRequest.setRepID(repID);
        repRequest.setLocation(Integer.parseInt(locationID));
        repRequest.setSupervisor(Integer.parseInt(supervisor));

        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
            request.setAttribute("", "");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
            rd.forward(request, response);
        }

    }

}
