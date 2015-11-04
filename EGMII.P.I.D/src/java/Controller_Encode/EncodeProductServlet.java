package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ProductDAO;
import DAO.RefSizesDAO;
import Model.Product;
import Model.ProductBM;
import Model.ProductTypeSize;
import java.io.IOException;
import java.sql.SQLException;
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
 * @author
 *
 */
public class EncodeProductServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

     //   ProductBM productBM = new ProductBM();
        ArrayList<ProductBM> ProductListBM = new ArrayList<>();
        ArrayList<Product> ProductList = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        ArrayList<String> productTypeSize = new ArrayList<>();
        RefSizesDAO refSizeDAO = new RefSizesDAO();

        String productName = request.getParameter("productName");
        System.out.println(productName);
        String productType = request.getParameter("productType");
        String color = request.getParameter("color");
        String inventoryType = request.getParameter("inventoryType");
        ProductBM productBM = new ProductBM();
        //itemCode   
        String[] itemCode = request.getParameterValues("itemCode");
        String[] itemConsumption = request.getParameterValues("itemConsumption");
        String[] unitMeasurement = request.getParameterValues("unitMeasurement");

        //fabric  
        String[] itemCodefabric = request.getParameterValues("fabricCode");
        String[] unitMeasurementfabric = request.getParameterValues("unitMeasurement");
        String[] size = request.getParameterValues("size");
        String[] itemConsumptionfabric = request.getParameterValues("fabricItemConsumption");
        for (int i = 0; i < itemConsumptionfabric.length; i++) {

            System.out.println("PRINT" + itemConsumptionfabric[i]);

        }

        try {
            //get sizes
            productTypeSize = refSizeDAO.GetAllSizes(productType);

        } catch (ParseException ex) {
            Logger.getLogger(EncodeProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        Integer productNumber = 0;
        try {
            productNumber = productDAO.getProductNumber();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean x = false;

        //encode Product    
        for (int i = 0; i < productTypeSize.size(); i++) {
            Product product = new Product();
            if (i == 0 || x == true) {
                product.setSize(productTypeSize.get(i));
                product.setItemCode(productNumber);
                product.setProductName(productName);
                product.setProductType(productType);
                product.setColor(color);
                product.setInventoryType(inventoryType);
                System.out.println(productNumber);
                if (productDAO.EncodeProduct(product)) {
                    x = true;
                    ProductList.add(product);
                    System.out.println("wat to pasok" + ProductList.get(i).getItemCode());
                    productNumber++;
                } else {
                    x = false;
                }
            }
        }
        System.out.println(itemCode.length);
        System.out.println("productList size: " + ProductList.size());
        //encode ProductBM
        if (x == true) {
            for (int a = 0; a < ProductList.size(); a++) {
                System.out.println("1st" + ProductList.get(a).getItemCode());
                if (a == 0 || x == true) {
                    for (int y = 0; y < itemCode.length; y++) {
                        productBM.setProductID(ProductList.get(a).getItemCode());
                        System.out.println("itmeCOde" + ProductList.get(a).getItemCode());
                        productBM.setItemCode(Integer.parseInt(itemCode[y]));
                        productBM.setQty(Integer.parseInt(itemConsumption[y]));

                        if (productDAO.EncodeProductBM(productBM)) {
                            x = true;
                            ProductListBM.add(productBM);
                        } else {
                            x = false;
                        }
                    }
                }
            }
            
          for (int i = 0; i < itemCodefabric.length; i++) {
                productBM.setItemCode(Integer.parseInt(itemCodefabric[i]));
                for (int y = 0; y < ProductList.size(); y++) {
                    if (y == 0 || x == true) {
                        int input = y + (i * ProductList.size());
                        productBM.setProductID(ProductList.get(y).getItemCode());
                        productBM.setQty(Integer.parseInt(itemConsumptionfabric[input]));
                        System.out.println(itemConsumptionfabric[y]);
                        System.out.println("input: "+ input);
                        if (productDAO.EncodeProductBM(productBM)) {
                            x = true;
                            ProductListBM.add(productBM);
                        } else {
                            x = false;
                        }
                    }
                }
            }  
            
//            int k=0;
//             for(int z =0; z < itemCodefabric.length;z++){
//            int itemCodeTrial = Integer.parseInt(itemCodefabric[z]);
//            for (int i = 0; i < ProductList.size(); i++) {
//                    for ( int y = k; y < itemConsumptionfabric.length; k++) {
//                        ProductBM productBM = new ProductBM();
//                        System.out.print("ENTER" + ProductList.get(i).getItemCode());
//                        productBM.setProductID(ProductList.get(i).getItemCode());
//                        productBM.setItemCode(itemCodeTrial);
//                        productBM.setQty(Integer.parseInt(itemConsumptionfabric[y]));
//                         System.out.print("number" + ProductList.get(i).getItemCode());
//                         System.out.print("length" + itemConsumptionfabric.length);
//                        System.out.print("itemConsumption" + itemConsumptionfabric[y]);
//                         k=y;
//                        if (productDAO.EncodeProductBM(productBM)) {
//                        x = true;
//                        ProductListBM.add(productBM);
//                    } else {
//                        x = false;
//                    }
//                    }
//                    
//                }
//            
//          }
        }

        if (x == true) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
            request.setAttribute("productBM", ProductListBM);
            request.setAttribute("productList", ProductList);
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
            rd.forward(request, response);

        }

    }

}
