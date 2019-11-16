package com.zzx.Utils;

import java.sql.Timestamp;

public class Tools {

	// 获取停车场状态
	public static String getLotStatus(String status) {
		if (status.equals("运营中")) {
			return "0";
		}
		if (status.equals("暂停使用")) {
			return "1";
		}
		return "-1";
	}

	// 获取车位状态
	public static String getSpaceStatus(String status) {
		if (status.equals("空闲")) {
			return "0";
		}
		if (status.equals("占用")) {
			return "1";
		}
		if (status.equals("维护 ")) {
			return "2";
		}
		return "-1";
	}

	// 计算停车时长
	public static long getSpanHour(String string_time_in, String string_time_out, String string_free_start,
			String string_free_end) {
		try {
			// 包含的完整的免费时段次数
			int span_times = 0;

			// 跨天停车标识符
			boolean dayFlag = false;
			String date = string_time_in.substring(0, 10);
			string_free_start = date + " " + string_free_start;
			string_free_end = date + " " + string_free_end;

			// 驶入时间
			Timestamp time_in = Timestamp.valueOf(string_time_in);
			// 驶出时间
			Timestamp time_out = Timestamp.valueOf(string_time_out);

			double span_hour = (time_out.getTime() - time_in.getTime()) / (60.0 * 60.0 * 1000.0);

			// 免费时段开始
			Timestamp free_start = Timestamp.valueOf(string_free_start);
			// 免费时段结束
			Timestamp free_end = Timestamp.valueOf(string_free_end);
			// 免费时段时长（小时）
			double span_free_hour = (free_end.getTime() - free_start.getTime()) / (60.0 * 60.0 * 1000.0) + 24.0;

			// 停车时间超过24小时，跨天停车标识符为true，减去一个免费时段时长
			double boundary = span_hour;
			while (boundary >= 24.0) {
				boundary -= 24.0;
				span_times++;
				dayFlag = true;
			}
			span_hour = span_hour - span_times * span_free_hour;

			// 时间转化为同一天进行计算剩余时长
			time_in.setYear(time_out.getYear());
			time_in.setMonth(time_out.getMonth());
			time_in.setDate(time_out.getDate());
			free_start.setYear(time_out.getYear());
			free_start.setMonth(time_out.getMonth());
			free_start.setDate(time_out.getDate());
			free_end.setYear(time_out.getYear());
			free_end.setMonth(time_out.getMonth());
			free_end.setDate(time_out.getDate());

			 if(dayFlag) {//停车总时长超过24小时
	            	if (time_in.before(free_end) || time_in.after(free_start)) {// 免费时段驶入
	    				if (time_out.before(free_end) || time_out.after(free_start)) {// 免费时段驶出
	    					if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
								span_hour -= (time_out.getTime() - time_in.getTime()) / (60.0 * 60.0 * 1000.0);
							} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
								span_hour -= 24.0 - Math.ceil((time_in.getTime() - time_out.getTime()) / (60.0 * 60.0 * 1000.0));
							} else {
								// do nothing
							}
	    				}
	    				else {// 非免费时段驶出
	    						if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
	    							span_hour -= (free_end.getTime() - time_in.getTime()) / (60.0 * 60.0 * 1000.0);
	    						} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
	    							span_hour -= 24.0 - (time_in.getTime() - free_end.getTime()) / (60.0 * 60.0 * 1000.0);
	    						}
	    				}
	                   }
	            	 else {// 非免费时段驶入
	     				if (time_out.before(free_end) || time_out.after(free_start)) {// 免费时段驶出

	     						if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
	     							span_hour -= (time_out.getTime() - free_start.getTime()) / (60.0 * 60.0 * 1000.0);
	     						} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
	     							span_hour -= (time_out.getTime() - free_start.getTime()) / (60.0 * 60.0 * 1000.0)+24.0;
	     						}
	     				}
	                    else {// 非免费时段驶出
	     						if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
	     							// do nothing
	     						} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
	     							span_hour -= 24.0 - ((time_in.getTime() - time_out.getTime()) / (60.0 * 60.0 * 1000.0));
	     							span_hour += (free_start.getTime() - time_in.getTime()) / (60.0 * 60.0 * 1000.0);
	     							span_hour += (time_out.getTime() - free_end.getTime()) / (60.0 * 60.0 * 1000.0);
	     						}
	                    }
	            	 }
	            }

	            else {//停车总时长不超过24小时
	            	if (time_in.before(free_end) || time_in.after(free_start)) {// 免费时段驶入
	    				if (time_out.before(free_end) || time_out.after(free_start)) {// 免费时段驶出
							if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
	    					if(span_hour>24.0-span_free_hour){//经历了收费时段
								span_hour=24.0-span_free_hour;
							}else {//一直处于免费时段
							span_hour = 0.0;
							}
							} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
		    					if(span_hour>24.0-span_free_hour){//经历了收费时段
								span_hour -= span_free_hour;
								}else {//一直处于免费时段
									span_hour = 0.0;
									}
							} else {
								// do nothing
							}
	    				}
	    				else {// 非免费时段驶出
							if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
								span_hour -= (free_end.getTime() - time_in.getTime()) / (60.0 * 60.0 * 1000.0);
							} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
								span_hour -= 24.0 - (time_in.getTime() - free_end.getTime()) / (60.0 * 60.0 * 1000.0);
							}
	    				}
	                   }
	            	 else {// 非免费时段驶入
	     				if (time_out.before(free_end) || time_out.after(free_start)) {// 免费时段驶出
	     					if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
								span_hour -= (time_out.getTime() - free_start.getTime()) / (60.0 * 60.0 * 1000.0);
	     		
							} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
								span_hour -= (time_out.getTime() - free_start.getTime()) / (60.0 * 60.0 * 1000.0)+24.0;
							}
	     				}
	                    else {// 非免费时段驶出
							if (time_in.before(time_out)) {// 转化为一天后，驶入时间在驶出时间之前
								// do nothing
							} else if (time_in.after(time_out)) {// 转化为一天后，驶入时间在驶出时间之后
								span_hour -= span_free_hour;
							}
	            	 }
	            	 }
	            }

			// 超过15分钟按一小时收费，15分钟内免费
			long pay_hour = (long) span_hour;
			double over_hour = span_hour - pay_hour;
			if (over_hour > 0.25)
				pay_hour++;

			return pay_hour;
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return -1;
	}
}
