package kingim.ws;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSON;
import kingim.utils.ServerConfig;
import kingim.vo.UFile;
import kingim.vo.UploadFile;
import java.util.regex.*;

@Controller
@RequestMapping("sns")
public class FileUpload {
	private String ROOT =  ServerConfig.get("root");
	   @RequestMapping(value = "/uploadFile", produces = "text/plain; charset=utf-8")
	   public @ResponseBody String uploadFile(@RequestParam(value = "file", required = false) MultipartFile file,int userId,HttpServletRequest request ) {
			UploadFile upFile = new UploadFile();
	        String path = request.getSession().getServletContext().getRealPath("upload/sns/"+userId+"/");  
	        String fileName = StringFilter(file.getOriginalFilename());
	        String ext=fileName.substring(fileName.lastIndexOf(".")+1);
	        if(file.getSize()>1024*1024*50){
	        	upFile.setCode(1);
	        	upFile.setMsg("单个文件/图片大小不能超过50M!");
	        	return JSON.toJSONString(upFile);
	        }
	        String name=UUID.randomUUID().toString()+"."+ext;
	        String downLoadPath=path+"/"+name;
	        File targetFile = new File(path,name);  
	        if(!targetFile.exists()){  
	            targetFile.mkdirs();  
	        }  
	       try {  
	    	  file.transferTo(targetFile);  
	    	  upFile.setCode(0);
	    	  UFile uf=new UFile();
			  uf.setName(fileName);
			  downLoadPath = URLEncoder.encode(downLoadPath, "UTF-8");
			  fileName = URLEncoder.encode(fileName, "UTF-8");
	    	  uf.setSrc(ROOT+"/sns/downLoadFile?downLoadPath="+downLoadPath+"&fileName="+fileName);
	    	  upFile.setData(uf);
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        return JSON.toJSONString(upFile);    
	  }
	   
	   
		@RequestMapping("/downLoadFile")  
	    public void downLoadFile(String downLoadPath, String fileName,HttpServletResponse response ) throws UnsupportedEncodingException {
	    	    BufferedInputStream bis = null;
		        BufferedOutputStream bos = null;  
		        try {
					downLoadPath = URLDecoder.decode(downLoadPath,"UTF-8");
					fileName = URLDecoder.decode(fileName,"UTF-8");
		        	response.setCharacterEncoding("UTF-8");
		            long fileLength = new File(downLoadPath).length();
			        response.setHeader("Content-disposition", "attachment; filename="+new String(fileName.getBytes("gbk"),"iso-8859-1"));
			        response.setContentType("application/x-download;");
		            response.setHeader("Content-Length", String.valueOf(fileLength));  
		            bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
		            bos = new BufferedOutputStream(response.getOutputStream());  
		            byte[] buff = new byte[2048];  
		            int bytesRead;  
		            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
		                bos.write(buff, 0, bytesRead);  
		            }  
		            bos.flush();  
		        } catch (Exception e) {  
		        } finally {  
		            if (bis != null) {  
		                try {
							bis.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
		            }  
		            if (bos != null) {  
		                try {
							bos.close();
						} catch (IOException e) {
							e.printStackTrace();
						}  
		            }  
		        }  
	    }  

	   // 过滤特殊字符  
	   public static String StringFilter(String str) throws PatternSyntaxException{     
	          // 清除掉所有特殊字符和空格
	          String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\]<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？ ]";  
	          Pattern p = Pattern.compile(regEx);     
	          Matcher m = p.matcher(str);     
	          return m.replaceAll("").trim();     
	   }
	   
}