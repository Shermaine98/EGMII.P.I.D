/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Print;

import Controller_Base.BaseServlet;
import Database.DBConnectionFactory;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import static java.lang.System.out;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author Geraldine
 */
public class PrintConsumptionReport extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();

        JasperReport jasperReport = null;
        //  JasperDesign jasperDesign = null;
        String productionNumber = request.getParameter("printPONumber");
        int productionNumberInt = Integer.parseInt(productionNumber);

        Map map = new HashMap();
        map.put("prodNum", productionNumberInt);

        String path = getServletContext().getRealPath("Reports/ProductCreation/");
        // jasperDesign = JRXmlLoader.load(path + "ConsumptionReport.jrxml");
        InputStream f = new FileInputStream(new File(path + "/ConsumptionReport.jrxml"));
        try {
            jasperReport = JasperCompileManager.compileReport(f);
        } catch (JRException ex) {
            Logger.getLogger(PrintConsumptionReport.class.getName()).log(Level.SEVERE, null, ex);
        }

        byte[] byteStream = null;
        try {
            byteStream = JasperRunManager.runReportToPdf(jasperReport, map, conn);
        } catch (JRException ex) {
            Logger.getLogger(PrintConsumptionReport.class.getName()).log(Level.SEVERE, null, ex);
        }
        OutputStream outStream = response.getOutputStream();
        response.addHeader("content-disposition", "attachment; filename=ConsumptionReport.pdf");   
        response.setContentType("application/pdf");
        response.setContentLength(byteStream.length);
        outStream.write(byteStream, 0, byteStream.length);
    }
}
