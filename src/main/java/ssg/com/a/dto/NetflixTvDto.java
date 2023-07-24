package ssg.com.a.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true) // 만약 JSON 파일에 모르는 파라미터가 들어오면 무시하는 annotation
public class NetflixTvDto {
	private Long id; // 컨텐츠 고유 아이디 
	
	@JsonProperty("name")
    private String title;
	
    private String overview;
    
    @JsonProperty("poster_path") // json null값으로 들어가서 key값 매핑시켜주기위해서
    private String posterpath;
    
    private Double popularity;
    
    @JsonProperty("first_air_date")
    private String releasedate;
    
    public NetflixTvDto() {
    	
    }

	public NetflixTvDto(Long id, String title, String overview, String posterpath, Double popularity,
			String releasedate) {
		super();
		this.id = id;
		this.title = title;
		this.overview = overview;
		this.posterpath = posterpath;
		this.popularity = popularity;
		this.releasedate = releasedate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOverview() {
		return overview;
	}

	public void setOverview(String overview) {
		this.overview = overview;
	}

	public String getPosterpath() {
		return posterpath;
	}

	public void setPosterpath(String posterpath) {
		this.posterpath = posterpath;
	}

	public Double getPopularity() {
		return popularity;
	}

	public void setPopularity(Double popularity) {
		this.popularity = popularity;
	}

	public String getReleasedate() {
		return releasedate;
	}

	public void setReleasedate(String releasedate) {
		this.releasedate = releasedate;
	}

	@Override
	public String toString() {
		return "NetflixTvDto [id=" + id + ", title=" + title + ", overview=" + overview + ", posterpath=" + posterpath
				+ ", popularity=" + popularity + ", releasedate=" + releasedate + "]";
	}

}
