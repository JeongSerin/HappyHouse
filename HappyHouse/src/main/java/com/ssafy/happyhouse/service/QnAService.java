package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.QnA;

public interface QnAService {
	List<QnA> qnaList();
	QnA detailQnA(int qnaNo);
	int writeQnA(QnA qna);
	int deleteQnA(int qnaNo);
}
