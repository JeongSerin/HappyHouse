package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.QnA;
import com.ssafy.happyhouse.mapper.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService{
	
	@Autowired
	private QnAMapper qnaMapper;
	
	@Override
	public List<QnA> qnaList() {
		return qnaMapper.qnaList();
	}

	@Override
	public QnA detailQnA(int qnaNo) {
		return qnaMapper.detailQnA(qnaNo);
	}

	@Override
	public int writeQnA(QnA qna) {
		return qnaMapper.writeQnA(qna);
	}

	@Override
	public int deleteQnA(int qnaNo) {
		return qnaMapper.deleteQnA(qnaNo);
	}

}
