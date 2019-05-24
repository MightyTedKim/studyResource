package com.spring.util;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;

// to varify if it's an image file or not
// needed to determine whether we should download or show at browser

public class MediaUtils {
	public static final Logger logger = 
			LoggerFactory.getLogger(MediaUtils.class);

	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG",  MediaType.IMAGE_JPEG);
		mediaMap.put("GIF",  MediaType.IMAGE_GIF);
		mediaMap.put("PNG",  MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}

}
