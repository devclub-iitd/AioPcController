import socket

def main():
	s = socket.socket()      
	print ("socket successfully created")

	while True:
		try:
			print("enter port: ",end="")
			port = int(input())

			s.bind(('', port))
			print ("socket binded to %s" %(port))
			break
		except:
			print ("error connecting to port")
     
	s.listen(5)      
	print ("socket is listening")           

	while True: 
		c, addr = s.accept()
		print ('Got connection from', addr)

		message=c.recv(256).decode("utf-8"); #message comes in byte array so change it to string first

		message=message.split("\0") #i use \0 to differtiate commands

		print("DEBUG: ",message)

		c.send(bytes('Thank you for connecting', "utf-8"))
		 
		c.close()

if __name__=="__main__":
	main()