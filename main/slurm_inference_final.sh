#!/usr/bin/env bash
set -x

PARTITION=Zoetrope

INPUT_PATH=$1
#echo $INPUT_VIDEO
FORMAT=$2
FPS=$3
CKPT=$4

GPUS=1
JOB_NAME=inference_${INPUT_VIDEO}

GPUS_PER_NODE=$((${GPUS}<8?${GPUS}:8))
CPUS_PER_TASK=4 # ${CPUS_PER_TASK:-2}
SRUN_ARGS=${SRUN_ARGS:-""}

#parent_dir=$(dirname -- "$INPUT_VIDEO1")
#base_parent  = $(basename -- "$parent_dir")
# mkdir ../demo/ASL/images
# mkdir ../demo/ASL/results
#mkdir ../demo/ASL/images/$($base_parent)
#mkdir ../demo/ASL/results/$($base_parent)

IMG_PATH=/scratch/aparna/demo/ASL/images
SAVE_DIR=/scratch/aparna/demo/ASL/results

# video to images
#mkdir $IMG_PATH
#mkdir $SAVE_DIR
#ffmpeg -i ${INPUT_VIDEO1} -f image2 -vf fps=${FPS}/1 -qscale 0 ../demo/ASL/images/$($base_parent)/${INPUT_VIDEO}/%06d.jpg 

# end_count=$(find "$IMG_PATH" -type f | wc -l)
# echo $end_count

# # inference
# #PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
# #srun -p ${PARTITION} \
# #    --job-name=${JOB_NAME} \
# #    --gres=gpu:${GPUS_PER_NODE} \
# #    --ntasks=${GPUS} \
# #    --ntasks-per-node=${GPUS_PER_NODE} \
# #    --cpus-per-task=${CPUS_PER_TASK} \
# #    --kill-on-bad-exit=1 \
# #    ${SRUN_ARGS} \
python inference_copy.py \
    --num_gpus ${GPUS_PER_NODE} \
    --exp_name output/demo_${JOB_NAME} \
    --pretrained_model ${CKPT} \
    --agora_benchmark agora_model \
    --img_path ${IMG_PATH} \
    --start 1 \
    --output_folder ${SAVE_DIR} \
    --show_verts \
    --show_bbox \
    --datasetname ASL \
    --path $INPUT_PATH
    
    # --save_mesh \
    # --multi_person \
    # --iou_thr 0.2 \
    # --bbox_thr 20


# images to video
#ffmpeg -y -f image2 -r ${FPS} -i ${SAVE_DIR}/img/%06d.jpg -vcodec mjpeg -qscale 0 -pix_fmt yuv420p ../demo/ASL_results/$($base_parent)/${INPUT_VIDEO}.mp4
