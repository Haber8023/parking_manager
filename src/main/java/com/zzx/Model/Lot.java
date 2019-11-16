package com.zzx.Model;

public class Lot {

	private String lot_id;
	private String lot_price;
	private String lot_status;
	private String lot_name;
	private String lot_free_start;
	private String lot_free_end;

	public String getLot_id() {
		return lot_id;
	}

	public void setLot_id(String lot_id) {
		this.lot_id = lot_id;
	}

	public String getLot_price() {
		return lot_price;
	}

	public void setLot_price(String lot_price) {
		this.lot_price = lot_price;
	}

	public String getLot_status() {
		return lot_status;
	}

	public void setLot_status(String lot_status) {
		this.lot_status = lot_status;
	}

	public String getLot_name() {
		return lot_name;
	}

	public void setLot_name(String lot_name) {
		this.lot_name = lot_name;
	}

	public String getLot_free_start() {
		return lot_free_start;
	}

	public void setLot_free_start(String lot_free_start) {
		this.lot_free_start = lot_free_start;
	}

	public String getLot_free_end() {
		return lot_free_end;
	}

	public void setLot_free_end(String lot_free_end) {
		this.lot_free_end = lot_free_end;
	}

	@Override
	public String toString() {
		return "Lot [lot_id=" + lot_id + ", lot_price=" + lot_price + ", lot_status=" + lot_status + ", lot_name="
				+ lot_name + ", lot_free_start=" + lot_free_start + ", lot_free_end=" + lot_free_end + "]";
	}
}
