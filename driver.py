import socket
# import pyautogui
import time
from pynput.keyboard import Key, Controller
import subprocess
import threading
from qrcode import QRCode
# pyautogui.PAUSE = 0.01
keyboard = Controller()
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
				time.sleep(0.01)
				continue
			sub = button
			keyboard.press(sub)
			time.sleep(0.01*duty_ratio)
			keyboard.release(sub)
			time.sleep((0.01)*(1-duty_ratio))


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
			exit()
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
	qr.print_ascii()

	while True: 
		print ("Socket is listening...")

		try:
			c, addr = s.accept()
			
			print ('Got connection from', addr)

			while True:
				message = c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first

				message = message.split("%") #use & to split tokens, and % to split messages.
				
				for msg in message:
					if msg != '':
						msg = msg.split("&")
						print("DEBUG: ", msg)
						if(msg[0] == 'wasd'):
							wasd(msg[1], msg[2])
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
				c.send(bytes('Thank you for connecting', "utf-8"))
				
			c.close()
		except:
			print('Host Disconnected! Please Connect Again...\n\n')

def wasd(type, msg):
	if(type == 'down'):
		# pyautogui.keyDown(msg)
		keyboard.press(msg)
	else:
		# pyautogui.keyUp(msg)
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

if __name__=="__main__":
	main()
