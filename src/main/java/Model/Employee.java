package Model;

import java.util.Scanner;

public abstract class Employee {
	
	protected int ID;
	protected String firstName;
	protected String lastName;
	protected String email;
	protected String phoneNumber;
	protected String address;
	protected double salary;
	protected String password;
	protected Model.Option[] options;
	private double price;

	public Employee() {
		
	}
	
	public Employee(int ID, String firstName, String lastName, String email,
			String phoneNumber, String address, double salary, String password) {
		this.ID = ID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.salary = salary;
		this.password = password;
	}
	
	public int getID() {
		return ID;
	}
	
	public void setID(int ID) {
		this.ID = ID;
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
	
	
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	public String getPhoneNumber() {
		return phoneNumber;
	}
	
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
	public double getSalary() {
		return salary;
	}
	
	public void setSalary(double salary) {
		this.salary = salary;
	}
	
	
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
	public abstract int getDepartment();


	public String getDepartmentToString() {
		String dept;
		switch (getDepartment()) {
		case 0:
			dept = "Manager";
			break;
		case 1:
			dept = "Cashier";
			break;
		case 2:
			dept = "Storekeeper";
			break;
			default:
				dept = "Invalid";
				break;
		}
		return dept;
	}
	

	
	public String getName() {
		return getFirstName()+" "+getLastName();
	}
	
	

	public void setPrice(double price) {
		if (price < 0) {
			throw new IllegalArgumentException("Price cannot be negative");
		}
		this.price = price;
	}

}
