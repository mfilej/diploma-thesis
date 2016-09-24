#!/usr/bin/env bash

set -eu

if [[ $# -ne 2 ]]; then
  echo -e "Wrong number of arguments.\nUsage: $0 <WORKDIR> <CORPUS>" >&2
  exit 64
fi

function abs_path {
  echo $(cd "$(dirname "$1")"; pwd)/$(basename "$1")
}

base_dir=$(pwd)
work_dir=$(abs_path $1)
hmmlearn_dir="nlg-with-hmmlearn"
umdhmm_dir="nlg-with-umdhmm"
corpus_file=$(abs_path $2)
input_file=$work_dir/_input.txt
counts_file=$work_dir/counts.txt
stats_file=$work_dir/stats.txt
train_lines=5000
gen_lines=5000

if [[ -d "$work_dir" ]]; then
  echo "Target directory ($work_dir) already exists, aborting." >&2
  exit 73
fi

mkdir "$work_dir"

cat "$corpus_file" | "$base_dir/text/randomize" | head -n $train_lines > "$input_file"

function test_hmmlearn {
  local num_states
  local "${@}"

  local out_file="$work_dir/hmmlearn.builtin.$num_states.gen"

  (
    cd "$hmmlearn_dir"

    ./train.py \
      "--num-states=$num_states" \
      "-o=$work_dir/hmmlearn" \
      "$input_file"

    ./gen.py \
      "-l=$gen_lines" \
      "-d=$counts_file" \
      "$work_dir/hmmlearn.builtin.$num_states" \
      > "$out_file"

  )

  echo "$out_file"
} 

function test_freq {
  local num_states
  local "${@}"

  local tmp_file="$work_dir/hmmlearn.freq.$num_states.gen"
  local out_file="${tmp_file/hmmlearn.freq/freq}"

  (
    cd "$hmmlearn_dir"

    ./train.py \
      "--num-states=$num_states" \
      "--init=freq" \
      "-o=$work_dir/hmmlearn" \
      "$input_file"

    ./freq.py \
      "-l=$gen_lines" \
      "-d=$counts_file" \
      "$work_dir/hmmlearn.freq.$num_states.freqdist" \
      "$work_dir/hmmlearn.freq.$num_states.le" \
      > "$tmp_file"
  )

  mv "$tmp_file" "$out_file"

  echo "$out_file"
} 

function test_umdhmm {
  local num_states
  local "${@}"

  local base_file="$work_dir/umdhmm.$num_states"
  local hmm_file="$base_file.hmm"
  local out_file="$base_file.gen"

  "$umdhmm_dir/tools/umdhmm-v1.02/esthmm" \
    -v "-N $num_states" "-M $num_words" "$work_dir/umdhmm.seq" \
    > "$hmm_file"

  (
    cd umdhmm-to-hmmlearn
    ./umdhmm_to_hmmlearn.py "$hmm_file" "$work_dir/umdhmm.key" "$base_file"
  )

  (
    cd "$hmmlearn_dir"
    ./gen.py \
      "-l=$gen_lines" \
      "-d=$counts_file" \
      "$base_file" \
      > "$out_file"
  )

  echo "$out_file"
}

function test_rnd {
  local out_file="$work_dir/random.0.gen"

  (
    cd "$hmmlearn_dir"
    ./rnd.py \
      "-l=$gen_lines" \
      "-d=$counts_file" \
      "$work_dir/hmmlearn.builtin.1.le" \
    > "$out_file"
  )

  echo "$out_file"
}

function count_verbs {
  local text_file="$1"
  local out_file="$text_file.verb.dist"

  (
    cd cckres-plain
    ./examples/count_verbs.rb morphosyntax_dict.txt "$text_file" \
      | sort -n \
      | uniq -c \
      | awk '{print $2 " " $1}' \
      > "$out_file"
  )

  echo "$out_file"
}

function compute_stats {
  local expected_freq="$1"
  local observed_freq="$2"

  local line=$(./chi2.py "$expected_freq" "$observed_freq")
  
  echo "$observed_freq: $line" >> "$stats_file"
}

# count verb frequencies in corpus
./text/count_words_per_line "$corpus_file" \
  | sort \
  > "$counts_file"

# prepare umdhmm
num_words=$(
  cd "$umdhmm_dir"
  cat "$input_file" | mix artisan.key_seq "$work_dir/umdhmm"
)

# init stats file
echo "" > "$stats_file"

# begin

input_freq_file=$(count_verbs "$input_file")

for num_states in 1 3 5 8 12; do
  generated=$(test_hmmlearn num_states="$num_states")
  freq_file=$(count_verbs "$generated")
  compute_stats "$input_freq_file" "$freq_file"

  generated=$(test_freq num_states="$num_states")
  freq_file=$(count_verbs "$generated")
  compute_stats "$input_freq_file" "$freq_file"

  generated=$(test_umdhmm num_states="$num_states")
  freq_file=$(count_verbs "$generated")
  compute_stats "$input_freq_file" "$freq_file"
done

generated=$(test_rnd)
rand_freq_file=$(count_verbs "$generated")
compute_stats "$input_freq_file" "$rand_freq_file"

for model in umdhmm freq hmmlearn.builtin; do
  echo -n "$model"
  bash -c "./chi2cont.py example/$model.*.gen.verb.dist"
done | tr . , > "$work_dir/compare_num_states.csv"
