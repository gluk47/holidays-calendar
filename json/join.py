#!/usr/bin/env python3

import json
import os
from collections import defaultdict

OUTPUT = 'calendar.json'
data_dir = os.path.dirname(__file__)
aggregated = defaultdict(set)

for fname in os.listdir(data_dir):
    if fname == OUTPUT or not fname.endswith('.json'):
        continue

    with open(os.path.join(data_dir, fname)) as f:
        j = json.load(f)

    for k, v in j.items():
        aggregated[k] |= set(v)

for k, v in aggregated.items():
    aggregated[k] = sorted(list(v))

with open(OUTPUT, 'w') as f:
    json.dump(aggregated, f, indent=4)
