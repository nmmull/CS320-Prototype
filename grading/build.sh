#!/usr/bin/env bash

# NOT A GREAT SCRIPT

if [ $# -ne 1 ]; then
  echo "USAGE: bash build.sh PATH/TO/ASSIGNMENT/FROM/PROJECT/ROOT"
  exit 1
fi

BASE=".."
ASSIGN_DIR="$1"

if [ ! -d "$BASE/$ASSIGN_DIR" ]; then
  echo "ERROR: $ASSIGN_DIR does not exist"
  echo "USAGE: bash build.sh PATH/TO/ASSIGNMENT/FROM/PROJECT/ROOT"
  exit 1
fi

GRADER_DIR="$(basename $ASSIGN_DIR)-grader"

rm -rf $GRADER_DIR
mkdir -p $GRADER_DIR/$ASSIGN_DIR
cp -r $BASE/$ASSIGN_DIR/* $GRADER_DIR/$ASSIGN_DIR
cp -r $BASE/stdlib320 $GRADER_DIR
cp scripts/setup.sh scripts/run.sh $GRADER_DIR
cd $GRADER_DIR
touch run_autograder
echo "#!/usr/bin/env bash" >> run_autograder
echo "" >> run_autograder
echo "bash source/run.sh $1" >> run_autograder
zip -r autograder.zip .
