/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Gerard
 */
public class DeliveryInvoiceDetails {
    private int diNumber;
    private int itemCode;
    private double qty;

    /**
     * @return the diNumber
     */
    public int getDiNumber() {
        return diNumber;
    }

    /**
     * @param diNumber the diNumber to set
     */
    public void setDiNumber(int diNumber) {
        this.diNumber = diNumber;
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
}
