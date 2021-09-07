package com.flowerchest.mapper;

import java.util.List;

import com.flowerchest.domain.ProductAttachVO;

public interface ProductAttachMapper {

	public void insert(ProductAttachVO vo);
	
	public void delete(String uuid);
	
	public ProductAttachVO findByPid(Long pid);
	
	public void deleteAll(Long pid);
	
	public List<ProductAttachVO> getOldFiles();
}