package Controller_Approve;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import java.io.IOException;
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
public class ApproveRejectSPOServlet extends BaseServlet {

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
        PurchaseOrder purchaseOrder = new PurchaseOrder();
        int PoNumber = Integer.parseInt(request.getParameter("poNumber"));
        String action = request.getParameter("action");

        if (action.equals("approve")) {
            int employeeNumber = Integer.parseInt(request.getParameter("employeeNumber"));
            purchaseOrder.setApprovedBy(employeeNumber);
            purchaseOrder.setPoNumber(PoNumber);
            boolean x = false;
            try {
                x = PurchaseOrderDAO.updateApproval(purchaseOrder);
            } catch (ParseException ex) {
                Logger.getLogger(ApproveRejectSPOServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (x) {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSupplierPurchaseOrderServlet?action=preapprove");
                request.setAttribute("info", "success");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSupplierPurchaseOrderServlet?action=error");
                request.setAttribute("info", "Error");
                rd.forward(request, response);
            }
        }
        else if(action.equals("reject")){
            boolean x = PurchaseOrderDAO.rejectSupplierDetails(PoNumber);
            boolean y = PurchaseOrderDAO.rejectSupplierPurchaseOrder(PoNumber);
            
            if (x && y) {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSupplierPurchaseOrderServlet?action=rejected");
                request.setAttribute("info", "Rejected");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/ApproveSupplierPurchaseOrderServlet?action=error");
                request.setAttribute("info", "Error");
                rd.forward(request, response);
            }
        }
    }
}
