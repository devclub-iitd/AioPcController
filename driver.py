import socket
import pyautogui
import time
import subprocess
import threading
from qrcode import QRCode
import os
import platform
from pynput.mouse import Controller as MouseController
from PIL import ImageTk

import tkinter as tk

root= tk.Tk()

canvas1 = tk.Canvas(root, width = 600, height = 600)
canvas1.pack() 


pyautogui.PAUSE = 0.01
keyboard = None
mouse = MouseController()
xSupport = True if platform.system() == 'Windows' else False
xcontroller = None
if(xSupport):
	import pyxinput
	import dinput
	from pynput.keyboard import Key, Controller as KeyboardController
	keyboard = KeyboardController()
else:
	from pymouse import PyMouse
	from pykeyboard import PyKeyboard
	keyboard = PyKeyboard()
button = '$'
duty_ratio = 0
sub = '$'
serverIP = ''

def get_ip_address():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    return s.getsockname()[0]

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

	canvas1.delete("all")

	while True:
		try:
			canvas1.delete("all")

			label1 = tk.Label(root, text= 'Socket successfully created.', fg='blue', font=('helvetica', 12, 'bold'))
			canvas1.create_window(300, 50, window=label1)
			
		
			inp = entry1.get()
			
			if inp == '': 
				port = 4444
			else:
				port = int(inp)
			
			s.bind(('', port))

			label2 = tk.Label(root, text= 'Socket binded to '+str(port), fg='blue', font=('helvetica', 12, 'bold'))
			canvas1.create_window(300, 120, window=label2)

			# print ("Socket binded to %s" %(port))
			break
		except OSError:
			print("Port " + str(port) + " is already in use. Please use the following command:")
			print("lsof -n -i4TCP:" + str(port) +" | grep LISTEN")
			os._exit(os.EX_OK)
		except:
			print ("Unexpected error while connecting to port")
     
	s.listen()
	try:
		# serverIP = socket.gethostbyname(socket.gethostname())+":"+str(port)
		serverIP = get_ip_address()+":"+str(port)
	except socket.gaierror: 
		output = subprocess.check_output("ipconfig getifaddr en0", shell=True).decode()[:-1]
		serverIP = output+":"+str(port)
	
	qr = QRCode()
	qr.add_data(serverIP)
	
	while True: 

		label3 = tk.Label(root, text= 'Connect to ip '+str(serverIP)+" Or Scan this", fg='red', font=('helvetica', 12, 'bold'))
		canvas1.create_window(300, 180, window=label3)

		# print("Connect at IP = "+serverIP)
		# print('Or scan this:')
		# qr.make()
		img = qr.make_image()
		img = ImageTk.PhotoImage(img)

		panel = tk.Label(root, image = img)
		canvas1.create_window(300, 400, window=panel)

		# qr.print_ascii(invert=True)
		# qr.print_ascii()
		root.update()
		# print ("Socket is listening...")

		c, addr = s.accept()
		
		print ('Got connection from', addr)

		message = ''

		while True:
			try:

				buffer = c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first


				message += buffer
				if buffer[-1] != '%':
					continue

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
						elif(msg[0] == 'track'):
							handleTrackpad(msg[1:])
						elif(msg[0] == 'status'):
							c.send(bytes('pass'+msg[1],"utf-8"))
						elif(msg[0] == 'disconnect'):
							raise ConnectionResetError
				message = ''
			except ConnectionResetError:
				print("Disconnected from client")
				c.close()
				print("Socket closed")
				ans = input("Do you want to connect again? (y/n): ")
				if(ans == 'n'):
					os._exit(0)
				break
			#c.send(bytes('Thank you for connecting', "utf-8"))
		

def handleButton(type, msg):
	if(type == 'down'):
		# pyautogui.keyDown(msg)
		# if(msg=='space'):
		# 	keyboard.press(Key.space)
		# elif(msg=='shift'):
		# 	keyboard.press(Key.shift)
		# else:
		# 	keyboard.press(msg)
		if xSupport:
			dinput.handleInputs(1,msg)
		else:
			keyboard.press_key(msg)
	else:
		# pyautogui.keyUp(msg)
		# if(msg=='space'):
		# 	keyboard.release(Key.space)
		# elif(msg=='shift'):
		# 	keyboard.release(Key.shift)
		# else:
		# 	keyboard.release(msg)
		if xSupport:
			dinput.handleInputs(0,msg)
		else:
			keyboard.release_key(msg)

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
	global xcontroller
	try:
		if('Toggle' in msg[0]):
			if(msg[1] == '1'):
				xcontroller = pyxinput.vController()
			elif(xcontroller!=None):
				xcontroller.UnPlug(force=True)
				del xcontroller
				xcontroller = None
		elif(not xSupport or xcontroller == None):
			return
		elif('down' in msg[0] or 'up' in msg[0]):
			if('Btn' in msg[1]):
				typeInt = 1 if msg[0] == 'down' else 0
				xcontroller.set_value(msg[1], typeInt)
			elif('Trigger' in msg[1]):
				typeInt = 255 if msg[0] == 'down' else 0
				xcontroller.set_value(msg[1], typeInt)
		elif('Axis' in msg[0]):
			xcontroller.set_value(msg[0], float(msg[1]))
		elif('Dpad' in msg[0]):
			xcontroller.set_value(msg[0], int(msg[1]))
		else:
			print(msg)
			print('^Not yet handled in driver^')
	except Exception as e:
		print(e)
		print("Error: Incomplete message received")

def handleTrackpad(msg):
	try:
		if(len(msg) == 3):
			if(msg[0] == 'move'):
				mouse.move(float(msg[1])*5, float(msg[2])*5)
			elif(msg[0] == 'button'):
				if(msg[1] == 'down'):
					if(msg[2] == 'left'):
						mouse.press(Button.left)
					elif(msg[2] == 'right'):
						mouse.press(Button.right)
				else:
					if(msg[2] == 'left'):
						mouse.release(Button.left)
					elif(msg[2] == 'right'):
						mouse.release(Button.right)
			elif(msg[0] == 'click'):
				clicks = int(msg[1])
				if(msg[2] == 'left'):
					mouse.click(Button.left, clicks)
				if(msg[2] == 'right'):
					mouse.click(Button.right, clicks)
	except:
		print('Invalid message')

if __name__=="__main__":
	
	label1 = tk.Label(root, text= 'Enter the port (leave blank for 4444): ', fg='green', font=('helvetica', 12, 'bold'))
	canvas1.create_window(300, 80, window=label1)

	button1 = tk.Button(text='Submit',command=main, bg='brown',fg='white')
	canvas1.create_window(300, 380, window=button1)

	entry1 = tk.Entry (root) 
	canvas1.create_window(300, 180, window=entry1)

	root.mainloop()
	# main()
