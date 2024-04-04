package com.triennt.workcv.util;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public class SaveFile {
	
	public static String saveFileOnServer(String absolutePath, MultipartFile fileUpload) throws Exception{

		File dir = new File(absolutePath);
		if(! dir.exists())
		{
			System.out.println("create mkdir: "+ dir.mkdirs());
		}

    	String fileName = fileUpload.getOriginalFilename();
    	
		File newFile = new File(absolutePath, fileName);
		fileUpload.transferTo(newFile);
		
		return fileName;
	}
}
