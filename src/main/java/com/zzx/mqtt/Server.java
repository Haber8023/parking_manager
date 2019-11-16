package com.zzx.mqtt;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.eclipse.paho.client.mqttv3.MqttTopic;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

public class Server {

	public static final String HOST = "tcp://127.0.0.1:61613";
	public static final String TOPIC = "system";
	public static final String TOPIC125 = "space";
	public static final String clientid = "server";
	public MqttClient client;
	public MqttTopic topic;
	public MqttTopic topic125;
	public String userName = "admin";
	public String passWord = "password";

	public MqttMessage message;

	public Server() throws MqttException {
		// MemoryPersistence设置clientid的保存形式，默认为以内存保存
		client = new MqttClient(HOST, clientid, new MemoryPersistence());
		connect();
	}

	private void connect() {
		MqttConnectOptions options = new MqttConnectOptions();
		options.setCleanSession(false);
		options.setUserName(userName);
		options.setPassword(passWord.toCharArray());
		// 设置超时时间
		options.setConnectionTimeout(10);
		// 设置会话心跳时间
		options.setKeepAliveInterval(20);
		try {
			client.setCallback(new PushCallback());
			client.connect(options);
			topic = client.getTopic(TOPIC);
			topic125 = client.getTopic(TOPIC125);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void publish(MqttTopic topic, MqttMessage message) throws MqttPersistenceException, MqttException {
		MqttDeliveryToken token = topic.publish(message);
		token.waitForCompletion();
		System.out.println("message is published completely! " + token.isComplete());
	}

	public static void main(String[] args) throws MqttException {
		for (int i = 0; i < 10; i++) {
			Server server = new Server();
			server.message = new MqttMessage();
			server.message.setQos(2);
			server.message.setRetained(true);
			server.message.setPayload(("{P1=1}" + i).getBytes());
			server.publish(server.topic, server.message);
			System.out.println(server.message.isRetained() + "------ratained状态");
		}

	}
}