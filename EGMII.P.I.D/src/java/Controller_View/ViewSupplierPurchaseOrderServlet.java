package Controller_View;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.util.ArrayList;
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
public class ViewSupplierPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String poNumber = request.getParameter("poNumber");

        SupplierPurchaseOrderDAO DAO = new SupplierPurchaseOrderDAO();

        ArrayList<SupplierPurchaseOrderView> supplierPurchaseOrder = new ArrayList();

        supplierPurchaseOrder = DAO.GetAllSupplierPurchaseView();

        if (poNumber != null) {
            ArrayList<SupplierPurchaseOrderView> PurchaseOrderSpecific = new ArrayList();

            PurchaseOrderSpecific = DAO.getSupplierPurchaseNumberView(Integer.parseInt(poNumber));

            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/ViewSupplierPurhcaseOrder.jsp");
            request.setAttribute("data", "SupplierPurchaseOrderSpecific");
            request.setAttribute("SupplierPurchaseOrderSpecific", PurchaseOrderSpecific);
            request.setAttribute("SupplierPurchaseOrder", supplierPurchaseOrder);
            rd.forward(request, response);

        } else {

            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/ViewSupplierPurhcaseOrder.jsp");
            request.setAttribute("data", "SupplierPurchaseOrder");
            request.setAttribute("SupplierPurchaseOrder", supplierPurchaseOrder);
            rd.forward(request, response);

        }
    }
}
