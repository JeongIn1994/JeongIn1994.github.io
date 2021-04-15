package com.flowerchest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.ProductVO;
import com.flowerchest.mapper.BoardAttachMapper;
import com.flowerchest.mapper.BoardMapper;
import com.flowerchest.mapper.ProductMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper pMapper;
	
	@Override
	public List<ProductVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return pMapper.getListWithPaging(cri);
	}

	@Override
	public List<ProductVO> getListWithCategory(Criteria cri) {
		// TODO Auto-generated method stub
		return pMapper.getListWithPagingAndCategory(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return pMapper.getTotalCount(cri);
	}
	
	@Override
	public int getToalWithCategory(Criteria cri) {
		// TODO Auto-generated method stub
		return pMapper.getTotalCountWithCategory(cri);
	}
	@Override
	public void register(ProductVO product) {
		// TODO Auto-generated method stub
		
		pMapper.insertSelectKey(product);
				
	}


	
	
	

}
