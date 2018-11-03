package com.spring.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	
	public static final Logger logger = 
			LoggerFactory.getLogger(UploadFileUtils.class);
	
	/*------------------------*/
	/*  upload File for Ajax */
	/*-----------------------*/	
	public static String uploadFile(String uploadPath,
									String originalName,
									byte[] fileData) throws Exception{
		logger.info("UploadFile for ajax ---------");
		logger.info("originalName=" + originalName);

		UUID uid = UUID.randomUUID(); //UUID
		String savedName = uid.toString() + "_" + originalName; //UUID_NAME
		String savedPath = calcPath(uploadPath);// \2018\10\12 + make dir
		
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData,  target);

		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		String uploadedFileName = null;
		
		if(MediaUtils.getMediaType(formatName) != null) { 
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName); //if img file
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName); //if not img file
		}		
		logger.info("uploadedFileName=" + uploadedFileName);
		return uploadedFileName;
	}

	
	/*--------------*/
	/*   calcPath   */
	/*--------------*/	
	private static String calcPath(String uploadPath) {

		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		
		String monthPath = yearPath +
				File.separator +
				new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		
		String datePath = monthPath +
				File.separator +
				new DecimalFormat("00").format(cal.get(Calendar.DATE));
		logger.info("uploadPath=" + uploadPath); 	// C:\\zzz\\upload
		logger.info("yearPath=" + yearPath); 		// \2018
		logger.info("monthPath=" + monthPath);		// \2018\10
		logger.info("datePath=" + datePath);		// \2018\10\12
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	/*--------------*/
	/*   makeDir   */
	/*--------------*/	
	private static void makeDir(String uploadPath, String... paths) {
		logger.info("paths=" + paths); 		// [Ljava.lang.String;@2325d211
		if( new File(uploadPath + paths[paths.length - 1]).exists() ) {
			return;
		}	
		for (String path : paths) {//year, month, day
			File dirPath = new File(uploadPath + path);
			if(! dirPath.exists() ) {
				dirPath.mkdir(); //Make sub folder
			}	
		}
	}
	/*---------------*/
	/*   thumbnail   */
	/*---------------*/	
	private static String makeThumbnail(
			String uploadPath,
			String path,
			String fileName) throws Exception{
		
		BufferedImage sourceImg =
				ImageIO.read( new File(uploadPath + path, fileName));
		
		BufferedImage destImg =	//resize
				Scalr.resize(sourceImg,
						Scalr.Method.AUTOMATIC,
						Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		String thumbnailName = //thumbnail path
				uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		String formatName = //thumbnail path + "."
				fileName.substring(fileName.lastIndexOf(".")+1);
		
		ImageIO.write(destImg,  formatName.toUpperCase(), newFile); //save thumbnail path + "." +new File(thumbnailName);
		// to check
		logger.info("sourceImg=" + sourceImg); // BufferedImage@4e10c037: type = 6 ColorModel: #pixelBits = 32 numComponents = 4 color space = java.awt.color.ICC_ColorSpace@5a42e5c6 transparency = 3 has alpha = true isAlphaPre = false ByteInterleavedRaster: width = 583 height = 261 #numDataElements 4 dataOff[0] = 3
		logger.info("destImg=" + destImg);	// BufferedImage@140d6ca8: type = 2 DirectColorModel: rmask=ff0000 gmask=ff00 bmask=ff amask=ff000000 IntegerInterleavedRaster: width = 223 height = 100 #Bands = 4 xOff = 0 yOff = 0 dataOffset[0] 0
		logger.info("thumbnailName=" + thumbnailName); // C:\\zzz\\upload\2018\10\12\s_3121cbb5-b113-47f8-927b-b37524a1b021_222.PNG
		logger.info("formatName=" + formatName); // PNG
		return thumbnailName.substring(uploadPath.length()).
				replace(File.separatorChar, '/');
	}
	
/*------------*/
/*  makeIcon  */
/*------------*/
	public static String makeIcon(String uploadPath,
			String path,
			String fileName) throws Exception{
		String iconName =
				uploadPath + path + File.separator + fileName;
		logger.info("iconName=" + iconName);//if not image
		return iconName.substring(uploadPath.length()).
				replace(File.separatorChar, '/');
	}

}
