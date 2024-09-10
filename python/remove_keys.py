import json
import sys

def remove_keys(data, keys_to_remove):
    if isinstance(data, dict):
        return {k: remove_keys(v, keys_to_remove) for k, v in data.items() if k not in keys_to_remove}
    elif isinstance(data, list):
        return [remove_keys(item, keys_to_remove) for item in data]
    else:
        return data

def process_json(input_file, output_file, keys_to_remove):
    with open(input_file, 'r') as infile:
        data = json.load(infile)

    filtered_data = remove_keys(data, keys_to_remove)

    with open(output_file, 'w') as outfile:
        json.dump(filtered_data, outfile, indent=4)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py input_file.json output_file.json key1,key2,key3")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    keys_to_remove = sys.argv[3].split(',')

    process_json(input_file, output_file, keys_to_remove)
