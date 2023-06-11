package classes;

public class CartItems {
	private String ISBN;
	private String imageURL;
	private String title;
	private double price;
	private String cart_id;
	private int quantity;
	
	public CartItems (String ISBN, String cart_id, String title, String imageURL, double price ) {
		this.ISBN = ISBN;
		this.cart_id = cart_id;
		this.title = title;
		this.imageURL = imageURL;
		this.price = price;
	}
	
	public CartItems(String imageURL, String title, String ISBN, double price, int quantity) {
		super();
		// TODO Auto-generated constructor stub
		this.imageURL = imageURL;
		this.title = title;
		this.ISBN = ISBN;
		this.price = price;
		this.quantity = quantity;
	}

	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getCart_id() {
		return cart_id;
	}

	public void setCart_id(String cart_id) {
		this.cart_id = cart_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}


