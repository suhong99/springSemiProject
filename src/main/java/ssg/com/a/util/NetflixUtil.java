package ssg.com.a.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.RoundingMode;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;

public class NetflixUtil {
    
    public static List<NetflixContentDto> getNetflixMovie() throws Exception  {
    	// API를 통해 추출한 JSON형태 결과를 저장할 변수
    	String result = "";
    	
        // themoviedb API 키
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        
        // 한글 컨텐츠의 언어 코드 (한국어)
        String language = "ko-KR";
        
        // Netflix 컨텐츠 ID = 8
        String netflixId = "8";

        
            // API 요청을 보낼 URL -- movie파트
            URL url = new URL("https://api.themoviedb.org/3/discover/movie"
                    + "?api_key=" + apiKey
                    + "&with_watch_providers=" + netflixId
                    + "&language=" + language);
            		//+ "&page"= + num);
            

            BufferedReader bf;

            bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            result = bf.readLine();

            // API 응답 JSON 파싱
            JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get("results");
			
			// DTO로 저장할 리스트
	        List<NetflixContentDto> contentList = new ArrayList<>();
			
			// JSON 출력
			for (Object obj : list) {
			    JSONObject movie = (JSONObject) obj;
			    Long id = (Long) movie.get("id"); // id는 Long형태
			    String title = (String) movie.get("title");
			    String overview = (String) movie.get("overview");
			    String posterPath = (String) movie.get("poster_path"); // https://image.tmdb.org/t/p/w500" + posterPath
			    Double popularity = Double.parseDouble(movie.get("popularity").toString()); 
			    String releaseDate = (String) movie.get("release_date");
			    

			    NetflixContentDto content = new NetflixContentDto(id, title, overview, posterPath, popularity, releaseDate);
	            contentList.add(content);
			}
			
			return contentList;
    }
    
    public static List<NetflixTvDto> getNetflixTv() throws Exception  {
    	// API를 통해 추출한 JSON형태 결과를 저장할 변수
    	String result = "";
    	
        // themoviedb API 키
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        
        // 한글 컨텐츠의 언어 코드 (한국어)
        String language = "ko-KR";
        
        // Netflix 컨텐츠 ID = 8
        String netflixId = "8";

        
            // API 요청을 보낼 URL -- movie파트
            URL url = new URL("https://api.themoviedb.org/3/discover/tv"
                    + "?api_key=" + apiKey
                    + "&with_watch_providers=" + netflixId
                    + "&watch_region=KR" // 한국 
                    + "&language=" + language);
            		//+ "&page"= + num);
            

            BufferedReader bf;

            bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            result = bf.readLine();

            // API 응답 JSON 파싱
            JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get("results");
			
			// DTO로 저장할 리스트
	        List<NetflixTvDto> contentList = new ArrayList<>();
			
			// JSON 출력
			for (Object obj : list) {
			    JSONObject movie = (JSONObject) obj;
			    Long id = (Long) movie.get("id");
			    String title = (String) movie.get("name");
			    String overview = (String) movie.get("overview");
			    String posterPath = (String) movie.get("poster_path"); // https://image.tmdb.org/t/p/w500" + posterPath
			    Double popularity = Double.parseDouble(movie.get("popularity").toString()); 
			    String releaseDate = (String) movie.get("first_air_date");
			    

			    NetflixTvDto content = new NetflixTvDto(id, title, overview, posterPath, popularity, releaseDate);
	            contentList.add(content);
			}
			
			return contentList;
    }
    
    public static List<NetflixContentDto> getNetflixMovieJson() throws Exception  {
    	// API를 통해 추출한 JSON형태 결과를 저장할 변수
    	String result = "";
    	
        // themoviedb API 키
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        
        // 한글 컨텐츠의 언어 코드 (한국어)
        String language = "ko-KR";
        
        // Netflix 컨텐츠 ID = 8
        String netflixId = "8";

        
            // API 요청을 보낼 URL -- movie파트
            URL url = new URL("https://api.themoviedb.org/3/discover/movie"
                    + "?api_key=" + apiKey
                    + "&with_watch_providers=" + netflixId
                    + "&language=" + language);
            		//+ "&page"= + num);
            

            BufferedReader bf;

            bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            result = bf.readLine();

            // API 응답 JSON 파싱
            JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get("results");
			
			return list;
    }
    
