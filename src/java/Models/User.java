package Models;

import java.util.Date;

public class User {

    private int id;
    private int roleID;
    private String userName;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private Boolean gender;
    private Date dateOfBirth;
    private int status;
    private Date createdAt;
    private Date updateAt;

    public User() {
    }

    public User(int id, int roleID, String userName, String fullName, String email, String password, String phone, String address, Boolean gender, Date dateOfBirth, int status, Date createdAt, Date updateAt) {
        this.id = id;
        this.roleID = roleID;
        this.userName = userName;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", roleID=" + roleID + ", userName=" + userName + ", fullName=" + fullName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + ", status=" + status + ", createdAt=" + createdAt + ", updateAt=" + updateAt + '}';
    }

   
}
