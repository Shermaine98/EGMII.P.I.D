package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.ProductDAO;
import DAO.ConsumptionReportDAO;
import Model_General.ProductAll;
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
 * @author gcla109
 */
public class SearchProductServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String productName = request.getParameter("query");
        String productName1 = request.getParameter("productName1");

        ArrayList<ProductAll> ProductList = new ArrayList<ProductAll>();
        if (productName == null) {
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

            request.setAttribute("CRPRNumber", numberCR);
            request.setAttribute("ProductList", ProductList);
            RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/ConsumptionReport.jsp");
            rd.forward(request, response);

        } else {
            try {
                ProductList = new ProductDAO().searchProduct(productName);

            } catch (SQLException ex) {
                Logger.getLogger(SearchProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            ArrayList<String> productID = new ArrayList<String>();
            for (int i = 0; i < ProductList.size(); i++) {
                if (!productID.contains(String.valueOf(ProductList.get(i).getProductID()))) {
                    productID.add(String.valueOf(ProductList.get(i).getProductID()));
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
            Gson gson = new Gson();
            request.setAttribute("CRPRNumber", numberCR);
            request.setAttribute("ProductList", ProductList);
            String json = gson.toJson(productID);
            response.getWriter().write("{\"suggestions\":" + json + "}");
        }

    }
}
