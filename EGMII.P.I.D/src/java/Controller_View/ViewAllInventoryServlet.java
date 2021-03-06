package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import Model_View.RawMaterialsInventoryView;
import Model_View.WarehouseInventoryView;
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
public class ViewAllInventoryServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryDAO DAO = new InventoryDAO();
        ArrayList<RawMaterialsInventoryView> AccessoriesInventoryList = new ArrayList<RawMaterialsInventoryView>();
        ArrayList<RawMaterialsInventoryView> ProductionInventoryList = new ArrayList<RawMaterialsInventoryView>();
        ArrayList<WarehouseInventoryView> WarehouseInventoryList = new ArrayList<WarehouseInventoryView>();
        try {
            AccessoriesInventoryList = DAO.GetAccessoriesInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewAccessoriesInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            ProductionInventoryList = DAO.GetProductionInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewAccessoriesInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            WarehouseInventoryList = DAO.GetWarehouseInventory();
        } catch (ParseException ex) {
            Logger.getLogger(ViewAccessoriesInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();

        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/ViewAllInventory.jsp");
        request.setAttribute("AccessoriesInventoryList", AccessoriesInventoryList);
        request.setAttribute("ProductionInventoryList", ProductionInventoryList);
        request.setAttribute("WarehouseInventoryList", WarehouseInventoryList);
        rd.forward(request, response);
    }
}
