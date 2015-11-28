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
public class SetSupplierReceivingServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierPurchaseOrderDAO SupplierPurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderView = new ArrayList<>();
        String action = request.getParameter("action");
        try {
            SupplierPurchaseOrderView = SupplierPurchaseOrderDAO.GetSupplierPurchaseOrderForReceiving();
        } catch (ParseException ex) {
            Logger.getLogger(SetSupplierReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierReceiving.jsp");
        request.setAttribute("receivingData", "null");
      
        request.setAttribute("Receiving", SupplierPurchaseOrderView);
        
        if(action.equalsIgnoreCase("receive")){
         request.setAttribute("info", "none");
         rd.forward(request, response);
        
        }else{
              String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
                request.setAttribute("info", "success");
            } else if (info.equalsIgnoreCase("error")) {
                request.setAttribute("info", "error");
            } 
            rd.forward(request, response);
        
        }
       
    }
}
