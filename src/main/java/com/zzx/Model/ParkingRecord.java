package com.zzx.Model;

public class ParkingRecord {

	private String record_id;
	private String space_id;
	private String record_time_in;
	private String record_time_out;

	public String getRecord_id() {
		return record_id;
	}

	public void setRecord_id(String record_id) {
		this.record_id = record_id;
	}

	public String getSpace_id() {
		return space_id;
	}

	public void setSpace_id(String space_id) {
		this.space_id = space_id;
	}

	public String getRecord_time_in() {
		return record_time_in;
	}

	public void setRecord_time_in(String record_time_in) {
		this.record_time_in = record_time_in;
	}

	public String getRecord_time_out() {
		return record_time_out;
	}

	public void setRecord_time_out(String record_time_out) {
		this.record_time_out = record_time_out;
	}

	@Override
	public String toString() {
		return "ParkingRecord [record_id=" + record_id + ", space_id=" + space_id + ", record_time_in=" + record_time_in
				+ ", record_time_out=" + record_time_out + "]";
	}
}
