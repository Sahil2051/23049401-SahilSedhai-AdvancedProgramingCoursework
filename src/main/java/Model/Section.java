package Model;

import java.util.ArrayList;

public class Section {
	
	private int ID;
	private ArrayList<Product> products;
	private String name;
	private String description;
	

	
	public Section(int ID, ArrayList<Product> products, String name, String description) {
		this.ID = ID;
		this.products = products;
		this.name = name;
		this.description = description;
	}
	
	public int getID() {
		return ID;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public ArrayList<Product> getProducts() {
		return products;
	}
	
	public void setProducts(ArrayList<Product> products) {
		this.products = products;
	}
	


}
