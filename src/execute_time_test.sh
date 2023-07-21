#!/bin/bash

GRID_SIZES=(32 512 4096)
IMPLS=("seq" "pth" "omp")
NUM_THREADS=(2 8 32)
RESULT_FILE="results.csv"

# Runs time_test with given parameters and append the result to a CSV file
run_command() {
  local grid_size="$1"
  local impl="$2"
  local num_threads="$3"
  local iteration="$4"

  local result=$(./time_test --grid_size "$grid_size" --impl "$impl" --num_threads "$num_threads")
  echo "${grid_size},${impl},${num_threads},${iteration},${result}" >> "$RESULT_FILE"
}

echo "grid_size,impl,num_threads,iteration,result" > "$RESULT_FILE"

for grid_size in "${GRID_SIZES[@]}"; do
  for impl in "${IMPLS[@]}"; do
    for num_threads in "${NUM_THREADS[@]}"; do
      for ((iteration = 1; iteration <= 30; iteration++)); do
        run_command "$grid_size" "$impl" "$num_threads" "$iteration"
      done
    done
  done
done
