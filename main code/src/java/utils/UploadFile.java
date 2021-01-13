/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Hung
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class UploadFile {

    public String uploadFile(HttpServletRequest request, String uploadDir, String propertyName) throws IOException, ServletException {
        String fileName = "";
        String newFileName = "";
        String errorString = "";
//        if (ServletFileUpload.isMultipartContent(request)) {
//            try {
//                System.out.println("step 1");
//                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
//                System.out.println("multiparts " + multiparts.size());
//
//                for (FileItem item : multiparts) {
//                    System.out.println("2");
//                    if (!item.isFormField()) {
//                        System.out.println("3");
//                        fileName = new File(item.getName()).getName();
//                        String instanceName = request.getParameter("name");
//                        newFileName = instanceName + fileName.substring(fileName.lastIndexOf('.'));
//                        item.write(new File(uploadDir + File.separator + newFileName));
//                    }
//                }
//            } catch (Exception ex) {
//                ex.printStackTrace();
//                errorString = "File upload failed due to : " + ex.getMessage();
//                newFileName = "";
//            }
//        } else {
        try {
            Part filePart = request.getPart(propertyName);
            fileName = (String) getFileName(filePart);
            if (fileName == null) {
                return newFileName;
            }
            System.out.println("old file name " + fileName);
            String applicationPath = request.getServletContext().getRealPath("");
            String basePath = applicationPath + uploadDir;
            System.out.println("base path " + basePath);
            InputStream inputStream = null;
            OutputStream outputStream = null;
            try {
                String instanceName = request.getParameter("name");
                newFileName = instanceName + fileName.substring(fileName.lastIndexOf('.'));
                File outputFilePath = new File(basePath + newFileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorString = "File upload failed due to : " + e.getMessage();
                newFileName = "";
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorString = "File upload failed due to : " + e.getMessage();
            newFileName = "";
        }
//        }
        return newFileName;
    }

    private String getFileName(Part part) {
        final String partHeader = part.getHeader("content-disposition");
        System.out.println("part header " + partHeader);
        String[] partArr = partHeader.split(";");
        for (String content : partArr) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }

        return null;
    }
}
