#/bin/bash

[[ -d surfaces ]] || mkdir -p surfaces

for i in {1..30}; do
    bounds=$((1 + $RANDOM % 20)),$((1 + $RANDOM % 20)),15,15;
    ./noisetool brick-surface-spec.txt bounds=$bounds destfile=surfaces/$i.txt;
done


