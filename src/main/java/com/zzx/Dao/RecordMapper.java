package com.zzx.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zzx.Model.Record;
import com.zzx.Model.WeekBonus;

public interface RecordMapper {

	void set_record_out(@Param("record_id") String record_id);

	String get_record_id(@Param("space_id") String space_id);

	String get_record_time_in(@Param("record_id") String record_id);

	String get_record_time_out(@Param("record_id") String record_id);

	String compute_amount(@Param("record_id") String record_id);

	void reset_record_out(@Param("record_id") String record_id);

	void set_record_out_success(@Param("record_id") String record_id, @Param("record_time_out") String record_time_out);

	String get_space_id_from_record(@Param("record_id") String record_id);

	void get_all_parking_record();

	List<Record> get_all_record();

	String get_today_bonus();

	String get_month_bonus();

	String get_year_bonus();

	List<WeekBonus> get_week_bonus();
}
