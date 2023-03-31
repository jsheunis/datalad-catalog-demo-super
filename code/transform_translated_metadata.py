from pathlib import Path
import json
import sys

metadata_fn = Path(sys.argv[1])
out_fn = Path(sys.argv[2])
out_list = []
with open(metadata_fn) as file:
    i=0
    for line in file:
        meta_dict = json.loads(line.rstrip())
        if not isinstance(meta_dict, dict):
            print(f"Skipping invalid JSON on line {i+1}")
            continue
        if meta_dict['status'] != 'ok':
            print(f"Skipping failure record on line {i+1}")
            continue
        metadata_record = meta_dict['translated_metadata']
        out_list.append(metadata_record)

# Write list of dictionaries to file
# out_dir = metadata_fn.parent
# out_file = out_dir / out_fn
with open(out_fn, 'a') as f:
    for d in out_list:
        f.write(json.dumps(d))
        f.write('\n')