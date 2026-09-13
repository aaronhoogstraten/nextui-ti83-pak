#!/bin/sh

EMU_EXE=numero
###############################

EMU_TAG=$(basename "$(dirname "$0")" .pak)
PAK_DIR="$(dirname "$0")"
ROM="$1"

mkdir -p "$BIOS_PATH/$EMU_TAG"
mkdir -p "$SAVES_PATH/$EMU_TAG"
mkdir -p "$CHEATS_PATH/$EMU_TAG"

HOME="$USERDATA_PATH"
cd "$HOME"

minarch.elf "$PAK_DIR/${EMU_EXE}_libretro.so" "$ROM" &> "$LOGS_PATH/$EMU_TAG.log"
