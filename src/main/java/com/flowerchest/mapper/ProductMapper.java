package com.flowerchest.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.ProductVO;

public interface ProductMapper {
	
	public List<ProductVO> getList();
	
	public List<ProductVO> getListWithPaging(Criteria cri,String category);
	
	public void insert(ProductVO product);
	
	public void insertSelectKey(ProductVO product);
	
	public ProductVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(ProductVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("pid")Long pid,@Param("amount")int amount);
}