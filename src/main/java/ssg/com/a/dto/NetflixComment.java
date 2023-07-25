package ssg.com.a.dto;

public class NetflixComment {
	private int comment_id;
	private int seq;
	private String id;
	private String content;
	private String wdate;
	private Double rating;
	
	public NetflixComment() {
		
	}
	
	// 삭제용
	public NetflixComment(int comment_id, int seq) {
		super();
		this.comment_id = comment_id;
		this.seq = seq;
	}

	public NetflixComment(int comment_id, int seq, String id, String content, String wdate, Double rating) {
		super();
		this.comment_id = comment_id;
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
		this.rating = rating;
	}

	
	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "NetflixComment [comment_id=" + comment_id + ", seq=" + seq + ", id=" + id + ", content=" + content
				+ ", wdate=" + wdate + ", rating=" + rating + "]";
	}
}
