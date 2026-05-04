import csv
import os
from bottle import route, run, template, debug, TEMPLATE_PATH


debug(True)

script_dir = os.path.dirname(os.path.abspath(__file__))

TEMPLATE_PATH.insert(0, script_dir)

CSV_PATH = os.path.join(script_dir, 'scenes.csv')

NUM_SENSORS = 12

def read_config_csv(file_path):
    data = []
    try:
        with open(file_path, mode='r', newline='') as file:
            reader = csv.reader(file)
            for row in reader:
                if not row:
                    continue
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

def write_config_csv(file_path,data):
    try:
        with open(file_path, mode='w', newline='') as file:
            writer = csv.writer(file)
            for row in data:
                writer.writerow(row)

    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except Exception as e:
        print(f"An error occurred: {e}")

#these are api routes (that return json(or something similar idfk))

@route('/bind/<scene>/<sensor>/<note>')
def bind_note(scene, sensor, note):
    data = read_config_csv(CSV_PATH)
    data[int(scene)][int(sensor)] = int(note)
    write_config_csv(CSV_PATH, data)
    return template('<p>Scene {{scene}}</p><p>Sensor {{sensor}}</p><p>Note {{note}}</p>', scene=scene, sensor=sensor, note=note)

@route('/network/<ip>/<port>')
def config_network(ip, port):
    pass

#these are web pages
@route('/')
def scenes():
    data = read_config_csv(CSV_PATH)
    return template('index.tpl', data=data)

@route('/scene_edit/<scene>')
def scene_editor(scene):
    data = read_config_csv(CSV_PATH)
    scene_data = data[int(scene)]
    return template('scene_editor.tpl', scene_data=scene_data)

@route('/remove_scene/<index>')
def remove_scene(index):
    data =read_config_csv(CSV_PATH)
    i=int(index)
    if 0 <= i < len(data):
        data.pop(i)
        write_config_csv(CSV_PATH, data)
        return f"Scene {index} removed successfully."
    else:
        return f"Scene {index} does not exist."
    
@route('/add_scene')
def add_scene():
    data = read_config_csv(CSV_PATH)
    new_scene = [0] * NUM_SENSORS
    data.append(new_scene)
    write_config_csv(CSV_PATH, data)

    return f"Scene {len(data)-1} added successfully."



run(host='localhost', port=8087)
