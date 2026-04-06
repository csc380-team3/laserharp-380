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
