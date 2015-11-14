package Model;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 * @author Dimaandal
 *
 */
public class CuttingReportDetails {
    private int cuttingNumber;
    private int poNumber;
    private int itemCode;
    private double qty;
    private String notes;

    /**
     * @return the cuttingNumber
     */
    public int getCuttingNumber() {
        return cuttingNumber;
    }

    /**
     * @param cuttingNumber the cuttingNumber to set
     */
    public void setCuttingNumber(int cuttingNumber) {
        this.cuttingNumber = cuttingNumber;
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
        qty = Math.round(qty*100.0)/100.0;
        this.qty = qty;
    }

    /**
     * @return the notes
     */
    public String getNotes() {
        return notes;
    }

    /**
     * @param notes the notes to set
     */
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
}
