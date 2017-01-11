package org.pox.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream; 
import javax.servlet.http.HttpServletResponse;

public class DownloadUtil {
	public static void fileDownload(HttpServletResponse response, String fileName)
			throws FileNotFoundException, IOException {
		OutputStream outs = null;
		FileInputStream fis = null;
		try {
			response.setCharacterEncoding("UTF-8");  
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Disposition", "attachment;fileName=\"" + fileName + "\";");
			outs = response.getOutputStream(); 
			try {
				fis = new FileInputStream("J:\\ServerUploading\\upload" + fileName);
				int ch;
				while ((ch = fis.read()) != -1) {
					outs.write(ch);
				}
				outs.close();
				fis.close();
				outs.flush();
			} catch (IOException e) {
				response.setContentLength(0);
				System.out.println("File not found.");
				e.printStackTrace();
			} finally {
				if (outs != null) {
					outs.close();
					outs = null;
				}
				if (fis != null) {
					fis.close();
					fis = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
