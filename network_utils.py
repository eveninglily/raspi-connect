import subprocess
import socket
import re

interface = "wlp5s0"

# Returns a list of all availible networks
def get_networks():
    # Get all the local networks through a bash command
    p1 = subprocess.Popen(["sudo", "iwlist", interface,"scan"], stdout=subprocess.PIPE)
    p2 = subprocess.check_output(["grep", "ESSID"], stdin=p1.stdout)
    raw_names = p2.decode("utf-8") .split('\n')

    # Strip out everything but the network name
    for i in range(0, len(raw_names)):
        val = raw_names[i]
        raw_names[i] = re.findall(r'\"(.+)\"', val)

    # Remove dupes
    networks = []
    for id in raw_names:
        if len(id) > 0:
            if id[0] not in networks:
                networks.append(id[0])
    return networks

def check_connection():
    # Try a few times before calling it
    for timeout in [1, 5, 10, 15]:
        try:
            # Attempt to connect to google
            host = socket.gethostbyname("www.google.com")
            sock = socket.create_connection((host, 80), timeout)
            sock.close()

            # If everything went fine, we're connected
            return True
        except:
            # Do nothing if it fails, so it can try with the next timeout
            pass
    # If all 4 timeouts fail, then we are not connected to the internet
    return False