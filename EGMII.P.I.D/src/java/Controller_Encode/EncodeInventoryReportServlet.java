package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import DAO.InventoryReportDAO;
import DAO.InventoryRetailDAO;
import Model.InventoryReport;
import Model.InventoryReportDetails;
import Model.User;
import Model_View.WarehouseInventoryView;
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
public class EncodeInventoryReportServlet extends BaseServlet {

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

        InventoryReport ir = new InventoryReport();
        InventoryRetailDAO retailDAO = new InventoryRetailDAO();
        InventoryDAO invDAO = new InventoryDAO();
        InventoryReportDAO dao = new InventoryReportDAO();
        User user = (User) request.getSession().getAttribute("login");
        String[] begQty = request.getParameterValues("begQty");
        String[] pulledOut = request.getParameterValues("pulledQty");
        String[] soldQty = request.getParameterValues("soldQty");
        String[] itemCode = request.getParameterValues("itemCode");

        int reportID = 0;
        try {
            reportID = dao.getReportId();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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
                if (x) {
                    double endingQty = Double.parseDouble(begQty[i]) - (Double.parseDouble(soldQty[i]) + Double.parseDouble(pulledOut[i]));
                    try {
                        retailDAO.updateRetailInventoryQty(endingQty, user.getLocationID(), Integer.parseInt(itemCode[i]));
                    } catch (ParseException ex) {
                        Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    WarehouseInventoryView newWarehouse = new WarehouseInventoryView();
                    try {
                        newWarehouse = invDAO.GetWarehouseInventorySpecific(ird.getItemCode());
                    } catch (ParseException ex) {
                        Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    double result = newWarehouse.getQty() + ird.getPulledOutQty();
                    try {
                        invDAO.updateInventory(result, ird.getItemCode());
                    } catch (ParseException ex) {
                        Logger.getLogger(EncodeInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }

        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/ViewInventoryReportServlet?action=view");
            request.setAttribute("InventoryReport", ir);
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Error.jsp");
            request.setAttribute("Error", "Error");
            rd.forward(request, response);
        }
    }
}
