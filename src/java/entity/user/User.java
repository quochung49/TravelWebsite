package entity.user;

import entity.model.UserRole;
import java.io.Serializable;

public class User implements Serializable {

    private int id;
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private String streetAddress;
    private String zipcode;
    private String city;
    private String country;
    private String phone;
    private UserRole role;

    public User(int id, String email, String password, String firstName, String lastName, String streetAddress, String zipcode, String city, String country, String phone) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.streetAddress = streetAddress;
        this.zipcode = zipcode;
        this.city = city;
        this.country = country;
        this.phone = phone;
    }

    public User(int id, String email, String password, String firstName, String lastName, String streetAddress, String zipcode, String city, String country, String phone, UserRole role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.streetAddress = streetAddress;
        this.zipcode = zipcode;
        this.city = city;
        this.country = country;
        this.phone = phone;
        this.role = role;
    }

    public User(String email, String password, String firstName, String lastName, String streetAddress, String zipcode, String city, String country, String phone, UserRole role) {
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.streetAddress = streetAddress;
        this.zipcode = zipcode;
        this.city = city;
        this.country = country;
        this.phone = phone;
        this.role = role;
    }

    public User(String email, String password, String firstName, String lastName, String streetAddress, String zipcode, String city, String country, String phone) {
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.streetAddress = streetAddress;
        this.zipcode = zipcode;
        this.city = city;
        this.country = country;
        this.phone = phone;
    }

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", email=" + email + ", password=" + password + ", firstName=" + firstName + ", lastName=" + lastName + ", streetAddress=" + streetAddress + ", zipcode=" + zipcode + ", city=" + city + ", country=" + country + ", phone=" + phone + ", role=" + role.getName() + '}';
    }

}
