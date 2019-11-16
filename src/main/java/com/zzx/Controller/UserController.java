package com.zzx.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zzx.Model.Admin;
import com.zzx.Model.Lot;
import com.zzx.Model.PayRecord;
import com.zzx.Model.Record;
import com.zzx.Model.Space;
import com.zzx.Service.UserService;
import com.zzx.Utils.Tools;
import com.zzx.mqtt.Server;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	// 管理员用户登录
	@RequestMapping(value = "/login")
	public String login(String admin_name, String admin_psw, HttpSession session) {
		Admin admin = new Admin();
		admin.setAdmin_name(admin_name);
		admin.setAdmin_psw(admin_psw);
		if (userService.login(admin, session)) {
			return "mainPage";
		}
		return "loginFail";
	}

	// 管理员用户退出登录
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}

	// 主页
	@RequestMapping(value = "/mainPage")
	public String mainPage(HttpSession session) {
		userService.reMain(session);
		return "mainPage";
	}

	// 游客用户显示全部停车场
	@RequestMapping(value = "/check_all")
	public String checkAll(HttpSession session) {
		List<Lot> lot_list = userService.show_all_lot();
		if (lot_list != null) {
			session.setAttribute("lot_list", lot_list);
			return "showAllLotPage";
		}
		return "showFail";
	}

	// 游客用户显示全部停车场内车位状态
	@RequestMapping(value = "/show_all_space")
	public String showAllSpace(String lot_id, HttpSession session) {
		List<Space> space_list = userService.show_all_space(lot_id);
		if (space_list != null) {
			session.setAttribute("space_list", space_list);
			session.setAttribute("lot_name", userService.get_lot_name(lot_id));
			return "showAllSpacePage";
		}
		return "showFail";
	}

	// 新增管理员用户页面
	@RequestMapping(value = "/insertPage")
	public String insertAdminPage(HttpSession session) {
		session.setAttribute("message", "0");
		return "insertAdminPage";
	}

	// 新增用户
	@RequestMapping(value = "/insertAdmin")
	public String insertAdmin(String admin_name_input, String admin_psw_input, HttpSession session) {
		if (userService.insert_admin(admin_name_input, admin_psw_input)) {
			session.setAttribute("message", "1");
			return "insertAdminPage";
		}
		session.setAttribute("message", "2");
		return "insertAdminPage";
	}

	// 管理员用户修改密码页面
	@RequestMapping(value = "/updatePage")
	public String updatePage() {
		return "updateAdminPage";
	}

	// 修改密码
	@RequestMapping(value = "/updateInfo")
	public String updateInfo(String password, String password_new, HttpSession session) {
		String admin_name = (String) session.getAttribute("admin_name");
		if (userService.change_password(password, password_new, admin_name)) {
			return "updateSuccess";
		}
		return "updateFail";
	}

	// 新增停车场信息页面
	@RequestMapping(value = "/insertLotPage")
	public String insertLotPage(HttpSession session) {
		session.setAttribute("message", "0");
		return "insertLotPage";
	}

	// 新增停车场信息
	@RequestMapping(value = "/insertLot")
	public String inertLot(Lot lot, HttpSession session) {
		if (userService.insert_lot(lot)) {
			session.setAttribute("message", "1");
			return "insertLotPage";
		}
		session.setAttribute("message", "2");
		return "insertLotPage";
	}

	// 修改停车场信息
	@RequestMapping(value = "/updateLot")
	public String updateLot(Lot lot, HttpSession session) {
		if (userService.update_lot(lot)) {
			session.setAttribute("message", "1");
			return "manageLotPage";
		}
		session.setAttribute("message", "2");

		return "manageLotPage";
	}

	// 管理停车场页面
	@RequestMapping(value = "/manageLotPage")
	public String manageLotPage(HttpSession session) {
		List<Lot> lot_list = userService.show_all_lot();
		if (lot_list != null) {
			session.setAttribute("lot_list", lot_list);
		}
		session.setAttribute("message", "0");
		return "manageLotPage";
	}

	// 管理车位页面
	@RequestMapping(value = "/manageSpacePage")
	public String spacePage(HttpSession session, String lot_id_manage) {
		session.setAttribute("lot_id_manage", lot_id_manage);
		session.setAttribute("message", "0");
		List<Space> space_list = userService.show_all_space(lot_id_manage);
		if (space_list != null) {
			session.setAttribute("space_list", space_list);
			return "manageSpacePage";
		}
		session.setAttribute("message", "0");
		return "manageLotPage";
	}

	// 修改车位信息
	@RequestMapping(value = "/updateSpace")
	public String updateSpace(Space space, HttpSession session) {
		if (userService.update_space(space)) {
			session.setAttribute("message", "1");
			String lot_id_manage = (String) session.getAttribute("lot_id_manage");
			List<Space> space_list = userService.show_all_space(lot_id_manage);
			if (space_list != null) {
				session.setAttribute("space_list", space_list);
				return "manageSpacePage";
			}
			return "manageSpacePage";
		}
		session.setAttribute("message", "-1");
		return "manageSpacePage";
	}

	// 删除车位信息
	@RequestMapping(value = "/deleteSpace")
	public String deleteSpace(String space_id_delete, HttpSession session) {
		if (userService.delete_space(space_id_delete)) {
			session.setAttribute("message", "2");
			String lot_id_manage = (String) session.getAttribute("lot_id_manage");
			List<Space> space_list = userService.show_all_space(lot_id_manage);
			if (space_list != null) {
				session.setAttribute("space_list", space_list);
				return "manageSpacePage";
			}
			return "manageSpacePage";
		}
		session.setAttribute("message", "-1");
		return "manageSpacePage";
	}

	// 新增车位信息
	@RequestMapping(value = "/insertSpace")
	public String insertSpace(String lot_id_insert, String space_status, HttpSession session) {
		String status = Tools.getSpaceStatus(space_status);
		if (userService.insert_space(lot_id_insert, status)) {
			session.setAttribute("message", "3");
			return "manageLotPage";
		}
		session.setAttribute("message", "4");
		return "manageLotPage";
	}

	// 停车场全部完成的记录页面
	@RequestMapping("/recordPage")
    public ModelAndView recordPage(HttpSession session,
			@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request,
			Map<String,Object> map){
		System.out.println("sbw");
		PageHelper.startPage(currentPage,8);
		List<Record> list=userService.get_all_record();
		for(Record r:list)
			System.out.println(r.toString());
		PageInfo<Record> pageInfo=new PageInfo<Record>(list,8);
		map.put("pageInfo", pageInfo);
		return new ModelAndView("/recordPage");
	} 
	
	/*
	@RequestMapping(value = "/recordPage")
	public String recordPage(HttpSession session) {
		List<Record> record_list = userService.get_all_record();
		if (record_list != null) {
			session.setAttribute("record_list", record_list);
			return "recordPage";
		}
		return "index";
	}
*/
	
	// 停车场结算页面
	@RequestMapping(value = "/pay_for_space")
	public String payPage(String space_id, HttpSession session) {
		session.setAttribute("space_id", space_id);
		String record_id = userService.get_record_id(space_id);
		session.setAttribute("record_id", record_id);
		if (userService.set_record_out(record_id)) {
			session.setAttribute("record_time_in", userService.get_record_time_in(record_id));
			session.setAttribute("record_time_out", userService.get_record_time_out(record_id));
			session.setAttribute("amount", userService.compute_amount(record_id));
		}
		userService.reset_record_out(record_id);
		return "payPage";
	}
	
	// 停车场结算成功页面
	@RequestMapping(value = "/pay_result")
	public String paySuccess(HttpSession session) throws MqttException {
		String record_id = (String) session.getAttribute("record_id");
		String record_time_out = (String) session.getAttribute("record_time_out");
		if (userService.set_record_out_success(record_id, record_time_out)) {
			String space_id = userService.get_space_id_from_record(record_id);
			Space space = new Space();
			space.setSpace_id(space_id);
			space.setSpace_status("空闲");
			userService.update_space(space);
			String amount = String.valueOf(session.getAttribute("amount"));
			PayRecord p = new PayRecord();
			p.setPay_bonus(amount);
			p.setRecord_id(record_id);
			System.out.println("输出："+p.toString());
			userService.insert_pay_record(p);
			for (int i = 0; i < 10; i++) {
				Server server = new Server();
				server.message = new MqttMessage();
				server.message.setQos(2);
				server.message.setRetained(true);
				server.message.setPayload(("{P"+space_id+"=1}" + i).getBytes());
				server.publish(server.topic, server.message);
				System.out.println(server.message.isRetained() + "------ratained状态");
			}
			return "paySuccessPage";
		}
		return "payFailPage";
	}
	
	//QRPage
	@RequestMapping(value = "/QRPage")
	public String QRPage(HttpSession session) {
		session.setAttribute("message", "0");
		return "QRPage";
	}
	
	//QRsearch
	@RequestMapping(value = "/QRsearch")
	public String QRsearch(String space_id, HttpSession session) {
		int space_count = userService.get_space_count(space_id);
		if(space_count!=1) {
			session.setAttribute("message", "1");
			return "QRPage";
		}
		if(userService.get_space_status(space_id).equals("1")) {
		session.setAttribute("space_id", space_id);
		String record_id = userService.get_record_id(space_id);
		session.setAttribute("record_id", record_id);
		if (userService.set_record_out(record_id)) {
			session.setAttribute("record_time_in", userService.get_record_time_in(record_id));
			session.setAttribute("record_time_out", userService.get_record_time_out(record_id));
			session.setAttribute("amount", userService.compute_amount(record_id));
		}
		userService.reset_record_out(record_id);
		return "payPage";
		}
		session.setAttribute("message", "2");
		return "QRPage";
	}
	
}
