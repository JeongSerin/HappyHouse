package com.ssafy.happyhouse.dto;

public class HouseInfoDto {
	/**아파트를 식별할 번호*/
	private String no;
	/**법정 동명 */
	private String dong;
	/**아파트 이름 */
	private String aptName;
	/**법정 동코드 */
	private String code;
	/**건축 연도*/
	private int buildYear;
	/**지번*/
	private String jibun;
	/**위도경도*/
	private String lat;
	private String lng;
	/**이미지 경로*/
	protected String img;
	
	public HouseInfoDto() {	}
	public HouseInfoDto(String no) {
		super();
		this.no = no;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAptName() {
		return aptName;
	}
	public void setAptName(String aptName) {
		this.aptName = aptName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public int getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(int buildYear) {
		this.buildYear = buildYear;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public int compareTo(HouseInfoDto o) {
		if(o!=null && o.dong != null&&dong!=null) {
			return dong.compareTo(o.dong);
		}
		return 0;
	}
	
	@Override
	public String toString() {
		return "HouseInfoDto [no=" + no + ", dong=" + dong + ", aptptName=" + aptName + ", code=" + code + ", buildYear="
				+ buildYear + ", jibun=" + jibun + ", img=" + img + "]";
	}
}
