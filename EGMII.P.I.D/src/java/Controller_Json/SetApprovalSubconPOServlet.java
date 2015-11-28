package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.SubconPurchaseOrderDAO;
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
public class SetApprovalSubconPOServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        SubconPurchaseOrderDAO PurchaseOrderDAO = new SubconPurchaseOrderDAO();
        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        ArrayList<SubconPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        PurchaseOrderList = PurchaseOrderDAO.GetAllSubconPurchaseOrderForApproval();

        String poNumber = request.getParameter("hiddenValue");
        String productionNumber = request.getParameter("productionNumber");

        ArrayList<SubconPurchaseOrderView> SubconPurchaseOrderSpecific = new ArrayList<>();
        ArrayList<ConsumptionReportView> CRforSizes = new ArrayList();
        ArrayList<SubconPurchaseOrderView> CRHeader = new ArrayList<>();
        SubconPurchaseOrderSpecific = PurchaseOrderDAO.getSubconPurchaseNumberView(Integer.parseInt(poNumber));

        try {
            CRforSizes = DAO.GetCRForSizes(Integer.parseInt(productionNumber));
            CRHeader = PurchaseOrderDAO.getSubconHeader(Integer.parseInt(poNumber));

        } catch (ParseException ex) {
            Logger.getLogger(SetApprovalSubconPOServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconApproval.jsp");
         request.setAttribute("info", "none");
        request.setAttribute("PurchaseOrderList", PurchaseOrderList);
        request.setAttribute("data", "subconApproval");
        request.setAttribute("SubconPurchaseOrderSpecific", SubconPurchaseOrderSpecific);
        request.setAttribute("CRforSizes", CRforSizes);
        request.setAttribute("CRHeader", CRHeader);

        rd.forward(request, response);

    }

}
