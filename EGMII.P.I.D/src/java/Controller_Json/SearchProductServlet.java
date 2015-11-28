package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.ProductDAO;
import DAO.ConsumptionReportDAO;
import Model_View.ProductAll;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.SQLException;
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
public class SearchProductServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ProductAll> productALLAccessories = new ArrayList<ProductAll>();
        ArrayList<ProductAll> productALLProduction = new ArrayList<ProductAll>();
        String productName = request.getParameter("query");
        String productName1 = request.getParameter("productName1");

        String action = (String) request.getParameter("action");

        ProductDAO productDAO = new ProductDAO();
        ArrayList<ProductAll> ProductList = new ArrayList<ProductAll>();

        if (productName == null) {
            if (action.equalsIgnoreCase("specific")) {
                String productNameSpecific = (String) request.getAttribute("productNameSpecific");
                productName1 = productNameSpecific;
                request.setAttribute("info", "Success");
            } else {
                request.setAttribute("info", "none");
            }
            ServletContext context = getServletContext();
            try {
                ProductList = new ProductDAO().searchProduct(productName1);
            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            ConsumptionReportDAO DAO = new ConsumptionReportDAO();
            Integer numberCR = 0;
            try {
                numberCR = DAO.getProductionNumber();

            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                productALLAccessories = productDAO.GetAccessoriesInventory(productName1);
                productALLProduction = productDAO.GetProductionInventory(productName1);
            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("CRPRNumber", numberCR);
            request.setAttribute("AccessoriesInventory", productALLAccessories);
            request.setAttribute("ProductionInventory", productALLProduction);
            request.setAttribute("ProductList", ProductList);
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ConsumptionReport.jsp");
            rd.forward(request, response);

        } else {
            try {
                ProductList = new ProductDAO().searchProduct(productName);

            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            ArrayList<String> productNameFilter = new ArrayList<String>();
            for (int i = 0; i < ProductList.size(); i++) {
                if (!productNameFilter.contains(ProductList.get(i).getProductName())) {
                    productNameFilter.add(ProductList.get(i).getProductName());
                }
            }
            //Create Production Number
            ConsumptionReportDAO DAO = new ConsumptionReportDAO();
            Integer numberCR = 0;
            try {
                numberCR = DAO.getProductionNumber();

            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                productALLAccessories = productDAO.GetAccessoriesInventory(productName);
                productALLProduction = productDAO.GetProductionInventory(productName);
            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            Gson gson = new Gson();
            request.setAttribute("CRPRNumber", numberCR);
            request.setAttribute("AccessoriesInventory", productALLAccessories);
            request.setAttribute("ProductionInventory", productALLProduction);
            request.setAttribute("ProductList", ProductList);
            String json = gson.toJson(productNameFilter);
            response.getWriter().write("{\"suggestions\":" + json + "}");
        }

    }
}
