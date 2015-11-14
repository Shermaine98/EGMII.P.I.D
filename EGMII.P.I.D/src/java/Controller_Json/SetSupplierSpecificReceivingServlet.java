package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import Model_View.SupplierPurchaseOrderView;
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
public class SetSupplierSpecificReceivingServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderList = new ArrayList<>();
        SupplierPurchaseOrderDAO SupplierPurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        //SupplierDeliveryReceiptDAO SupplierDeliveryReceiptDAO = new SupplierDeliveryReceiptDAO();
        String poNumber = request.getParameter("hiddenValueReceiving");

        SupplierPurchaseOrderList = SupplierPurchaseOrderDAO.getSPOReceiving(Integer.parseInt(poNumber));
        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        try {
            PurchaseOrderList = SupplierPurchaseOrderDAO.GetSupplierPurchaseOrderForReceiving();
        } catch (ParseException ex) {
            Logger.getLogger(SetSupplierSpecificReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierReceiving.jsp");

        request.setAttribute("Receiving", PurchaseOrderList);
        request.setAttribute("receivingData", "receiving");
        request.setAttribute("SupplierPurchaseOrderReceiving", SupplierPurchaseOrderList);

        rd.forward(request, response);

    }

}
