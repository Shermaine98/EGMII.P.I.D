package Model_View;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class RepRequestView {
    private int repID;
    private int version;
    private String branchName;
    private int supervisor;
    private java.sql.Date dateMade;
    private String productName;
    private int productID;
    private String color;
    private String size;
    private double qty;
    private int location;
    private String address;
    private int promo;
    
    
    
    
    private DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    /**
     * @return the dateMade
     */
    public java.sql.Date getDateMade() {
        return dateMade;
    }

    /**
     * @throws java.text.ParseException
     */
    public void setDateMade() throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date madeDate0 = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date madeDate1 = getFormatter().parse(df.format(madeDate0));
        java.sql.Date sqlreceivedDate1 = new java.sql.Date(madeDate1.getTime());
        this.dateMade = sqlreceivedDate1;
    }
    
         /**
     * @param deliveryDate the deliveryDate to set
     * @throws java.text.ParseException
     */
    public void setDateMade(java.util.Date dateMade) throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date madeDate0 = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date madeDate1 = getFormatter().parse(df.format(madeDate0));
        java.sql.Date sqlreceivedDate1 = new java.sql.Date(madeDate1.getTime());
        this.dateMade = sqlreceivedDate1;
    }

    /**
     * @return the version
     */
    public int getVersion() {
        return version;
    }

    /**
     * @param version the version to set
     */
    public void setVersion(int version) {
        this.version = version;
    }

    /**
     * @return the branchName
     */
    public String getBranchName() {
        return branchName;
    }

    /**
     * @param branchName the branchName to set
     */
    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    /**
     * @return the supervisor
     */
    public int getSupervisor() {
        return supervisor;
    }

    /**
     * @param supervisor the supervisor to set
     */
    public void setSupervisor(int supervisor) {
        this.supervisor = supervisor;
    }

    /**
     * @return the formatter
     */
    public DateFormat getFormatter() {
        return formatter;
    }

    /**
     * @param formatter the formatter to set
     */
    public void setFormatter(DateFormat formatter) {
        this.formatter = formatter;
    }

    /**
     * @return the repID
     */
    public int getRepID() {
        return repID;
    }

    /**
     * @param repID the repID to set
     */
    public void setRepID(int repID) {
        this.repID = repID;
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the productID
     */
    public int getProductID() {
        return productID;
    }

    /**
     * @param productID the productID to set
     */
    public void setProductID(int productID) {
        this.productID = productID;
    }

    /**
     * @return the color
     */
    public String getColor() {
        return color;
    }

    /**
     * @param color the color to set
     */
    public void setColor(String color) {
        this.color = color;
    }

    /**
     * @return the size
     */
    public String getSize() {
        return size;
    }

    /**
     * @param size the size to set
     */
    public void setSize(String size) {
        this.size = size;
    }

    /**
     * @return the qty
     */
    public double getQty() {
        return qty;
    }

    /**
     * @param qty the qty to set
     */
    public void setQty(double qty) {
        this.qty = qty;
    }

    /**
     * @return the location
     */
    public int getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(int location) {
        this.location = location;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the promo
     */
    public int getPromo() {
        return promo;
    }

    /**
     * @param promo the promo to set
     */
    public void setPromo(int promo) {
        this.promo = promo;
    }

}
