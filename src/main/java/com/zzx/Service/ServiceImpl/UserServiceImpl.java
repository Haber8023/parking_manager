package com.zzx.Service.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzx.Model.Admin;
import com.zzx.Model.Lot;
import com.zzx.Model.ParkingRecord;
import com.zzx.Model.PayRecord;
import com.zzx.Model.Record;
import com.zzx.Model.Space;
import com.zzx.Model.WeekBonus;
import com.zzx.Dao.AdminMapper;
import com.zzx.Dao.LotMapper;
import com.zzx.Dao.PayRecordMapper;
import com.zzx.Dao.RecordMapper;
import com.zzx.Dao.SpaceMapper;
import com.zzx.Service.UserService;
import com.zzx.Utils.Tools;
import com.zzx.mqtt.Server;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	private LotMapper lotMapper;
	@Autowired
	private SpaceMapper spaceMapper;
	@Autowired
	private PayRecordMapper payRecordMapper;
	@Autowired
	private RecordMapper recordMapper;

	// 管理员用户登陆
	public boolean login(Admin admin, HttpSession session) {
		String admin_name = admin.getAdmin_name();
		String admin_psw = admin.getAdmin_psw();
		String psw = adminMapper.get_admin_psw(admin_name);
		if (psw == null)
			return false;
		if (admin_psw.equals(psw)) {
			session.setAttribute("admin_name", admin_name);
			session.setAttribute("today_bonus", recordMapper.get_today_bonus());
			session.setAttribute("month_bonus", recordMapper.get_month_bonus());
			session.setAttribute("year_bonus", recordMapper.get_year_bonus());

			List<WeekBonus> week_bonus = recordMapper.get_week_bonus();
			List<String> week_bonus_time = new ArrayList<String>();
			List<String> week_bonus_bonus = new ArrayList<String>();

			for (WeekBonus wb : week_bonus) {
				week_bonus_time.add("\"" + wb.getDate() + "\"");
				week_bonus_bonus.add(wb.getBonus());
			}
			session.setAttribute("week_bonus_time", week_bonus_time);
			session.setAttribute("week_bonus_bonus", week_bonus_bonus);

			return true;
		}
		return false;
	}

	// 显示所有停车场
	public List<Lot> show_all_lot() {
		return lotMapper.get_all();
	}

	// 显示当前停车场所有车位
	public List<Space> show_all_space(String lot_id) {
		return spaceMapper.get_all(lot_id);
	}

	// 修改密码
	public boolean change_password(String password, String password_new, String admin_name) {
		String password_record = adminMapper.get_admin_psw(admin_name);
		if (password.equals(password_record)) {
			try {
				adminMapper.update_admin_psw(admin_name, password_new);
			} catch (Exception e) {
				return false;
			}
			return true;
		}
		return false;
	}

	// 插入新管理员信息
	public boolean insert_admin(String admin_name_input, String admin_psw_input) {
		try {
			adminMapper.insert_admin(admin_name_input, admin_psw_input);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	// 插入新停车场信息
	public boolean insert_lot(Lot lot) {
		String status = Tools.getLotStatus(lot.getLot_status());
		lot.setLot_status(status);
		try {
			lotMapper.insert_lot(lot);
		} catch (Exception e) {
			System.err.println("insert fail");
			return false;
		}
		return true;
	}

	// 修改停车场信息
	public boolean update_lot(Lot lot) {
		String status = Tools.getLotStatus(lot.getLot_status());
		String status_old = lotMapper.get_status(lot);
		lot.setLot_status(status);
		if (status_old.equals("1") && status.equals("0")) {
			try {
				lotMapper.update_lot(lot);
				spaceMapper.open_all(lot.getLot_id());
			} catch (Exception e) {
				System.err.println("update_lot update fail");
				return false;
			}
		} else if (status_old.equals("0") && status.equals("1")) {
			try {
				lotMapper.update_lot(lot);
				spaceMapper.close_all(lot.getLot_id());
			} catch (Exception e) {
				System.err.println("update_lot update fail");
				return false;
			}
		}
		return true;
	}

	// 修改车位信息
	public boolean update_space(Space space) {
		System.out.println(space.toString());
		String space_status = Tools.getSpaceStatus(space.getSpace_status());
		String space_id = space.getSpace_id();
		space.setSpace_status(space_status);
		try {
			spaceMapper.update_space(space);
			if (space_status.equals("0")) {
				for (int i = 0; i < 10; i++) {
					Server server = new Server();
					server.message = new MqttMessage();
					server.message.setQos(2);
					server.message.setRetained(true);
					server.message.setPayload(("{P" + space_id + "=1}" + i).getBytes());
					server.publish(server.topic, server.message);
					System.out.println("{P" + space_id + "=1}");
					System.out.println(server.message.isRetained() + "------ratained状态");
				}
			}
			if (space_status.equals("1")) {
				for (int i = 0; i < 10; i++) {
					Server server = new Server();
					server.message = new MqttMessage();
					server.message.setQos(2);
					server.message.setRetained(true);
					server.message.setPayload(("{P" + space_id + "=0}" + i).getBytes());
					server.publish(server.topic, server.message);
					System.out.println("{P" + space_id + "=0}");
					System.out.println(server.message.isRetained() + "------ratained状态");
				}
			}
		} catch (Exception e) {
			System.err.println("update_space update fail");
			return false;
		}
		return true;
	}

	// 删除车位信息
	public boolean delete_space(String space_id_delete) {
		try {
			spaceMapper.delete_space_record(space_id_delete);
			spaceMapper.delete_space(space_id_delete);
		} catch (Exception e) {
			System.err.println("delete fail");
			return false;
		}
		return true;
	}

	// 插入车位信息
	public boolean insert_space(String lot_id_insert, String space_status) {
		try {
			spaceMapper.insert_space(lot_id_insert, space_status);
			return true;
		} catch (Exception e) {
			System.out.println("insert fail");
			return false;
		}
	}

	// 根据停车场ID获取停车场名
	public String get_lot_name(String lot_id) {
		return lotMapper.get_lot_name(lot_id);
	}

	// 记录驶出时间
	public boolean set_record_out(String record_id) {
		try {
			recordMapper.set_record_out(record_id);
		} catch (Exception e) {
			System.err.println("set_record_out update fail");
			return false;
		}
		return true;
	}

	// 根据车位ID获取记录ID
	public String get_record_id(String space_id) {
		return recordMapper.get_record_id(space_id);
	}

	// 根据记录ID获取驶入时间
	public String get_record_time_in(String record_id) {
		return recordMapper.get_record_time_in(record_id);
	}

	// 根据记录ID获取驶出时间
	public String get_record_time_out(String record_id) {
		return recordMapper.get_record_time_out(record_id);
	}

	// 计算停车金额
	public double compute_amount(String record_id) {
		String space_id = recordMapper.get_space_id_from_record(record_id);
		String lot_id = spaceMapper.get_lot_id_from_space(space_id);
		String string_time_in = recordMapper.get_record_time_in(record_id);
		String string_time_out = recordMapper.get_record_time_out(record_id);
		String string_free_start = lotMapper.get_free_start(lot_id);
		String string_free_end = lotMapper.get_free_end(lot_id);
		double price = lotMapper.get_price(lot_id);
		long span_hour = Tools.getSpanHour(string_time_in, string_time_out, string_free_start, string_free_end);
		return (double) span_hour * price;
	}

	// 重置驶出时间
	public void reset_record_out(String record_id) {
		recordMapper.reset_record_out(record_id);
	}

	// 确定驶出时间
	public boolean set_record_out_success(String record_id, String record_time_out) {
		try {
			recordMapper.set_record_out_success(record_id, record_time_out);
		} catch (Exception e) {
			System.err.println("set_record_out_success update fail");
			return false;
		}
		return true;
	}

	// 根据record获取车位ID
	public String get_space_id_from_record(String record_id) {
		return recordMapper.get_space_id_from_record(record_id);
	}

	// 获取全部交易完成停车记录
	public List<Record> get_all_record() {
		return recordMapper.get_all_record();
	}

	// 插入交易记录
	public void insert_pay_record(PayRecord p) {
		payRecordMapper.insert_pay_record(p);
	}

	// 获取全部停车记录
	public List<ParkingRecord> get_all_parking_record() {
		recordMapper.get_all_parking_record();
		return null;
	}

	public void reMain(HttpSession session) {
		session.setAttribute("today_bonus", recordMapper.get_today_bonus());
		session.setAttribute("month_bonus", recordMapper.get_month_bonus());
		session.setAttribute("year_bonus", recordMapper.get_year_bonus());
		List<WeekBonus> week_bonus = recordMapper.get_week_bonus();
		List<String> week_bonus_time = new ArrayList<String>();
		List<String> week_bonus_bonus = new ArrayList<String>();
		for (WeekBonus wb : week_bonus) {
			week_bonus_time.add("\"" + wb.getDate() + "\"");
			week_bonus_bonus.add(wb.getBonus());
		}
		session.setAttribute("week_bonus_time", week_bonus_time);
		session.setAttribute("week_bonus_bonus", week_bonus_bonus);
	}

	public int get_space_count(String space_id) {
		return (spaceMapper.get_space_count(space_id));
	}

	public String get_space_status(String space_id) {
		return (spaceMapper.get_space_status(space_id));
	}
}
