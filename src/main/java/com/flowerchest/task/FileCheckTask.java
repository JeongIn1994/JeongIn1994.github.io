package com.flowerchest.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.ProductAttachVO;
import com.flowerchest.mapper.BoardAttachMapper;
import com.flowerchest.mapper.ProductAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductAttachMapper pAttachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	@Scheduled(cron = " 0 0 2 * * *")
	public void checkFiles() throws Exception {
		
		List<ProductAttachVO> fileList = pAttachMapper.getOldFiles();
		
		List<Path> fileListPaths = fileList.stream().map(vo->Paths.get("C:\\upload\\",vo.getUploadPath(),vo.getUuid()+"_"+vo.getFileName())).collect(Collectors.toList());
		
		log.warn("-------------------------------");
		
		fileListPaths.forEach(p->log.warn(p));
		
		File targetDir = Paths.get("C:\\ipload",getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath())==false);
		
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			
			file.delete();
		}
	}
}
