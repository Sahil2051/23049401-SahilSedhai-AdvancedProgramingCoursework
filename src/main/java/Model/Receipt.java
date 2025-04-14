package Model;

import java.util.ArrayList;

public class Receipt {
	
	private int ID;
	private Employee cashier;
	private ArrayList<Product> products;
	private double total;
	private int payment;
	private double paid;
	private double change;
	
	public Receipt() {
		
	}

	public Receipt(int ID, Employee cashier, ArrayList<Product> products,
			double total, int payment, double paid, double change) {
		this.ID = ID;
		this.cashier = cashier;
		this.products = products;
		this.total = total;
		this.payment = payment;
		this.paid = paid;
		this.change = change;
	}
	
	public int getID() {
		return ID;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}

	
	public Employee getCashier() {
		return cashier;
	}
	
	public void setCashier(Employee cashier) {
		this.cashier = cashier;
	}

	
	public ArrayList<Product> getProducts() {
		return products;
	}
	
	public void setProducts(ArrayList<Product> products) {
		this.products = products;
	}


	public double getTotal() {
		return total;
	}
	
	public void setTotal(double total) {
		this.total = total;
	}


	public int getPayment() {
		return payment;
	}
	
	public void setPayment(int payment) {
		this.payment = payment;
	}

	
	public double getPaid() {
		return paid;
	}
	
	public void setPaid(double paid) {
		this.paid = paid;
	}

	
	public double getChange() {
		return change;
	}
	
	public void setChange(double change) {
		this.change = change;
	}

	
	public String getPaymentToString() {
		if (payment==1) {
			return "Cash";
		} else {
			return "Card";
		}
	}

}
