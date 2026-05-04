from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
from pythonosc.udp_client import SimpleUDPClient
import csv
import time
#import termios
import sys

#from pynput import keyboard
from pynput.keyboard import Key, Listener
import threading

# Scenes 2d list
scenes = [[]]
currentScene = 0

# OSC sender
ip = "127.0.0.1"
#ip = "192.168.1.163"
#ip = "192.168.1.231"
port = 4567
client = SimpleUDPClient(ip, port)  # Create client

# Function to handle incoming OSC messages
def osc_message_handler(address, *args):
    print(f"Received OSC message: Address={address}, Args={args}")
    midi_port = int(args[0])
    status_byte = int(args[1])
    program_number = int(args[2])
    
    # Decode the message
    midi_channel = (status_byte & 0x0F) + 1  # Extract MIDI channel (1-16)
    message_type = (status_byte & 0xF0) >> 4  # Extract message type
    if message_type == 0xC:  # 0xC = Program Change
        print(f"Received Program Change on MIDI Channel {midi_channel}: Program {program_number}")
        if program_number >= 0 and program_number < len(scenes):
            # Update current current scene
            global currentScene
            currentScene = program_number
        else:
           print(f"Ignoring invalid scene: {program_number}")
    else:
        print(f"Unhandled MIDI message: {status_byte}")
    

# Set up the OSC server
def start_osc_server(ip, port):
    dispatcher = Dispatcher()
    dispatcher.map("/midi", osc_message_handler)
    server = ThreadingOSCUDPServer((ip, port), dispatcher)
    print(f"OSC server running on {ip}:{port}")
    server.serve_forever()

# Function to handle keyboard press events
permittedKeys = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
def on_key_press(key):
    try:
        # Check if the key is permitted
        if key.char in permittedKeys:
            # Get the sensor value, i.e. index
            sensor = permittedKeys.index(key.char)
            print('Sensor Index: {0}'.format(sensor))
            # Send OSC message
            msgVals = [0x90, 0, 100]
            # Update note number
            msgVals[1] = scenes[currentScene][sensor]
            client.send_message("/midi", msgVals)   # noteOn/Chanel, note number, velocity
            print('{0} pressed: '.format(key), msgVals, time.time())
        else:
            print(f"Ignored key pressed: {key.char}")
    except ValueError:
        print(f"{key} is not in the list")        
    except AttributeError:
        # Check for Esc
        if key == Key.esc:
            # Flush stdin buffer
            #termios.tcflush(sys.stdin, termios.TCIOFLUSH)
            # Stop listener
            return False


# Function to handle keyboard release events
def on_key_release(key):
    print(f"Key released: {key}")
    if key == keyboard.Key.esc:  # Stop listener on Esc key press
        return False

# Funtion to read in the MIDI note values from a CSV file as integers
def read_integer_csv(file_path):
    data = []
    try:
        with open(file_path, mode='r') as file:
            reader = csv.reader(file)
            for row in reader:
                # Convert each value in the row to an integer
                try:
                    int_row = [int(value) for value in row]
                    data.append(int_row)
                except ValueError:
                    print(f"Non-integer value found in row: {row}")
                    continue
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except Exception as e:
        print(f"An error occurred: {e}")
    return data

# Start the keyboard listener
def start_keyboard_listener():
    with Listener(on_press=on_key_press) as listener:
        listener.join()

# Main function to launch both OSC server and keyboard listener
def main():
    global scenes
    scenes = read_integer_csv("./scenes.csv")
    # Show scenes
    for row in scenes:
        print(row)
    print(f'Current scene: {currentScene}')

    # Set up threading for OSC server and keyboard listener
    osc_thread = threading.Thread(target=start_osc_server, args=("127.0.0.1", 8000), daemon=True)
    osc_thread.start()
    
    # Start keyboard listener in the main thread
    start_keyboard_listener()

if __name__ == "__main__":
    main()

