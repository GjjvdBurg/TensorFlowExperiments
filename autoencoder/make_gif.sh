#!/bin/sh

IMAGE_DIR="./images"

INPUT="./images/input.jpg"
for f in `ls ${IMAGE_DIR}/output_*`;
do
	echo $f;
	num=$(echo $f | cut -d'_' -f2 | cut -d'.' -f1)
	convert ${INPUT} $f +append ${IMAGE_DIR}/combined_${num}.jpg

	convert ${IMAGE_DIR}/combined_${num}.jpg \
		-gravity South \
		-background black \
		-fill white \
		-font Dejavu-Sans \
		-splice 0x20 \
		-annotate +0+2 "iteration: ${num}" \
		${IMAGE_DIR}/labeled_${num}.jpg
	rm -f ${IMAGE_DIR}/combined_${num}.jpg
done

convert -layers OptimizePlus -delay 1x100 ${IMAGE_DIR}/labeled_*.jpg -loop 0 \
	combined.gif

rm -f ${IMAGE_DIR}/labeled_*.jpg
