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
				print("DEBUG: ",msg)
				if(msg[0] == 'wasd'):
					wasd(msg[1], msg[2])
				
			c.send(bytes('Thank you for connecting', "utf-8"))
			
		c.close()

def wasd(type, msg):
	if(type == 'down'):
		pyautogui.keyDown(msg)
	else:
		pyautogui.keyUp(msg)
	

if __name__=="__main__":
	main()