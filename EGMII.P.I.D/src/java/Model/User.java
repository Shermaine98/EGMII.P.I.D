package Model;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
 public  class  User implements Serializable {

    private int employeeNumber;
    private String lastName;
    private String firstName;
    private String position;
    private String gender;
    private java.sql.Date birthDate;
    private java.sql.Date entryDate;
    private java.sql.Date leftDate;
    private String email;
    private String password;

    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * @return the employeeNumber
     */
    public int getEmployeeNumber() {
        return employeeNumber;
    }

    /**
     * @param employeeNumber the employeeNumber to set
     */
    public void setEmployeeNumber(int employeeNumber) {
        this.employeeNumber = employeeNumber;
    }

    /**
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName.substring(0, 1).toUpperCase() + lastName.substring(1).toLowerCase();
    }

    /**
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName.substring(0, 1).toUpperCase() + firstName.substring(1).toLowerCase();
    }

    /**
     * @return the userName
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param userName the userName to set
     */
    public void setUserName(String email) {
        this.email = email;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the position
     */
    public String getPosition(String Position) {
        return position;
    }

    /**
     * @return the position
     */
    public String getPosition() {
        return position;
    }

    /**
     * @param position the position to set
     */
    public void setPosition(String position) {
        this.position = position;
    }

    /**
     * @return the gender
     */
    public String getGender() {
        return gender;
    }

    /**
     * @param gender the gender to set
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * @return the birthDate
     */
    public java.sql.Date getBirthDate() {
        return birthDate;
    }

    /**
     * @param birthDate the birthDate to set
     */
    public void setBirthDate() throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date birthDate0 = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date birthDate1 = formatter.parse(df.format(birthDate0));
        java.sql.Date sqlreceivedDate1 = new java.sql.Date(birthDate1.getTime());
        this.birthDate = sqlreceivedDate1;
    }

    public void setBirthDate(String birthDate) throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date hbirthDate = formatter.parse(birthDate);
        java.sql.Date sqlbirthDate = new java.sql.Date(hbirthDate.getTime());
        this.birthDate = sqlbirthDate;
    }

    /**
     * @return the entryDate
     */
    public java.sql.Date getEntryDate() {
        return entryDate;
    }

    /**
     * @param entryDate the entryDate to set
     */
    public void setEntryDate(String EntryDate) throws ParseException {
        @SuppressWarnings("deprecation")
         java.util.Date hEntryDate = formatter.parse(EntryDate);
        java.sql.Date entryDate = new java.sql.Date(hEntryDate.getTime());
        this.entryDate = entryDate;
    }

    /**
     * @return the leftDate
     */
    public java.sql.Date getLeftDate() {
        return leftDate;
    }

    /**
     * @param leftDate the leftDate to set
     */
    public void setLeftDate() throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date leftDate0 = new java.util.Date();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date leftDate1 = formatter.parse(df.format(leftDate0));
        java.sql.Date sqlreceivedDate1 = new java.sql.Date(leftDate1.getTime());
        this.leftDate = sqlreceivedDate1;
    }

    public void setLeftDate(String LeftDate) throws ParseException {
        @SuppressWarnings("deprecation")
        java.util.Date hDate = formatter.parse(LeftDate);
        java.sql.Date sqlLeftDate = new java.sql.Date(hDate.getTime());
        this.leftDate = sqlLeftDate;
    }

}
