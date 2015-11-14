package Controller_Approve;

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
 * @author Geraldine
 */
public class ApproveSupplierPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierPurchaseOrderDAO PurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        PurchaseOrderList = PurchaseOrderDAO.GetAllSupplierPurchaseOrderForApproval();

        if (!PurchaseOrderList.isEmpty()) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierApproval.jsp");
            request.setAttribute("data", "null");
            request.setAttribute("SupplierPurchaseOrderList", PurchaseOrderList);
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Error.jsp");
            request.setAttribute("Error", "Error");
            rd.forward(request, response);
        }
    }
}
