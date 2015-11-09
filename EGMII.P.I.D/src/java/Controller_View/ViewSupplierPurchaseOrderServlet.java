package Controller_View;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.ConsumptionReport;
import Model.PurchaseOrder;
import Model_View.ConsumptionReportView;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
public class ViewSupplierPurchaseOrderServlet extends BaseServlet {

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
