package ssg.com.a.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;

public class NetflixUtil {
    
    public static List<NetflixContentDto> getNetflixMovie() throws UnsupportedEncodingException, IOException, ParseException  {
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
    
    public static List<NetflixTvDto> getNetflixTv() throws UnsupportedEncodingException, IOException, ParseException  {
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
    
    public static List<NetflixContentDto> getNetflixMovieJson() throws UnsupportedEncodingException, IOException, ParseException  {
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
    
    public static List<NetflixTvDto> getNetflixTvJson() throws UnsupportedEncodingException, IOException, ParseException  {
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
}
