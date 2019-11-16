package com.zzx.Dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zzx.Model.Lot;

public interface LotMapper {

	public List<Lot> get_all();

	public void insert_lot(Lot lot);

	public void update_lot(Lot lot);

	public String get_status(Lot lot);

	public String get_lot_name(@Param("lot_id") String lot_id);

	public String get_free_start(@Param("lot_id") String lot_id);

	public String get_free_end(@Param("lot_id") String lot_id);

	public double get_price(@Param("lot_id") String lot_id);
}
