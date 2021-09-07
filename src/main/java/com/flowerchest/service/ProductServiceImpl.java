package com.flowerchest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.ProductAttachVO;
import com.flowerchest.domain.ProductVO;

import com.flowerchest.mapper.ProductAttachMapper;
import com.flowerchest.mapper.ProductMapper;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper pMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductAttachMapper attachMapper;	
	
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
	@Transactional
	@Override
	public void register(ProductVO product) {
		// TODO Auto-generated method stub
		
		ProductAttachVO attach = product.getAttachImage();	
		pMapper.insertSelectKey(product);
		
		if(product.getAttachImage() == null) {
			return;
		}		
		attach.setPid(product.getPid());
		attachMapper.insert(attach);
		log.info(attach);
		log.info("========================");
	}

	@Override
	public ProductVO get(Long pid) {
		
		return pMapper.read(pid);
	}

	@Override
	public boolean modify(ProductVO product) {
		// TODO Auto-generated method stub
		log.info("product Update");
		
		attachMapper.deleteAll(product.getPid());
		
		boolean modifyResult = pMapper.update(product) == 1;
		ProductAttachVO attach = product.getAttachImage();	
		
		attach.setPid(product.getPid());
		attachMapper.insert(attach);
			
		
		return modifyResult;
	}

	@Override
	public boolean remove(Long pid) {
		// TODO Auto-generated method stub
		attachMapper.deleteAll(pid);
		
		return pMapper.delete(pid) == 1;
	}


	

}
