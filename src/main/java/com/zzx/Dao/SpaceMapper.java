package com.zzx.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zzx.Model.Space;

public interface SpaceMapper {

	public List<Space> get_all(@Param("lot_id") String lot_id);

	public void update_space(Space space);

	public void delete_space(@Param("space_id_delete") String space_id_delete);

	public void delete_space_record(@Param("space_id_delete") String space_id_delete);

	public void insert_space(@Param("lot_id_insert") String lot_id_insert, @Param("space_status") String space_status);

	public void open_all(@Param("lot_id") String lot_id);

	public void close_all(@Param("lot_id") String lot_id);

	public String get_lot_id_from_space(@Param("space_id") String space_id);
	
	public int get_space_count(@Param("space_id")String space_id);

	public String get_space_status(@Param("space_id")String space_id);
}
