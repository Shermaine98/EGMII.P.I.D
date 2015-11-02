package Controller_SetFormNumber;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import java.io.IOException;
import java.sql.SQLException;
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
 *
 */
public class SetSPONumberServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        SupplierPurchaseOrderDAO DAO = new SupplierPurchaseOrderDAO();
        Integer SupplierpurchaseOrder=0;
        try {
            SupplierpurchaseOrder = DAO.getSupplierPurchaseOrderNumber();
            
        } catch (SQLException ex) {
            Logger.getLogger(SetSPONumberServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        ServletContext context = getServletContext();

        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierPurchaseOrder.jsp");
        request.setAttribute("SPONumber",SupplierpurchaseOrder );
    
        rd.forward(request, response);

    }
}