    public static List<NetflixTvDto> getNetflixTvJson() throws Exception  {
    	// API를 통해 추출한 JSON형태 결과를 저장할 변수
    	String result = "";
    	
        // themoviedb API 키
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        
        // 한글 컨텐츠의 언어 코드 (한국어)
        String language = "ko-KR";
        
        // Netflix 컨텐츠 ID = 8
        String netflixId = "8";
        
        // 국가
        String region = "KR";

        
            // API 요청을 보낼 URL -- movie파트
            URL url = new URL("https://api.themoviedb.org/3/discover/tv"
                    + "?api_key=" + apiKey
                    + "&watch_region=" + region
                    + "&with_watch_providers=" + netflixId
                    + "&language=" + language);
            		//+ "&page"= + num);
            

            BufferedReader bf;

            bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            result = bf.readLine();

            // API 응답 JSON 파싱
            JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get("results");
			
			return list;
    }
    
    /* 소수 두자리 수 까지 출력 */
    public static Double round(Double num) {
    	if(num == 0) {
    		return 0.00;
    	}
    	
    	DecimalFormat df = new DecimalFormat("#.##"); // 소수 2자리수 
        df.setRoundingMode(RoundingMode.FLOOR);
    	
        String num_str = df.format(num);
        Double rating = Double.parseDouble(num_str);
    	return rating;
    }

    public static List<NetflixContentDto> searchNetflixMovie(String query) throws Exception {
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        String language = "ko-KR";
        String netflixId = "8";
        int currentPage = 1;
        int totalPages = 1;
        
        List<NetflixContentDto> contentList = new ArrayList<>();

        do {
            URL url = new URL("https://api.themoviedb.org/3/search/movie"
                    + "?api_key=" + apiKey
                    + "&with_watch_providers=" + netflixId
                    + "&language=" + language
                    + "&query=" + URLEncoder.encode(query, "UTF-8")
                    + "&page=" + currentPage);

            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String result = bf.readLine();
            bf.close();

            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
            JSONArray list = (JSONArray) jsonObject.get("results");

            if (currentPage == 1) {
                // 첫 페이지 검색 결과에서 총 페이지 수를 얻어옵니다.
                totalPages = Integer.parseInt(jsonObject.get("total_pages").toString());
            }

            for (Object obj : list) {
                JSONObject movie = (JSONObject) obj;
                // JSON에서 NetflixContentDto 객체를 추출하여 contentList에 추가합니다.
                Long id = (Long) movie.get("id"); // id는 Long형태
			    String title = (String) movie.get("title");
			    String overview = (String) movie.get("overview");
			    String posterPath = (String) movie.get("poster_path"); // https://image.tmdb.org/t/p/w500" + posterPath
			    Double popularity = Double.parseDouble(movie.get("popularity").toString()); 
			    String releaseDate = (String) movie.get("release_date");
                NetflixContentDto content = new NetflixContentDto(id, title, overview, posterPath, popularity, releaseDate);
                contentList.add(content);
            }

            currentPage++; // 다음 페이지로 이동합니다.
        } while (currentPage <= totalPages);

        return contentList;
    }
    
    public static List<NetflixTvDto> searchNetflixTV(String query) throws Exception {
        String apiKey = "d5aa3423c1d19e90331f7ffda7962079";
        String language = "ko-KR";
        String netflixId = "8";
        int currentPage = 1;
        int totalPages = 1;

        List<NetflixTvDto> contentList = new ArrayList<>();

        do {
            URL url = new URL("https://api.themoviedb.org/3/search/tv"
                    + "?api_key=" + apiKey
                    + "&with_watch_providers=" + netflixId
                    + "&language=" + language
                    + "&query=" + URLEncoder.encode(query, "UTF-8")
                    + "&page=" + currentPage);

            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String result = bf.readLine();
            bf.close();

            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
            JSONArray list = (JSONArray) jsonObject.get("results");

            if (currentPage == 1) {
                // 첫 페이지 검색 결과에서 총 페이지 수를 얻어옵니다.
                totalPages = Integer.parseInt(jsonObject.get("total_pages").toString());
            }

            for (Object obj : list) {
                JSONObject tvShow = (JSONObject) obj;
                // JSON에서 NetflixTvDto 객체를 추출하여 contentList에 추가합니다.
                Long id = (Long) tvShow.get("id");
                String title = (String) tvShow.get("name");
                String overview = (String) tvShow.get("overview");
                String posterPath = (String) tvShow.get("poster_path");
                Double popularity = Double.parseDouble(tvShow.get("popularity").toString());
                String releaseDate = (String) tvShow.get("first_air_date");
                NetflixTvDto content = new NetflixTvDto(id, title, overview, posterPath, popularity, releaseDate);
                contentList.add(content);
            }

            currentPage++; // 다음 페이지로 이동합니다.
        } while (currentPage <= totalPages);

        return contentList;
    }

}
