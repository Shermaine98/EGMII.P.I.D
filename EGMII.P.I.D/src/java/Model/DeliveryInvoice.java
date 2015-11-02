/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Gerard
 */
public class DeliveryInvoice {
    private int diNumber;
    private int location;
    private int madeBy;
    private int approvedBy;
    private java.sql.Date dateMade;
    private java.sql.Date deliveryDate;
    
     private DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    /**
     * @return the dateMade
     */
    public java.sql.Date getDateMade() {
        return dateMade;
    }

    /**
     * @param dateMade the dateMade to set
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
     * @return the deliveryDate
     */
    public java.sql.Date getDeliveryDate() {
        return deliveryDate;
    }

    /**
     * @param deliveryDate the deliveryDate to set
     */
    public void setDeliveryDate(java.util.Date deliveryDate) throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date madeDate0 = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date madeDate1 = getFormatter().parse(df.format(madeDate0));
        java.sql.Date sqlreceivedDate1 = new java.sql.Date(madeDate1.getTime());
        this.deliveryDate = sqlreceivedDate1;
    }
    
       /**
     * @param deliveryDate the deliveryDate to set
     * @throws java.text.ParseException
     */
    public void setDeliveryDate(String deliveryDate) throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date deliveryDate2 = getFormatter().parse(deliveryDate);
        java.sql.Date deliveryDate1 = new java.sql.Date(deliveryDate2.getTime());
        this.setDeliveryDate(deliveryDate1);
    }
    
    public void setDeliveryDate(java.sql.Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

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
     * @return the madeBy
     */
    public int getMadeBy() {
        return madeBy;
    }

    /**
     * @param madeBy the madeBy to set
     */
    public void setMadeBy(int madeBy) {
        this.madeBy = madeBy;
    }

    /**
     * @return the approvedBy
     */
    public int getApprovedBy() {
        return approvedBy;
    }

    /**
     * @param approvedBy the approvedBy to set
     */
    public void setApprovedBy(int approvedBy) {
        this.approvedBy = approvedBy;
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
    
}
