package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// 공지사항 페이지 가져오기
	@GetMapping(value="/mvnotice")
	public String mvNotice() {
		return "notice/noticeList";
	}
	
	// 공지사항 리스트
	@ResponseBody
	@GetMapping(value="/noticeList")
	public List<NoticeDto> noticeList() {
		return noticeService.noticeList();
	}
	
	// 글 번호로 검색
	@ResponseBody
	@GetMapping(value="/noticeSearchNo/{noticeno}")
	public List<NoticeDto> noticeSearch(@PathVariable int noticeno) {
		return noticeService.noticeSearchNo(noticeno);
	}
	
	// 글 제목으로 검색
	@ResponseBody
	@GetMapping(value="/noticeSearchSubject/{subject}")
	public List<NoticeDto> noticeSearchSub(@PathVariable String subject) {
		return noticeService.noticeSearchSubject(subject);
	}
	
	// 글 내용으로 검색
	@ResponseBody
	@GetMapping(value="/noticeSearchContent/{content}")
	public List<NoticeDto> noticeSearchCon(@PathVariable String content) {
		return noticeService.noticeSearchContent(content);
	}
	
	// 공지사항 상세보기
	@ResponseBody
	@GetMapping(value="/noticeDetail/{noticeno}")
	public NoticeDto noticeDetail(@PathVariable int noticeno) {
		System.out.println(noticeService.noticeDetail(noticeno));
		return noticeService.noticeDetail(noticeno);
	}
	
	// 공지사항 등록
	@ResponseBody
    @PostMapping(value="/noticeWrite")
   	public ResponseEntity<Integer> noticeWrite(NoticeDto noticeDto) {
		int result = noticeService.noticeWrite(noticeDto);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
    }
	
	// 삭제
	@DeleteMapping(value="noticeDelete/{noticeno}")
	public ResponseEntity<Integer> noticeDelete(@PathVariable int noticeno){
		int result = noticeService.noticeDelete(noticeno);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	// 수정
	@PutMapping(value="/noticeUpdate/{noticeno}")
	public ResponseEntity<Integer> update(@PathVariable int noticeno, @RequestBody NoticeDto noticeDto) {
		return new ResponseEntity<Integer>(noticeService.noticeUpdate(noticeDto), HttpStatus.OK);
	}
	
}
