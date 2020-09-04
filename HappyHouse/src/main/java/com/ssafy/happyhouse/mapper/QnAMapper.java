package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.HouseDealDto;
import com.ssafy.happyhouse.dto.QnA;

@Mapper
public interface QnAMapper {

	public List<QnA> qnaList();
	public QnA detailQnA(int qnaNo);
	public int writeQnA(QnA qna);
	public int deleteQnA(int qnaNo);
//	public List<HouseDealDto> houseSearchDong(String dong);
//	public List<HouseDealDto> houseSearchAptName(String aptName);
//	public HouseDealDto housedealDetail(int no);
	
}
