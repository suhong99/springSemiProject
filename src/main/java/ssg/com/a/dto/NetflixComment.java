package ssg.com.a.dto;

public class NetflixComment {
	private int seq;
	private String id;
	private String content;
	private String wdate;
	
	public NetflixComment() {
		
	}
	
	// 삭제용
	public NetflixComment(int comment_id, int seq) {
		super();
		this.comment_id = comment_id;
		this.seq = seq;
	}

	public NetflixComment(int seq, String id, String content, String wdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
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
		return "NetflixComment [seq=" + seq + ", id=" + id + ", content=" + content + ", wdate=" + wdate + "]";
	}
	
	
}
