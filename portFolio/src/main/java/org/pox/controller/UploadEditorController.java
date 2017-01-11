package org.pox.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.pox.util.MediaUtils;
import org.pox.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UploadEditorController {

	private static final Logger logger = LoggerFactory.getLogger(UploadEditorController.class);

	@Resource(name = "uploadPath")
	private String uploadPath;

	@ResponseBody
	@RequestMapping(value = "/uploadEditorForm", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadForm(@RequestHeader("contentType") String contentType,
			@RequestHeader("file-name") String fileName, @RequestHeader("file-size") long fileSize,
			@RequestHeader("file-Type") String fileType, HttpServletRequest request) throws Exception {

		fileName = URLDecoder.decode(fileName, "UTF-8");

		logger.info("=========================");
		logger.info(contentType);
		logger.info(fileName);
		logger.info("" + fileSize);
		logger.info(fileType);

		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		//
		//
		IOUtils.copy(request.getInputStream(), bos);
		//
		logger.info("LENGTH: " + bos.size());

		String uploadedName = UploadFileUtils.uploadFile(uploadPath, fileName, bos.toByteArray());

		logger.info("UPLOADED NAME:" + uploadedName);

		uploadedName = uploadedName.replaceAll("/", ":");

		String url = "callback=javascript:cb";
		url += "&bNewLine=true";
		url += "&sFileName=" + fileName;
		url += "&sFileURL=/displayEditorFile/" + uploadedName;

		ResponseEntity<String> result = new ResponseEntity<String>(url, HttpStatus.OK);
		return result;

	}

	@ResponseBody
	@RequestMapping("/displayEditorFile/{fileName:.+}")
	public ResponseEntity<byte[]> displayFile(@PathVariable("fileName") String fileName) throws Exception {

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		fileName = fileName.replaceAll(":", "/");

		logger.info("display FILE NAME: " + fileName);

		try {

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			logger.info("FORMAT NAME: " + formatName);

			MediaType mType = MediaUtils.getMediaType(formatName);

			HttpHeaders headers = new HttpHeaders();

			in = new FileInputStream(uploadPath + File.separator + fileName);

			if (mType != null) {
				headers.setContentType(mType);
			} else {

				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteEditorFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("delete Editor file: " + fileName);

		fileName = fileName.replace(":", "/");

		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		MediaType mType = MediaUtils.getMediaType(formatName);

		if (mType != null) {

			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}

		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
