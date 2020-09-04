package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.QnA;
import com.ssafy.happyhouse.service.QnAService;

import io.swagger.annotations.ApiOperation;
//http://localhost:9999/happyhouse/swagger-ui.html
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/api/qna")
public class QnAController {

	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);

	@Autowired
	private QnAService qnaService;

	// swagger
    @ApiOperation(value = "모든 QnA글의 정보를 반환한다.", response = List.class)
	@GetMapping
	public ResponseEntity<List<QnA>> retrieveQnA() throws Exception {
		logger.debug("retrieveQnA - 호출");
		return new ResponseEntity<List<QnA>>(qnaService.qnaList(), HttpStatus.OK);
	}
    
    @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 반환한다.", response = QnA.class)    
   	@GetMapping("{qna_no}")
   	public ResponseEntity<QnA> detailBoard(@PathVariable int qna_no) {
   		logger.debug("detailQnA- 호출");
   		return new ResponseEntity<QnA>(qnaService.detailQnA(qna_no), HttpStatus.OK);
   	}

    @ApiOperation(value = "새로운 게시글 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
   	@PostMapping
   	public ResponseEntity<Integer> writeBoard(@RequestBody QnA qna, HttpServletRequest req) {
   		logger.debug("writeBoard - 호출");
   		HttpSession session = req.getSession(true);
   		qna.setQnaUserid((String)session.getAttribute("userid"));
   		int result = qnaService.writeQnA(qna);
   		return new ResponseEntity<Integer>(result, HttpStatus.NO_CONTENT);
  
   	}

    @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 수정한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
   	@PutMapping("{no}")
   	public ResponseEntity<String> updateBoard(@RequestBody QnA qna) {
   		logger.debug("updateQnA - 호출");
   		logger.debug("" + qna);
   		
//   		if (qnaService.updateQnA(qna)) {
//   			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
//   		}
//   		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
   		return null;
   	}

    @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
   	@DeleteMapping("{qna_no}")
   	public ResponseEntity<Integer> deleteQnA(@PathVariable int qna_no) {
   		logger.debug("deleteQnA - 호출");
   		int result = qnaService.deleteQnA(qna_no);
   		return new ResponseEntity<Integer>(result, HttpStatus.NO_CONTENT);
   	}

}