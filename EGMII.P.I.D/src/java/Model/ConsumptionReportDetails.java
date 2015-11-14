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
public class ConsumptionReportDetails {
    private int productionNumber;
    private int itemCode;
    private double qty;
    private double deliveredQty;

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
     * @return the deliveredQty
     */
    public double getDeliveredQty() {
        return deliveredQty;
    }

    /**
     * @param deliveredQty the deliveredQty to set
     */
    public void setDeliveredQty(double deliveredQty) {
         deliveredQty = Math.round(deliveredQty*100.0)/100.0;
        this.deliveredQty = deliveredQty;
    }
    
}
