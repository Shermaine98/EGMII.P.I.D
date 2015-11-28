package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ReplenishmentDAO;
import Model.RepRequest;
import Model.RepRequestDetails;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
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

        String[] itemCode = request.getParameterValues("itemCode");
        String[] qty = request.getParameterValues("qty");

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
        try {
            repRequest.setDateMade();
        } catch (ParseException ex) {
            Logger.getLogger(EncodeReplenishmentRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (ReplenishmentDAO.EncodeReplenishmentRequest(repRequest)) {
            x = true;
        } else {
            x = false;
        }

        //detail
        if (x) {
            for (int i = 0; i < itemCode.length; i++) {
                RepRequestDetails RepRequestDetails = new RepRequestDetails();
                RepRequestDetails.setRepID(repID);
                RepRequestDetails.setItemCode(Integer.parseInt(itemCode[i]));
                RepRequestDetails.setQty(Integer.parseInt(qty[i]));

                if (ReplenishmentDAO.EncodeReplenishmentRequestDetails(RepRequestDetails)) {

                    x = true;

                } else {
                    x = false;
                }
            }
        }
        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/ViewReplenishmentServlet?action=created");
            request.setAttribute("info", "Success");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/ViewReplenishmentServlet?action=created");
            request.setAttribute("info", "Error");
            rd.forward(request, response);
        }

    }

}
