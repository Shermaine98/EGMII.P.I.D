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
public class InventoryReportDetails {
    private int reportID;
    private int itemCode;
    private double soldQty;
    private double pulledOutQty;

    /**
     * @return the reportID
     */
    public int getReportID() {
        return reportID;
    }

    /**
     * @param reportID the reportID to set
     */
    public void setReportID(int reportID) {
        this.reportID = reportID;
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
     * @return the soldQty
     */
    public double getSoldQty() {
        return soldQty;
    }

    /**
     * @param soldQty the soldQty to set
     */
    public void setSoldQty(double soldQty) {
        this.soldQty = soldQty;
    }

    /**
     * @return the pulledOutQty
     */
    public double getPulledOutQty() {
        return pulledOutQty;
    }

    /**
     * @param pulledOutQty the pulledOutQty to set
     */
    public void setPulledOutQty(double pulledOutQty) {
        this.pulledOutQty = pulledOutQty;
    }
    
}
