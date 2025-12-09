package model;

import java.util.Date;// Import Date class for storing payment date

public class Payment {

    // Attributes
    private int paymentId;
    private int orderId;
    private Date paymentDate;
    private String paymentMethod;
    private double amount;
    
    // Default constructor
    public Payment() {}
    
    // Alternate constructor
    public Payment(int paymentId, int orderId, Date paymentDate, String paymentMethod, double amount) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
    }

    // Getter and Setter methods
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentID) {
        this.paymentId = paymentID;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderID) {
        this.orderId = orderID;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date date) {
        this.paymentDate = date;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String method) {
        this.paymentMethod = method;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    // toString method
    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", orderId=" + orderId +
                ", paymentDate=" + paymentDate +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", amount=" + amount +
                '}';
    }

}
