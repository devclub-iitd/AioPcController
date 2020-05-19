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
			message=c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first

			message=message.split("&") #i use & to differtiate commands

			print("DEBUG: ",message)
			if(message[0] == 'wasd'):
				wasd(message[1])
			
			c.send(bytes('Thank you for connecting', "utf-8"))
			
		c.close()

def wasd(message):
	pyautogui.keyDown(message)
	time.sleep(0.5)
	pyautogui.keyUp(message)
	

if __name__=="__main__":
	main()