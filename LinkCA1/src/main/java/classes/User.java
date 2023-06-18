package classes;

public class User {
	private String fName;
	private String lName;
	private String password;
	private String customer_id;

	public User(String fName, String lName, String password, String customer_id) {
		super();
		this.fName = fName;
		this.lName = lName;
		this.password = password;
		this.customer_id = customer_id;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getFullName() {
		String fullName = this.fName + " " + this.lName;
		return fullName;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

}
