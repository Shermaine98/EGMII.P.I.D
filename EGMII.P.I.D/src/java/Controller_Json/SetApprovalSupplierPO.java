package Controller_Json;

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
public class SetApprovalSupplierPO extends BaseServlet {

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

        String poNumber = request.getParameter("hiddenValue");
        SupplierPurchaseOrderList = SupplierPurchaseOrderDAO.getSupplierPurchaseNumber(Integer.parseInt(poNumber));
        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        PurchaseOrderList = SupplierPurchaseOrderDAO.GetAllSupplierPurchaseOrderForApproval();
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierApproval.jsp");
        request.setAttribute("SupplierPurchaseOrderList", PurchaseOrderList);
        request.setAttribute("data", "supplier");
        request.setAttribute("SupplierPurchaseOrderSpecific", SupplierPurchaseOrderList);
        rd.forward(request, response);

    }

}
