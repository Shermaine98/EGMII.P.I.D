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

public class DeliveryReceiptDetails {
    private int drNumber;
    private int itemCode;
    private double qty;

    /**
     * @return the drNumber
     */
    public int getDrNumber() {
        return drNumber;
    }

    /**
     * @param drNumber the drNumber to set
     */
    public void setDrNumber(int drNumber) {
        this.drNumber = drNumber;
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
    
}
