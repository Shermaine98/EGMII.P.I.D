package Model_View;

import java.sql.Date;
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
public class DeliveryReceiptAll {
    private int drNumber;
    private int poNumber;
    private boolean isSupplier;
    private int productionNumber;
    private int receivedBy;
    private Date dateReceived;
    private String note;
    private int itemCode;
    private double qty;
    private String name;
    
    private DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    /**
     * @return the drNumber
     */
    public int getDrNumber(){
        return drNumber;
    }
    
    /**
     * @param drNumber set a value to drNumber
     */
    public void setDrNumber(int drNumber){
        this.drNumber = drNumber;
    }
    
    /**
     * @return the dateMade
     */
    public java.sql.Date getDateReceived(){
        return dateReceived;
    }
    
    /**
     * @throws java.text.ParseException
     */
    public void setDateReceived() throws ParseException{
        java.util.Date currentDate = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date currentDate1 = getFormatter().parse(df.format(currentDate));
        java.sql.Date sqlDate = new java.sql.Date(currentDate1.getTime());
        this.dateReceived = sqlDate;
    }

    /**
     * @return the poNumber
     */
    public int getPoNumber() {
        return poNumber;
    }

    /**
     * @param poNumber the poNumber to set
     */
    public void setPoNumber(int poNumber) {
        this.poNumber = poNumber;
    }

    /**
     * @return the isSupplier
     */
    public boolean isIsSupplier() {
        return isSupplier;
    }

    /**
     * @param isSupplier the isSupplier to set
     */
    public void setIsSupplier(boolean isSupplier) {
        this.isSupplier = isSupplier;
    }

    /**
     * @return the productionNumber
     */
    public int getProductionNumber() {
        return productionNumber;
    }

    /**
     * @param productionNumber the productionNumber to set
     */
    public void setProductionNumber(int productionNumber) {
        this.productionNumber = productionNumber;
    }

    /**
     * @return the receivedBy
     */
    public int getReceivedBy() {
        return receivedBy;
    }

    /**
     * @param receivedBy the receivedBy to set
     */
    public void setReceivedBy(int receivedBy) {
        this.receivedBy = receivedBy;
    }

    /**
     * @return the note
     */
    public String getNote() {
        return note;
    }

    /**
     * @param note the note to set
     */
    public void setNote(String note) {
        this.note = note;
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
     * @return the itemCode
     */
    public int getItemCode() {
        return itemCode;
    }

    /**
     * @param itemCode the itemCode to set
     */
    public void setItemCode(int itemCode) {
        this.itemCode = itemCode;
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
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    
}
