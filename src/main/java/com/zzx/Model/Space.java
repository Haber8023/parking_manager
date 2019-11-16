package com.zzx.Model;

public class Space {

	private String space_id;
	private String space_status;

	public String getSpace_id() {
		return space_id;
	}

	public void setSpace_id(String space_id) {
		this.space_id = space_id;
	}

	public String getSpace_status() {
		return space_status;
	}

	public void setSpace_status(String space_status) {
		this.space_status = space_status;
	}

	@Override
	public String toString() {
		return "Space [space_id=" + space_id + ", space_status=" + space_status + "]";
	}
}
