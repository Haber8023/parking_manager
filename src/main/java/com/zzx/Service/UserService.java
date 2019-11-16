package com.zzx.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.zzx.Model.Admin;
import com.zzx.Model.Lot;
import com.zzx.Model.ParkingRecord;
import com.zzx.Model.PayRecord;
import com.zzx.Model.Record;
import com.zzx.Model.Space;

public interface UserService {
	// 管理员用户登陆
	public boolean login(Admin admin, HttpSession session);

	// 显示所有停车场
	public List<Lot> show_all_lot();

	// 显示当前停车场所有车位
	public List<Space> show_all_space(String lot_id);

	// 修改密码
	public boolean change_password(String password, String password_new, String admin_name);

	// 插入新管理员信息
	public boolean insert_admin(String admin_name_input, String admin_psw_input);

	// 插入新停车场信息
	public boolean insert_lot(Lot lot);

	// 修改停车场信息
	public boolean update_lot(Lot lot);

	// 修改车位信息
	public boolean update_space(Space space);

	// 删除车位信息
	public boolean delete_space(String space_id_delete);

	// 插入车位信息
	public boolean insert_space(String lot_id_insert, String space_status);

	// 根据停车场ID获取停车场名
	public String get_lot_name(String lot_id);

	// 记录驶出时间
	public boolean set_record_out(String record_id);

	// 根据车位ID获取记录ID
	public String get_record_id(String space_id);

	// 根据记录ID获取驶入时间
	public String get_record_time_in(String record_id);

	// 根据记录ID获取驶出时间
	public String get_record_time_out(String record_id);

	// 计算停车金额
	public double compute_amount(String record_id);

	// 重置驶出时间
	public void reset_record_out(String record_id);

	// 确定驶出时间
	public boolean set_record_out_success(String record_id, String record_time_out);

	// 根据record获取车位ID
	public String get_space_id_from_record(String record_id);

	// 获取全部交易完成停车记录
	public List<Record> get_all_record();

	// 插入交易记录
	public void insert_pay_record(PayRecord p);

	// 获取全部停车记录
	public List<ParkingRecord> get_all_parking_record();

	public void reMain(HttpSession session);
	
	public int get_space_count(String space_id);

	public String get_space_status(String space_id);


}
