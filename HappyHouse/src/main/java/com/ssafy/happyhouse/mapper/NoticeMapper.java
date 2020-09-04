package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.NoticeDto;

@Mapper
public interface NoticeMapper {
	// 공지사항 리스트
	public List<NoticeDto> noticeList();
	// 글번호로 검색
	public List<NoticeDto> noticeSearchNo(int noticeno);
	// 제목으로 검색
	public List<NoticeDto> noticeSearchSubject(String subject);
	// 내용으로 검색
	public List<NoticeDto> noticeSearchContent(String content);
	// 상세보기
	public NoticeDto noticeDetail(int noticeno);
	// 공지사항 쓰기
	public int noticeWrite(NoticeDto noticeDto);
	// 삭제
	public int noticeDelete(int noticeno);
	// 수정
	public int noticeUpdate(NoticeDto noticeDto);
}
