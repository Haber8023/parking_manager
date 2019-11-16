package com.zzx.Dao;

import java.util.List;

import com.zzx.Model.PayRecord;

public interface PayRecordMapper {

	List<PayRecord> get_all_record();

	void insert_pay_record(PayRecord p);

}
