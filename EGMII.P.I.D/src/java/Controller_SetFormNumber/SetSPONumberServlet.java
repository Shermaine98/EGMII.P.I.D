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
 * @author Dimaandal
 *
 */
public class SetSPONumberServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        SupplierPurchaseOrderDAO DAO = new SupplierPurchaseOrderDAO();
        Integer SupplierpurchaseOrder = 0;
        String action = request.getParameter("action");

        try {
            SupplierpurchaseOrder = DAO.getSupplierPurchaseOrderNumber();

        } catch (SQLException ex) {
            Logger.getLogger(SetSPONumberServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierPurchaseOrder.jsp");
        request.setAttribute("SPONumber", SupplierpurchaseOrder);

        if (action.equalsIgnoreCase("create")) {
            request.setAttribute("info", "none");
            rd.forward(request, response);

        } else {

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
