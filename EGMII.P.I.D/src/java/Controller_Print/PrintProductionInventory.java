package Controller_Print;

import Controller_Base.BaseServlet;
import Database.DBConnectionFactory;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class PrintProductionInventory extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.reset();
        DBConnectionFactory myFactory = DBConnectionFactory.getInstance();
        Connection conn = myFactory.getConnection();
        OutputStream outStream = response.getOutputStream();
        JasperReport jasperReport = null;

        String path = getServletContext().getRealPath("/Reports/Inventory/");

        Map map = new HashMap();

        InputStream f = new FileInputStream(new File(path + "/ProductionInventory.jrxml"));
        try {
            jasperReport = JasperCompileManager.compileReport(f);
        } catch (JRException ex) {
            Logger.getLogger(PrintProductionInventory.class.getName()).log(Level.SEVERE, null, ex);
        }

        byte[] byteStream = null;
        try {
            byteStream = JasperRunManager.runReportToPdf(jasperReport, map, conn);
        } catch (JRException ex) {
            Logger.getLogger(PrintProductionInventory.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.addHeader("content-disposition", "attachment; filename=ProductionInventory.pdf");
        response.setContentType("application/pdf");
        response.setContentLength(byteStream.length);
        outStream.write(byteStream, 0, byteStream.length);
    }
}
