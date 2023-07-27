package ssg.com.a.dto;

/* 관심있는 컨텐츠 */
public class FavoriteDto {
	private String id; // 사람 아이디
	private Long content_id;
	private String title;
	private int like; // 관심있으면 1 
	
	public FavoriteDto() {
		
	}

	public FavoriteDto(String id, Long content_id, String title, int like) {
		super();
		this.id = id;
		this.content_id = content_id;
		this.title = title;
		this.like = like;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getContent_id() {
		return content_id;
	}

	public void setContent_id(Long content_id) {
		this.content_id = content_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	@Override
	public String toString() {
		return "FavoriteDto [id=" + id + ", content_id=" + content_id + ", title=" + title + ", like=" + like + "]";
	}
	


}
