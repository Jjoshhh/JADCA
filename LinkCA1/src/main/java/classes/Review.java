package classes;

public class Review {
	private String review;
	private int rating;
	private String cusName;
	private String reviewID;
	
	

	public Review(String review, int rating, String reviewID, String cusName) {
		super();
		this.review = review;
		this.rating = rating;
		this.cusName = cusName;
		this.reviewID = reviewID;
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

	public String getReviewID() {
		return reviewID;
	}

	public void setReviewID(String reviewID) {
		this.reviewID = reviewID;
	}

}
