package model;// Package for application model classes

import java.util.Date; // Import Date class for storing order date
import java.util.List; // Import List interface to store multiple OrderItem objects

// Model class for order data
public class Order {
    
    // Attributes
    private int orderId;
    private int userId;
    private Date orderDate;
    private double totalAmount;
    private String orderStatus;
    private String paymentStatus;
    private String shippingAddress;
    private String note;
    
    // Association
    private List<OrderItem> items;
    
    // Default constructor
    public Order(){}
    
    // Alternate constructor
    public Order(int orderId, int userId, Date orderDate, double totalAmount,
                 String orderStatus, String paymentStatus, String shippingAddress, String note) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.paymentStatus = paymentStatus;
        this.shippingAddress = shippingAddress;
        this.note = note;
    }

    // Getter and Setter Methods
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderID) {
        this.orderId = orderID;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userID) {
        this.userId = userID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date date) {
        this.orderDate = date;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double ta) {
        this.totalAmount = ta;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String os) {
        this.orderStatus = os;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String ps) {
        this.paymentStatus = ps;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String address) {
        this.shippingAddress = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
    
    // toString method
    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", shippingAddress='" + shippingAddress + '\'' +
                ", note='" + note + '\'' +
                ", items=" + items +
                '}';
    }
}
