package classes;

public class BookClass {
	private String ISBN;
	private String date;
	private String genre;
	private String description;
	private String title;
	private String author;
	private double price;
	private int quantity;
	private String publisher;
	private String publication;
	private String imageURL;
	private int rating;
	private int customer_id;

	public BookClass(String ISBN, String date, String genre, String description, String title, String author,
			double price, int quantity, String publisher, String publication, String imageURL, int rating) {
		super();
		this.ISBN = ISBN;
		this.date = date;
		this.genre = genre;
		this.description = description;
		this.title = title;
		this.author = author;
		this.price = price;
		this.quantity = quantity;
		this.publisher = publisher;
		this.publication = publication;
		this.imageURL = imageURL;
		this.rating = rating;
		this.customer_id = customer_id;
	}
	
	public BookClass (String imageURL, String title, double price, String ISBN, int customer_id) {
		this.imageURL = imageURL;
		this.title = title;
		this.price = price;
		this.ISBN = ISBN;
		this.customer_id = customer_id;
	}
	
	public BookClass (String imageURL, String title, double price) {
		this.imageURL = imageURL;
		this.title = title;
		this.price = price;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = ISBN;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPublication() {
		return publication;
	}

	public void setPublication(String publication) {
		this.publication = publication;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

}
