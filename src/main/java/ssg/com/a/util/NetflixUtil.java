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

public class NetflixUtil {
    
    public static List<NetflixContentDto> getNetflixContent() throws UnsupportedEncodingException, IOException, ParseException  {
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
			    String title = (String) movie.get("title");
			    String overview = (String) movie.get("overview");
			    String posterPath = (String) movie.get("poster_path"); // https://image.tmdb.org/t/p/w500" + posterPath
			    Double popularity = (Double) movie.get("popularity"); 
			    String releaseDate = (String) movie.get("release_date");
			    

			    NetflixContentDto content = new NetflixContentDto(title, overview, posterPath, popularity, releaseDate);
	            contentList.add(content);
			}
			
			return contentList;
    }
}
