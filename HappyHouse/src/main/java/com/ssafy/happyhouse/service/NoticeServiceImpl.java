package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	// 공지사항 리스트
	@Override
	public List<NoticeDto> noticeList() {
		return noticeMapper.noticeList();
	}
	
	// 공지사항 상세
	@Override
	public NoticeDto noticeDetail(int noticeno) {
		return noticeMapper.noticeDetail(noticeno);
	}

	// 공지사항 등록
	@Override
	public int noticeWrite(NoticeDto noticeDto) {
		return noticeMapper.noticeWrite(noticeDto);
	}
	
	// 글 삭제
	@Override
	public int noticeDelete(int noticeno) {
		return noticeMapper.noticeDelete(noticeno);
	}

	// 수정
	@Override
	public int noticeUpdate(NoticeDto noticeDto) {
		return noticeMapper.noticeUpdate(noticeDto);
	}

	// 글 번호로 검색
	@Override
	public List<NoticeDto> noticeSearchNo(int noticeno) {
		return noticeMapper.noticeSearchNo(noticeno);
	}
	
	// 글 제목으로 검색
	@Override
	public List<NoticeDto> noticeSearchSubject(String subject) {
		return noticeMapper.noticeSearchSubject(subject);
	}

	// 내용으로 검색
	@Override
	public List<NoticeDto> noticeSearchContent(String content) {
		return noticeMapper.noticeSearchContent(content);
	}
	
	

}
