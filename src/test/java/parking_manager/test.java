package parking_manager;

import java.sql.Timestamp;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String string_time_in = "2019-05-07 20:30:00";
		String string_time_out = "2019-05-10 20:30:00";
		String string_free_start = "23:00:00";
		String string_free_end = "06:00:00";

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
			double span_free_hour = (free_end.getTime() - free_start.getTime()) / (60.0* 60.0 * 1000.0) + 24.0;

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
			
            //超过15分钟按一小时收费，15分钟内免费
			long pay_hour =(long) span_hour;
			double over_hour=span_hour-pay_hour;
			if (over_hour>0.25)
				pay_hour++;
		
					
			System.out.println("span_free_hour（免费时长长度）:" + span_free_hour + "小时。");
			System.out.println("span_hour（精确收费时间）:" + span_hour + "小时。");
			System.out.println("over_hour（小数部分时间）:" + over_hour +"，超过了:" + over_hour*60.0 + "分钟。");
			System.out.println("pay_hour（最终收费小时数）:" + pay_hour + "小时。");


		} catch (Exception exception) {
			exception.printStackTrace();
		}
	}
	}