package model; // Package for application model classes

// Model class for admin data
public class Admin {

    // Attributes
    private int adminId;
    private String name;
    private String username;
    private String password;
    
    // Default constructor
    public Admin() {}
    
    // Alternate constructor
    public Admin (int adminId, String name, String username, String password){
       this.adminId = adminId;
       this.name = name;
       this.username = username;
       this.password = password; 
    }
    
    // Getter and Setter Methods
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId (int id){
        this.adminId = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name){
        this.name = name;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // toString method
    @Override
    public String toString() {
        return "Admin [adminId=" + adminId + ", name=" + name + ", username=" + username + "]";
    }
}
