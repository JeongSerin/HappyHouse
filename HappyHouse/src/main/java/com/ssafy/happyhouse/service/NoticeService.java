package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.NoticeDto;

public interface NoticeService {

	public List<NoticeDto> noticeList();

	public List<NoticeDto> noticeSearchNo(int noticeno);

	public List<NoticeDto> noticeSearchSubject(String subject);
	
	public List<NoticeDto> noticeSearchContent(String content);
	
	
	public NoticeDto noticeDetail(int noticeno);
	
	public int noticeWrite(NoticeDto noticeDto);
	
	public int noticeDelete(int noticeno);
	
	public int noticeUpdate(NoticeDto noticeDto);
}
