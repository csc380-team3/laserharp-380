from bottle import route, run, template
import csv

def read_config_csv(file_path):
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

def write_config_csv(file_path,data):
    try:
        with open(file_path, mode='w') as file:
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
    data = read_config_csv('scenes.csv')
    data[int(scene)][int(sensor)] = note
    write_config_csv('scenes.csv', data)
    return template('<p>Scene {{scene}}</p><p>Sensor {{sensor}}</p><p>Note {{note}}</p>', scene=scene, sensor=sensor, note=note)

@route('/network/<ip>/<port>')
def config_network(ip, port):
    pass

#these are web pages
@route('/')
def scenes():
    data = read_config_csv('scenes.csv')
    return template('index.tpl', data=data)

@route('/scene_edit/<scene>')
def scene_editor(scene):
    data = read_config_csv('scenes.csv')
    scene_data = data[int(scene)]
    return template('scene_editor.tpl', scene_data=scene_data)

run(host='localhost', port=8087)
