import socket
# import pyautogui
import time
from pynput.keyboard import Key, Controller
from qrcode import QRCode

# pyautogui.PAUSE = 0.01
keyboard = Controller()

serverIP = ''

def main():
	s = socket.socket()      
	print ("Socket successfully created.")

	while True:
		try:
			print("enter port (leave blank for 4444): ",end="")
			inp = input()
			
			if inp == '': 
				port = 4444
			else:
				port = int(inp)
			
			s.bind(('', port))
			print ("socket binded to %s" %(port))
			break
		except OSError:
			print("Port " + str(port) + " is already in use. Please use the following command:")
			print("lsof -n -i4TCP:4444 | grep LISTEN")
			exit()
		except:
			print ("unexpected error while connecting to port")
     
	s.listen()
	serverIP = socket.gethostbyname(socket.gethostname())+":"+str(port)
	print("Connect at IP = "+serverIP)
	print('Or scan this:')
	qr = QRCode()
	qr.add_data(serverIP)
	qr.print_ascii()
	print ("socket is listening...")

	while True: 
		
		c, addr = s.accept()
		
		print ('Got connection from', addr)

		while True:
			message = c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first

			message = message.split("%") #use & to split tokens, and % to split messages.
			
			for msg in message:
				if msg != "":
					msg = msg.split("&")
					print("DEBUG: ",msg)
					if(msg[0] == 'wasd'):
						wasd(msg[1], msg[2])
					
			c.send(bytes('Thank you for connecting', "utf-8"))
			
		c.close()

def wasd(type, msg):
	if(type == 'down'):
		# pyautogui.keyDown(msg)
		keyboard.press(msg)
	else:
		# pyautogui.keyUp(msg)
		keyboard.release(msg)
	

if __name__=="__main__":
	main()