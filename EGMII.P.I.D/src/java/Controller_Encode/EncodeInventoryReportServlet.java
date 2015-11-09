package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryReportDAO;
import DAO.ProductDAO;
import Model.ConsumptionReport;
import Model.ConsumptionReportDetails;
import Model.InventoryReport;
import Model.InventoryReportDetails;
import Model.User;
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
public class EncodeInventoryReportServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            boolean x = false;

            InventoryReport ir = new InventoryReport();

            InventoryReportDAO dao = new InventoryReportDAO();
            User user = (User) request.getSession().getAttribute("login");
            String[] pulledOut = request.getParameterValues("pulledQty");
            String[] soldQty = request.getParameterValues("soldQty");
            String[] itemCode = request.getParameterValues("itemCode");

            int reportID = dao.getReportId();

            //Setting IR values
            ir.setReportID(reportID);
            ir.setPromo(user.getEmployeeNumber());
            ir.setLocation(user.getLocationID());

            try {
                ir.setDateMade();
            } catch (ParseException ex) {
                Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            x = dao.EncodeInventoryReport(ir);
            if (x) {
                //Setting IRD values

                for (int i = 0; i < pulledOut.length; i++) {
                    InventoryReportDetails ird = new InventoryReportDetails();
                    ird.setReportID(reportID);
                    System.out.println(itemCode[i]);
                    ird.setItemCode(Integer.parseInt(itemCode[i]));
                    ird.setSoldQty(Double.parseDouble(soldQty[i]));
                    ird.setPulledOutQty(Double.parseDouble(pulledOut[i]));
                    x = dao.EncodeInventoryReportDetials(ird);
                }
                if (x) {
                    ServletContext context = getServletContext();
                    RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
                    request.setAttribute("InventoryReport", ir);
                    rd.forward(request, response);
                } else {
                    ServletContext context = getServletContext();
                    RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
                    rd.forward(request, response);
                }
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
