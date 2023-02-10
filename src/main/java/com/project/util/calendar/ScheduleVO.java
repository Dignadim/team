package com.project.util.calendar;

//	달력에 출력할 스케줄정보 하나하나
public class ScheduleVO 
{
	private int sYear;	//	스케줄이 시작하는 년도
	private int sMonth;	//	스케줄이 시작하는 달
	private int sDay;	//	스케줄이 시작하는 날짜
	private int eYear = 0;	//	스케줄이 끝나는 년도
	private int eMonth;	//	스케줄이 끝나는 달
	private int eDay;	//	스케줄이 끝나는 날짜
	private String event;	//	출력할 스케줄 내용
	private int gup = -1;		//	어느 행사게시판에서 추가 되었는지 알기위한 용도
	private String CVS;	//	어느 편의점 행사인지 확인
	
	public ScheduleVO() {}
	public ScheduleVO(int sYear, int sMonth, int sDay, int eYear, int eMonth, int eDay, String event, int gup,
			String CVS) {
		super();
		this.sYear = sYear;
		this.sMonth = sMonth;
		this.sDay = sDay;
		this.eYear = eYear;
		this.eMonth = eMonth;
		this.eDay = eDay;
		this.event = event;
		this.gup = gup;
		this.CVS = CVS;
	}
	
	public void init(int sYear, int sMonth, int sDay, int eYear, int eMonth, int eDay, String event, int gup, String CVS) {
		this.sYear = sYear;
		this.sMonth = sMonth;
		this.sDay = sDay;
		this.eYear = eYear;
		this.eMonth = eMonth;
		this.eDay = eDay;
		this.event = event;
		this.gup = gup;
		this.CVS = CVS;
	}
	
	public int getsYear() {
		return sYear;
	}
	public void setsYear(int sYear) {
		this.sYear = sYear;
	}
	public int getsMonth() {
		return sMonth;
	}
	public void setsMonth(int sMonth) {
		this.sMonth = sMonth;
	}
	public int getsDay() {
		return sDay;
	}
	public void setsDay(int sDay) {
		this.sDay = sDay;
	}
	public int geteYear() {
		return eYear;
	}
	public void seteYear(int eYear) {
		this.eYear = eYear;
	}
	public int geteMonth() {
		return eMonth;
	}
	public void seteMonth(int eMonth) {
		this.eMonth = eMonth;
	}
	public int geteDay() {
		return eDay;
	}
	public void seteDay(int eDay) {
		this.eDay = eDay;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public int getGup() {
		return gup;
	}
	public void setGup(int gup) {
		this.gup = gup;
	}
	
	public String getCVS() {
		return CVS;
	}
	public void setCVS(String cVS) {
		CVS = cVS;
	}
	
	@Override
	public String toString() {
		return "ScheduleVO [sYear=" + sYear + ", sMonth=" + sMonth + ", sDay=" + sDay + ", eYear=" + eYear + ", eMonth="
				+ eMonth + ", eDay=" + eDay + ", event=" + event + ", gup=" + gup + ", CVS=" + CVS + "]";
	}

}