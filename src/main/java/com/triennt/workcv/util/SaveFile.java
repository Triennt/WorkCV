package com.triennt.workcv.util;

import java.io.File;
import java.io.IOException;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class SaveFile {
	@Autowired
	private Storage storage; // Inject the Google Cloud Storage client
	@Value("${spring.cloud.gcp.storage.bucket-name}")
	private String bucketName;

	
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

	public String saveFileOnCloud(MultipartFile fileUpload, String folderPath) throws IOException {
		String fileName = fileUpload.getOriginalFilename();
		String filePath = folderPath + fileName;
		BlobId folderBlobId = BlobId.of(bucketName, filePath);
		BlobInfo folderBlobInfo = BlobInfo.newBuilder(folderBlobId).build();
		Blob blob = storage.create(folderBlobInfo, fileUpload.getBytes());
		return blob.getMediaLink();
	}
}
