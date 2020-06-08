import socket
import pyautogui
import time
from pynput.keyboard import Key, Controller
import pyxinput
import subprocess
import threading
from qrcode import QRCode
import os
import platform
pyautogui.PAUSE = 0.01
keyboard = Controller()
xSupport = True if platform.system() == 'Windows' else False
xcontroller = None
if(xSupport):
	xcontroller = pyxinput.vController()
button = '$'
duty_ratio = 0
sub = '$'
serverIP = ''

class myThread (threading.Thread):
	def __init__(self, threadID, name, counter):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
		self.counter = counter

	def run(self):
		global sub
		while(True):
			if button == '$'or duty_ratio==0 :
				time.sleep(0.1)
				continue
			sub = button
			keyboard.press(sub)
			time.sleep(0.1*duty_ratio)
			keyboard.release(sub)
			time.sleep((0.1)*(1-duty_ratio))


thread1 = myThread(1, "Thread-1", 1)
def main():
	s = socket.socket()      
	thread1.start()
	print ("Socket successfully created.")

	while True:
		try:
			print("Enter port (leave blank for 4444): ",end="")
			inp = input()
			
			if inp == '': 
				port = 4444
			else:
				port = int(inp)
			
			s.bind(('', port))
			print ("Socket binded to %s" %(port))
			break
		except OSError:
			print("Port " + str(port) + " is already in use. Please use the following command:")
			print("lsof -n -i4TCP:" + str(port) +" | grep LISTEN")
			os._exit(os.EX_OK)
		except:
			print ("Unexpected error while connecting to port")
     
	s.listen()
	try:
		serverIP = socket.gethostbyname(socket.gethostname())+":"+str(port)
	except socket.gaierror: 
		output = subprocess.check_output("ipconfig getifaddr en0", shell=True).decode()[:-1]
		serverIP = output+":"+str(port)
	
	print("Connect at IP = "+serverIP)
	print('Or scan this:')
	qr = QRCode()
	qr.add_data(serverIP)
	qr.print_ascii(invert=True)
	qr.print_ascii()

	while True: 
		print ("Socket is listening...")

		c, addr = s.accept()
		
		print ('Got connection from', addr)

		while True:
			message = c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first

			message = message.split("%") #use & to split tokens, and % to split messages.
			
			for msg in message:
				if msg != '':
					msg = msg.split("&")
					print("DEBUG: ", msg)
					if(msg[0] == 'button'):
						handleButton(msg[1], msg[2])
					elif(msg[0] == 'tilt'):
						if(len(msg) == 2):
							if(msg[1] == '0'):
								global button
								button = '$'
						if(len(msg) < 3):
							continue
						elif(msg[2] == ''):
							continue
						elif msg[1] == '+':
							tilt(True, float(msg[2]))
						elif msg[1] == '-':
							tilt(False, float(msg[2]))
					elif(msg[0] == 'cont'):
						handleController(msg[1:])

			c.send(bytes('Thank you for connecting', "utf-8"))
			
		c.close()
		

def handleButton(type, msg):
	if(type == 'down'):
		# pyautogui.keyDown(msg)
		if(msg=='space'):
			keyboard.press(Key.space)
		elif(msg=='shift'):
			keyboard.press(Key.shift)
		else:
			keyboard.press(msg)
	else:
		# pyautogui.keyUp(msg)
		if(msg=='space'):
			keyboard.release(Key.space)
		elif(msg=='shift'):
			keyboard.release(Key.shift)
		else:
			keyboard.release(msg)

def tilt(message,value):
	global button
	global duty_ratio
	if message:
		button = 'a'
		duty_ratio = value
	else:
		button = 'd'
		duty_ratio = value

def handleController(msg):
	if(not xSupport):
		return
	if('down' in msg[0] or 'up' in msg[0]):
		if('Btn' in msg[1]):
			typeInt = 1 if msg[0] == 'down' else 0
			xcontroller.set_value(msg[1], typeInt)
		elif('Trigger' in msg[1]):
			typeInt = 127 if msg[0] == 'down' else 0
			xcontroller.set_value(msg[1], typeInt)
	elif('Axis' in msg[0]):
		xcontroller.set_value(msg[0], float(msg[1]))
	elif('Dpad' in msg[0]):
		xcontroller.set_value(msg[0], int(msg[1]))
	else:
		print('Not yet handled in driver')

if __name__=="__main__":
	main()
