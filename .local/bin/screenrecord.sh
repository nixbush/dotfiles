#!/bin/bash
# ------------------------------
# Flag functions
# ------------------------------
usage() {
   echo "Usage: ./screenshot.sh [flags]"
   echo "Flags:"
   echo "  -h       Print this help message"
   echo "  -s       Select a part of the screen to capture"
   echo "  -a       Record with screen audio"
   echo "  -A       Record all audio (from computer to the world)"
   echo "  -o       Optimize recording (use damage)"
   echo "  -k       Stop recording"
   echo "  -f=...   Filename to save to"
}

# ------------------------------
# Handle flags
# ------------------------------
DIRECTORY="$HOME/Videos/Screenrecord"

DATE=$(date +%d-%m-%Y)
TIME=$(date +%H-%M-%S)

FILENAME="$DIRECTORY/screenrecord_$DATE-$TIME.mp4"

CODEC="h264_vaapi"
DEVICE="/dev/dri/renderD128"

SELECT_AREA=false
RECORD_AUDIO=false
RECORD_AUDIO_ALL=false
OPTIMIZE_RECORD=false
STOP_RECORDING=false

while getopts "hsaAokf:" opt; do
   case "$opt" in
      h)
         usage
         exit 0
         ;;
      s)
         SELECT_AREA=true
         ;;
      a)
         RECORD_AUDIO=true
         ;;
      A)
         RECORD_AUDIO_ALL=true
         ;;
      o)
         OPTIMIZE_RECORD=true
         ;;
      k)
         STOP_RECORDING=true
         ;;
      f)
         FILENAME="$OPTARG"
         ;;
      \?) 
         usage
         exit 1
         ;;
   esac
done

# ------------------------------
# Handle flags
# ------------------------------
WF_RECORDER_FLAGS=()

if $SELECT_AREA; then
   WF_RECORDER_FLAGS+=("-g $(slurp)")
fi

if $RECORD_AUDIO; then
   WF_RECORDER_FLAGS+=("-aalsa_output.pci-0000_00_0e.0.9.analog-stereo.monitor")
fi

if $RECORD_AUDIO_ALL; then
   WF_RECORDER_FLAGS+=("-aalsa_output.pci-0000_00_0e.0.9.analog-stereo")
fi

if $OPTIMIZE_RECORD; then
   WF_RECORDER_FLAGS+=("--no-damage")
fi

if $STOP_RECORDING; then
   killall -s SIGINT wf-recorder
   notify-send -u low -t 5000 "Screen Recording" "Stopped currently active screen recording!"
   exit 0
fi

notify-send -u low -t 5000 "Screen Recording" "Currently started screen recording!"
wf-recorder -f "$FILENAME" -c "$CODEC" -d "$DEVICE" ${WF_RECORDER_FLAGS[@]} > /tmp/record.log
