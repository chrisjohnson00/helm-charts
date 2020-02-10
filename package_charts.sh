#!/bin/bash
set -x


## declare an array variable
declare -a charts=("awx-proxy-chart" "cadvisor-chart" "flask-chart")

## now loop through the above array
for i in "${charts[@]}"
do
  echo "Start of $i"
  git clone https://$GITHUB_TOKEN@github.com/chrisjohnson00/$i.git
  cd $i
  docker run --rm -v ${PWD}:/chart -w /chart alpine/helm:3.0.2 lint .
  docker run --rm -v ${PWD}:/chart -w /chart alpine/helm:3.0.2 package .
  mv *.tgz ../.
  cd ..
  sudo rm -r $i
  echo "End of $i"
done
