package classes;

public class Review {
	private String customerID;
	private String review;
	private int rating;
	private String cusName;

	public Review(String customerID, String review, int rating, String cusName) {
		super();
		this.customerID = customerID;
		this.review = review;
		this.rating = rating;
		this.cusName = cusName;
	}

	public String getCustomerID() {
		return customerID;
	}

	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}

}
