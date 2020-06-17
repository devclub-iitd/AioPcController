import socket
print(socket.gethostbyname_ex(socket.gethostname())[-1])
 