package com.zzx.Model;

public class PayRecord {

	private String record_id;
	private String pay_bonus;

	public String getRecord_id() {
		return record_id;
	}

	public void setRecord_id(String record_id) {
		this.record_id = record_id;
	}

	public String getPay_bonus() {
		return pay_bonus;
	}

	public void setPay_bonus(String pay_bonus) {
		this.pay_bonus = pay_bonus;
	}

	@Override
	public String toString() {
		return "PayRecord [record_id=" + record_id + ", pay_bonus=" + pay_bonus + "]";
	}

}
