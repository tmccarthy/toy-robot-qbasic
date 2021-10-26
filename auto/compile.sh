#! /bin/bash -e

set -e

. "$(dirname "$0")"/config.sh

mkdir -p "$BUILD_OUTPUT_DIRECTORY"

for src_file in "${SRC_DIRECTORY}"/*.BAS ; do
  [ -e "$src_file" ] || continue

  echo "$src_file"

  src_file_abs=$(realpath "$src_file")
  output_abs="$(realpath "$BUILD_OUTPUT_DIRECTORY")"/"$(basename "$src_file" .BAS)"

  pushd "$QB64_PATH"
  ./qb64 -x "$src_file_abs" -o "$output_abs"
  popd
done
