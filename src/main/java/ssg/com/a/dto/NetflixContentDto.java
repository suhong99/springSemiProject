package ssg.com.a.dto;

public class NetflixContentDto {
    private String title;
    private String overview;
    private String posterUrl;
    private Double popularity;
    private String releaseDate;
    
    public NetflixContentDto() {
    }
    
    
	public NetflixContentDto(String title, String overview, String posterUrl, Double popularity, String releaseDate) {
		super();
		this.title = title;
		this.overview = overview;
		this.posterUrl = posterUrl;
		this.popularity = popularity;
		this.releaseDate = releaseDate;
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


	public String getPosterUrl() {
		return posterUrl;
	}


	public void setPosterUrl(String posterUrl) {
		this.posterUrl = posterUrl;
	}


	public Object getPopularity() {
		return popularity;
	}


	public void setPopularity(Double popularity) {
		this.popularity = popularity;
	}


	public String getReleaseDate() {
		return releaseDate;
	}


	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}


	@Override
	public String toString() {
		return "Title: " + title +
                "\nOverview: " + overview +
                "\nPoster URL: " + posterUrl +
                "\nPopularity: " + popularity +
                "\nRelease Date: " + releaseDate + "\n";
	}
}
