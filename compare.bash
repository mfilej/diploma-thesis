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

function count_verbs {
  local text_file="$1"

  (
    cd cckres-plain
    ./examples/count_verbs.rb morphosyntax_dict.txt "$text_file" \
      | sort -n \
      | uniq -c \
      | awk '{print $2 " " $1}' \
      > "$text_file.verb.dist"
  )
}

./text/count_words_per_line "$corpus_file" \
  | sort \
  > "$counts_file"

# prepare umdhmm
num_words=$(
  cd "$umdhmm_dir"
  cat "$input_file" | mix artisan.key_seq "$work_dir/umdhmm"
)


count_verbs "$input_file"

for num_states in 1 3 5 8 12; do
  generated=$(test_hmmlearn num_states="$num_states")
  count_verbs "$generated"

  generated=$(test_freq num_states="$num_states")
  count_verbs "$generated"

  generated=$(test_umdhmm num_states="$num_states")
  count_verbs "$generated"
done
