/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

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
    public String uploadFile(HttpServletRequest request, String uploadDir, String propertyName) throws IOException, ServletException{
        String fileName="";
        String newFileName="";
        try{
            Part filePart = request.getPart(propertyName);   
            fileName = (String) getFileName(filePart);
            if(fileName == null) return newFileName;
            System.out.println("old file name "+fileName);
            String applicationPath = request.getServletContext().getRealPath("");
            String basePath = applicationPath + uploadDir;
            System.out.println("base path "+basePath);
            InputStream inputStream = null;
            OutputStream outputStream = null;
            try {
                String instanceName = request.getParameter("name");
                newFileName = instanceName+fileName.substring(fileName.lastIndexOf('.'));
                File outputFilePath = new File(basePath + newFileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read = 0;
                final byte[] bytes =  new  byte[1024];
                while((read = inputStream.read(bytes)) != -1){
                    outputStream.write(bytes, 0, read);
                }
            } catch (Exception e) {
                e.printStackTrace();
                newFileName = "";
            }finally{
                if(inputStream != null){
                    inputStream.close();
                }
                if(outputStream != null){
                    outputStream.close();
                }
            }
            
        }catch(Exception e){
            e.printStackTrace();
            newFileName = "";
        }
        return newFileName;
    }
    private String  getFileName(Part part){
        final String  partHeader = part.getHeader("content-disposition");
        System.out.println("part header "+partHeader);
        String[] partArr = partHeader.split(";");
        for(String content : partArr){
            if(content.trim().startsWith("filename")){
                return content.substring(content.indexOf('=')+1).trim().replace("\"", "" );
            }
        }
        
        return null;
    }    
}
