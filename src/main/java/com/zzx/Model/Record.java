package com.zzx.Model;

public class Record {
	private String record_id;
	private String lot_id;
	private String lot_name;
	private String space_id;
	private String pay_bonus;
	private String record_time_in;
	private String record_time_out;

	public String getRecord_id() {
		return record_id;
	}

	public void setRecord_id(String record_id) {
		this.record_id = record_id;
	}

	public String getLot_id() {
		return lot_id;
	}

	public void setLot_id(String lot_id) {
		this.lot_id = lot_id;
	}

	public String getLot_name() {
		return lot_name;
	}

	public void setLot_name(String lot_name) {
		this.lot_name = lot_name;
	}

	public String getSpace_id() {
		return space_id;
	}

	public void setSpace_id(String space_id) {
		this.space_id = space_id;
	}

	public String getPay_bonus() {
		return pay_bonus;
	}

	public void setPay_bonus(String pay_bonus) {
		this.pay_bonus = pay_bonus;
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
		return "Record [record_id=" + record_id + ", lot_id=" + lot_id + ", lot_name=" + lot_name + ", space_id="
				+ space_id + ", pay_bonus=" + pay_bonus + ", record_time_in=" + record_time_in + ", record_time_out="
				+ record_time_out + "]";
	}
}
