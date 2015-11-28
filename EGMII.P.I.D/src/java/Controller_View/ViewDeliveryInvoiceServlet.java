package Controller_View;

import Controller_Base.BaseServlet;
import DAO.DeliveryInvoiceDAO;
import DAO.ReplenishmentDAO;
import Model_View.DeliveryInvoiceView;
import Model_View.RepRequestView;
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
public class ViewDeliveryInvoiceServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeliveryInvoiceDAO DeliveryInvoiceDAO = new DeliveryInvoiceDAO();

        String action = request.getParameter("action");
        ServletContext context = getServletContext();

        ReplenishmentDAO ReplenishmentDAO = new ReplenishmentDAO();

        if (action.equalsIgnoreCase("create")) {
            ArrayList<RepRequestView> RepRequestView = new ArrayList<RepRequestView>();
            try {
                RepRequestView = ReplenishmentDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/DeliveryInvoice.jsp");
             request.setAttribute("info", "none");
            request.setAttribute("data", "null");
            request.setAttribute("RepRequestView", RepRequestView);
            rd.forward(request, response);
        }else if (action.equalsIgnoreCase("created")) {
            ArrayList<RepRequestView> RepRequestView = new ArrayList<RepRequestView>();
            try {
                RepRequestView = ReplenishmentDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
                request.setAttribute("info", "success");
            } else if (info.equalsIgnoreCase("error")) {
                request.setAttribute("info", "error");
            } 
            
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/DeliveryInvoice.jsp");
          
            request.setAttribute("data", "null");
            request.setAttribute("RepRequestView", RepRequestView);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("viewSpecific")) {
            ArrayList<RepRequestView> RepRequestView = new ArrayList<RepRequestView>();

            Integer dirNumber = 0;
            try {
                dirNumber = DeliveryInvoiceDAO.getDirNumber();
            } catch (SQLException ex) {
                Logger.getLogger(ViewDeliveryInvoiceServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                RepRequestView = ReplenishmentDAO.ReplenishmentReportView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            String reportID = request.getParameter("reportID");
            ArrayList<RepRequestView> RepRequestViewSpec = new ArrayList<RepRequestView>();
            try {
                RepRequestViewSpec = ReplenishmentDAO.ReplenishmentReportSpecView(Integer.parseInt(reportID));
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("info", "none");
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/DeliveryInvoice.jsp");
            request.setAttribute("dirNumber", dirNumber);
            request.setAttribute("data", "viewSpecific");
            request.setAttribute("RepRequestView", RepRequestView);
            request.setAttribute("RepRequestViewSpec", RepRequestViewSpec);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("approve")) {
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewA = new ArrayList<DeliveryInvoiceView>();

            try {
                DeliveryInvoiceViewA = DeliveryInvoiceDAO.DeliveryInvoiceViewApproval();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ApproveInvoice.jsp");
             request.setAttribute("info", "none");
            request.setAttribute("data", "null");
            request.setAttribute("DeliveryInvoiceViewA", DeliveryInvoiceViewA);
            rd.forward(request, response);
        }else if (action.equalsIgnoreCase("preapprove")) {
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewA2 = new ArrayList<DeliveryInvoiceView>();
            String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
                request.setAttribute("info", "success");
            } else if (info.equalsIgnoreCase("error")) {
                request.setAttribute("info", "error");
            } else if (info.equalsIgnoreCase("rejected")) {
                request.setAttribute("info", "rejected");
            }
            try {
                DeliveryInvoiceViewA2 = DeliveryInvoiceDAO.DeliveryInvoiceViewApproval();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ApproveInvoice.jsp");
           
            request.setAttribute("data", "null");
            request.setAttribute("DeliveryInvoiceViewA", DeliveryInvoiceViewA2);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("viewSpecificApprove")) {
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewA = new ArrayList<DeliveryInvoiceView>();
            String diNumber = request.getParameter("diNumber");
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewSpecA = new ArrayList<DeliveryInvoiceView>();

            try {
                DeliveryInvoiceViewA = DeliveryInvoiceDAO.DeliveryInvoiceViewApproval();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                DeliveryInvoiceViewSpecA = DeliveryInvoiceDAO.DeliveryInvoiceViewSpec(Integer.parseInt(diNumber));
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ApproveInvoice.jsp");
            request.setAttribute("info", "none");
            request.setAttribute("DeliveryInvoiceViewA", DeliveryInvoiceViewA);
            request.setAttribute("data", "viewSpecificApprove");
            request.setAttribute("DeliveryInvoiceViewSpecA", DeliveryInvoiceViewSpecA);
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("view")) {

            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            try {
                DeliveryInvoiceView = DeliveryInvoiceDAO.DeliveryInvoiceView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ViewDeliveryInvoice.jsp");
            request.setAttribute("DeliveryInvoiceView", DeliveryInvoiceView);
            request.setAttribute("data", "null");
            rd.forward(request, response);
        } else if (action.equalsIgnoreCase("viewSpcific")) {
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = new ArrayList<DeliveryInvoiceView>();
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceViewSpecView = new ArrayList<DeliveryInvoiceView>();
            String diNumber = request.getParameter("diNumber");
            try {
                DeliveryInvoiceView = DeliveryInvoiceDAO.DeliveryInvoiceView();
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                DeliveryInvoiceViewSpecView = DeliveryInvoiceDAO.DeliveryInvoiceViewSpec(Integer.parseInt(diNumber));
            } catch (ParseException ex) {
                Logger.getLogger(ViewInventoryReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Delivery/ViewDeliveryInvoice.jsp");
            request.setAttribute("DeliveryInvoiceView", DeliveryInvoiceView);
            request.setAttribute("data", "spec");
            request.setAttribute("DeliveryInvoiceSpec", DeliveryInvoiceViewSpecView);
            rd.forward(request, response);
        }

    }
}
