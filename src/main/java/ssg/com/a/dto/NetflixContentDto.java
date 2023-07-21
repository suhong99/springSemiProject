package ssg.com.a.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true) // 만약 JSON 파일에 모르는 파라미터가 들어오면 무시하는 annotation
public class NetflixContentDto {
	private Long id; // 컨텐츠 고유 아이디 
    private String title;
    private String overview;
    
    @JsonProperty("poster_path") // json null값으로 들어가서 key값 매핑시켜주기위해서
    private String posterpath;
    
    private Double popularity;
    
    @JsonProperty("release_date") // json null값으로 들어가서 key값 매핑시켜주기위해서
    private String releasedate;
    
    public NetflixContentDto() {
    }

	public NetflixContentDto(Long id, String title, String overview, String posterpath, Double popularity,
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

	public Object getPopularity() {
		return popularity;
	}


	public void setPopularity(Double popularity) {
		this.popularity = popularity;
	}


	public String getReleaseDate() {
		return releasedate;
	}


	public void setReleaseDate(String releasedate) {
		this.releasedate = releasedate;
	}

	@Override
	public String toString() {
		return "NetflixContentDto [id=" + id + ", title=" + title + ", overview=" + overview + ", posterpath="
				+ posterpath + ", popularity=" + popularity + ", releasedate=" + releasedate + "]";
	}

}
