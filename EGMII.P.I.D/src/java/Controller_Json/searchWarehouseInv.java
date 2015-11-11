package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.InventoryDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gcla109
 */
public class searchWarehouseInv extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String productName1 = request.getParameter("query");

        try (PrintWriter out = response.getWriter()) {
            ArrayList<String> productName = new InventoryDAO().searchWarehouse(productName1);
            ArrayList<String> productNameList = new ArrayList<String>();
           
             for (int i=0; i<productName.size();i++){
                if (!productNameList.contains(productName.get(i))) {
                    productNameList.add(productName.get(i));
                }
             }
            Gson gson = new Gson();
            String json = gson.toJson(productNameList);
            response.getWriter().write("{\"suggestions\":" + json + "}");
        } catch (ParseException ex) {
            Logger.getLogger(searchWarehouseInv.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
