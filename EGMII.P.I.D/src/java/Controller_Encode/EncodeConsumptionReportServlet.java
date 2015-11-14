package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.ProductDAO;
import Model.ConsumptionReport;
import Model.ConsumptionReportDetails;
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
 * @author Dimaandal
 *
 */
public class EncodeConsumptionReportServlet extends BaseServlet {

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
        ProductDAO productDAO = new ProductDAO();
        boolean x = false;
        ConsumptionReport consumptionReport = new ConsumptionReport();

        ArrayList<ConsumptionReport> ConsumptionReportArray = new ArrayList<>();
        ConsumptionReportDAO consumptionReportDAO = new ConsumptionReportDAO();

        ArrayList<ConsumptionReportDetails> ConsumptionReportDetailsArr = new ArrayList<>();
        // ArrayList<Integer> itemCode1 = new ArrayList<>();
        // get purpose
        String productName = request.getParameter("productName");
        String color = request.getParameter("color");
        //Header
        String ProductionNumber = request.getParameter("productionNumber");
        String preparedBy = request.getParameter("preparedBy");
        //String dateMade = request.getParameter("dateMade");
        //status = created
        //details

        //   String[] size = request.getParameterValues("size");
        String[] qty = request.getParameterValues("volumeQty");
       //delvieryqty = 0

        //header encode
        try {
            consumptionReport.setProductionNumber(consumptionReportDAO.getProductionNumber());
        } catch (SQLException ex) {
            Logger.getLogger(EncodeConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        consumptionReport.setPreparedBy(Integer.parseInt(preparedBy));
        consumptionReport.setStatus("created");
        try {
            consumptionReport.setDateMade();
        } catch (ParseException ex) {
            Logger.getLogger(EncodeConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (consumptionReportDAO.EncodeConsumptionReport(consumptionReport)) {
            x = true;
            ConsumptionReportArray.add(consumptionReport);
        }
        ArrayList<String> productNumber = new ArrayList<String>();
        try {
            productNumber = productDAO.GetProductNumber(productName, color);
        } catch (SQLException ex) {
            Logger.getLogger(EncodeConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //encode cr_details
        if (x == true) {
            for (int y = 0; y < productNumber.size(); y++) {
                ConsumptionReportDetails ConsumptionReportDetails = new ConsumptionReportDetails();
                ConsumptionReportDetails.setProductionNumber(Integer.parseInt(ProductionNumber));
                ConsumptionReportDetails.setItemCode(Integer.parseInt(productNumber.get(y)));
                ConsumptionReportDetails.setQty(Double.parseDouble(qty[y]));
                ConsumptionReportDetails.setDeliveredQty(0);
                if (consumptionReportDAO.EncodeConsumptionReportDetails(ConsumptionReportDetails)) {
                    x = true;
                    ConsumptionReportDetailsArr.add(ConsumptionReportDetails);
                } else {
                    x = false;
                }

            }
        }

        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/ViewConsumptionReportServlet?goToC=ViewSpecific");
            request.setAttribute("consumptionReportNumber", consumptionReport.getProductionNumber());
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Error.jsp");
            request.setAttribute("Error", "Error");
            rd.forward(request, response);
        }
    }

}
