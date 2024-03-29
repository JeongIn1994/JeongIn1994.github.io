package com.flowerchest.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.ProductVO;

public interface ProductService {
	
	public List<ProductVO> getList(Criteria cri);
	
	public List<ProductVO> getListWithCategory(Criteria cri);

	public void register(ProductVO product);
	
	public int getTotal(Criteria cri);
	
	public int getToalWithCategory(Criteria cri);
	
	public ProductVO get(Long pid);

	public boolean modify(ProductVO vo);

	public boolean remove(Long pid);
}