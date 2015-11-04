/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model_View;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Gerard
 */
public class ConsumptionReportView {
    private int productionNumber;
    private int preparedBy;
    private java.sql.Date dateMade;
    private String status;
    private int itemCode;
    private double qty;
    
    private String productName;
    private String color;
    private String size;
    private String itemName;
    private String unitMeasurement;
    
   

    private DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * @return the productionNumber
     */
    public int getProductionNumber() {
        return productionNumber;
    }

    /**
     * @param productionNumber set the productionNumber
     */
    public void setProductionNumber(int productionNumber) {
        this.productionNumber = productionNumber;
    }


    /**
     * @return the dateMade
     */
    public Date getDateMade() {
        return dateMade;
    }

    /**
     * @param dateMade set the dateMade
     */
    public void setDateMade() throws ParseException {
        java.util.Date currentDate = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date currentDate1 = getFormatter().parse(df.format(currentDate));
        java.sql.Date sqlDate = new java.sql.Date(currentDate1.getTime());
        this.setDateMade(sqlDate);
    }

    /**
     * @return the preparedBy
     */
    public int getPreparedBy() {
        return preparedBy;
    }

    /**
     * @param preparedBy set the preparedBy
     */
    public void setPreparedBy(int preparedBy) {
        this.preparedBy = preparedBy;
    }
    
    /**
     * @param dateMade the dateMade to set
     */
    public void setDateMade(java.sql.Date dateMade) {
        this.dateMade = dateMade;
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
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
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
     * @return the itemName
     */
    public String getItemName() {
        return itemName;
    }

    /**
     * @param itemName the itemName to set
     */
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    /**
     * @return the unitMeasurement
     */
    public String getUnitMeasurement() {
        return unitMeasurement;
    }

    /**
     * @param unitMeasurement the unitMeasurement to set
     */
    public void setUnitMeasurement(String unitMeasurement) {
        this.unitMeasurement = unitMeasurement;
    }
}
