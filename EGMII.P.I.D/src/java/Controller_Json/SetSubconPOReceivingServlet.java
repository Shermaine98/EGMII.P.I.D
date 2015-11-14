package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.SubconDeliveryReceiptDAO;
import DAO.SubconPurchaseOrderDAO;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.ConsumptionReportDetails;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
import Model_View.SubconPurchaseOrderView;
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
public class SetSubconPOReceivingServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        SubconPurchaseOrderDAO PurchaseOrderDAO = new SubconPurchaseOrderDAO();
        
        ArrayList<SubconPurchaseOrderView> SubconPOApproved = new ArrayList<>();
        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        SubconDeliveryReceiptDAO deliveryDAO = new SubconDeliveryReceiptDAO();
        ArrayList<ConsumptionReportView> CRforSizesA = new ArrayList();
        ArrayList<SubconPurchaseOrderView> CRHeaderA = new ArrayList<>();
        ArrayList<ConsumptionReportDetails> CRdelivered = new ArrayList();

        SubconPOApproved = PurchaseOrderDAO.GetAllSubconPurchaseOrderApproved();

        if (action.equalsIgnoreCase("view")) {
            request.setAttribute("SubconPOApproved", SubconPOApproved);
            request.setAttribute("data", "null");
        } else if (action.equalsIgnoreCase("viewSpecific")) {
            String poNumber = request.getParameter("hiddenValue");
            String productionNumber = request.getParameter("productionNumber");

            try {
                CRforSizesA = DAO.GetCRForSizes(Integer.parseInt(productionNumber));
                CRHeaderA = PurchaseOrderDAO.getSubconHeader(Integer.parseInt(poNumber));
                CRdelivered =deliveryDAO.getConsumptionQuantity(Integer.parseInt(productionNumber));

            } catch (ParseException ex) {
                Logger.getLogger(SetSubconPOReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("SubconPOApproved", SubconPOApproved);
            request.setAttribute("CRforSizesA", CRforSizesA);
            request.setAttribute("CRHeaderA", CRHeaderA);
            request.setAttribute("CRdelivered", CRdelivered);
            request.setAttribute("data", "subconApproval");
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconReceiving.jsp");
        rd.forward(request, response);
    }
}
