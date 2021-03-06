package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import Model_View.RawMaterialsInventoryView;
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
public class ViewProductionInventoryServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryDAO InventoryDAO = new InventoryDAO();
        ArrayList<RawMaterialsInventoryView> ProductionInventoryList = new ArrayList<RawMaterialsInventoryView>();
        try {
            ProductionInventoryList = InventoryDAO.GetProductionInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewProductionInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();

        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/ProductionInventory.jsp");
        request.setAttribute("ProductionInventoryList", ProductionInventoryList);
        rd.forward(request, response);
    }

}
