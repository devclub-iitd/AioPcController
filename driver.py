import socket
import pyautogui
import time

pyautogui.PAUSE = 0.01

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
	print ("socket is listening...")           
	while True: 
		c, addr = s.accept()
		print ('Got connection from', addr)
		while True:
			message = c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first
			message = message.split("%") #use & to split tokens, and % to split messages.
			for msg in message:
				msg = msg.split("&")
				#print("DEBUG: ",msg)
				if(msg[0]=='wasd'):
					wasd(msg[1])
				elif(msg[0]=='tilt'):
					if(len(msg)==1):
						continue
					elif msg[1]=='+':
						tilt(True)
					else:
						tilt(False)
			c.send(bytes('Thank you for connecting', "utf-8"))
		c.close()

def wasd(message):
	print(message)
	pyautogui.keyDown(message)
	time.sleep(0.5)
	pyautogui.keyUp(message)
	
def tilt(message):
	if message:
		print('a')
		pyautogui.keyDown('a')
		time.sleep(0.01)
		pyautogui.keyUp('a')
	else:
		print('d')
		pyautogui.keyDown('d')
		time.sleep(0.01)
		pyautogui.keyUp('d')
		
if __name__=="__main__":
	main()
