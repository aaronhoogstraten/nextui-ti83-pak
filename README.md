# NextUI Numero Pak (TI-83)

A [Numero](https://github.com/nbarkhina/numero) [Libretro](https://www.libretro.com/) core pak for [NextUI](https://nextui.loveretro.games/) to emulate the TI-83 family of graphing calculators.

Numero is based on the [Wabbitemu](https://github.com/sputt/wabbitemu) emulator and lets you play TI-83 Plus games with a gamepad or a virtual mouse.

## Installation

1. Download `TI83.pak.zip` from the [latest release](../../releases).
2. Create a `TI83.pak` directory in `/Emus/tg5040` on your SD card and extract the zip into it. You should end up with `/Emus/tg5040/TI83.pak/launch.sh`.
3. Create the `/Roms/TI-83 Calculator (TI83)` directory on your SD card for your programs and games.

## BIOS Setup

**A BIOS file is required.** Place your TI-83 BIOS ROM in the `/Bios/TI83/` directory on your SD card. The core looks for these filenames, in this order:

- `ti83se.rom` — TI-83 Plus Silver Edition (recommended, largest storage capacity)
- `ti83plus.rom` — TI-83 Plus
- `ti83.rom` — original TI-83

`.8xp`, `.8xg` and `.8xk` files are TI-83 Plus formats, so use a TI-83 Plus or Silver Edition ROM to run them.

## Supported File Types

Place these files in your `/Roms/TI-83 Calculator (TI83)/` directory:

- `.8xp` — TI-83 Plus programs (TI-BASIC or assembly games)
- `.8xg` — TI-83 Plus group files (several variables bundled together)
- `.8xk` — TI-83 Plus Flash applications (e.g. MirageOS)

## Loading and Running Programs

The calculator works like a real one: launching a file from NextUI **sends that file into the calculator's memory**, on top of everything already installed. Programs stay installed across sessions, so each file only needs to be launched once.

### How the calculator state is saved

- The full calculator state is saved automatically every 10 seconds and when you exit, to `/Saves/TI83/tisavestateprogressti83se.sav` (the filename matches your BIOS).
- Launching any file first restores that saved state, then imports the file. You always return to exactly where you left off, even in the middle of a game.

### Importing files

- **Programs and groups (`.8xp`, `.8xg`) only import when the calculator is on the home screen.** They are sent over an emulated link cable, and the calculator ignores the transfer while a program or app like MirageOS is running. The import then fails silently and can leave the calculator frozen.
- **Flash applications (`.8xk`)** are written directly to memory and install regardless of what the calculator is doing.
- If RAM is full, the core automatically puts the program in Archive instead.
- NextUI does not show the core's "Import Success" message. To confirm an import, press `PRGM` and check that the program is listed.

### Example: Block Dude with MirageOS

Many assembly games (anything written for Ion or MirageOS) need a shell to run. MirageOS is a shell that also runs Ion programs, so you don't need Ion as well.

1. Make sure the calculator was left on the home screen last time you exited (see [Quitting](#quitting)).
2. Launch `blckdude.8xp` from NextUI. Press `PRGM` to confirm `BLCKDUDE` is listed, then exit through the NextUI menu.
3. Launch `MIRAGEOS.8xk` from NextUI.
4. Press `APPS` and choose **MirageOS**. Block Dude is listed in MirageOS's Main folder. Select it and press `ENTER` to play.
5. Optionally switch to the **Gaming Buttons** control scheme for playing (see [Controls](#controls)).

To add more games later, get back to the home screen, exit, and launch the new `.8xp` from NextUI the same way. Import programs *before* opening MirageOS in that session.

Other kinds of programs:

- **TI-BASIC programs**: press `PRGM`, select the program and press `ENTER`.
- **Assembly programs with no shell**: open the catalog (`2ND` + `0`), choose `Asm(`, then press `PRGM`, pick the program and press `ENTER`.

### Quitting

Always get back to the calculator's home screen before exiting NextUI. Otherwise your next launch resumes inside the game and any file you launch will fail to import.

1. Quit the game using its own exit key. For example, Block Dude exits with `ENTER` (**Start**).
2. Exit MirageOS if it is open.
3. Press `2ND` then `MODE` (QUIT) to reach the home screen: a blank screen with a blinking cursor.
4. Exit through the NextUI menu.

### If the calculator freezes

If the calculator stops responding after an import, exit through the NextUI menu and delete `/Saves/TI83/tisavestateprogressti83se.sav`. **This erases all calculator memory**, so you will need to import your programs and apps again.

## Controls

Numero supports two control schemes. Switch between them in the in-game menu under **Options → Emulator → Control scheme**.

### Joypad (Default)
- **D-Pad / Left Stick** — Move virtual mouse cursor
- **A** — Press calculator button / Click
- **B** — 2ND
- **X / Y** — Up / Down
- **L / R** — Left / Right
- **Select** — ALPHA
- **Start** — ENTER
- **R2** — Virtual mouse click
- **L2** — Toggle between calculator view and "Big Mode"

### Gaming Buttons
More suited for playing games. The virtual mouse can still be moved with the left stick.
- **D-Pad** — Arrow keys
- **A** — 2ND
- **B** — ALPHA
- **X** — MODE
- **Y** — PRGM
- **Select** — CLEAR
- **Start** — ENTER
- **L / R** — X,T,θ,n / STAT
- **R2** — Virtual mouse click
- **L2** — Toggle between calculator view and "Big Mode"

Keys without a button (like `APPS`) have to be clicked with the virtual mouse. On a device without an analog stick, switch back to the Joypad scheme to reach them.

## Usage Tips

- **Save states**: The NextUI save state slots can hold different calculator configurations. Your most recent session is always restored on launch regardless.
- **Reset warning**: Resetting the game from the NextUI menu clears all calculator memory. Use this only as a last resort if the emulator hangs.
- If apps won't install, free up space in the calculator's memory management menu (`2ND` + `+`, then `Mem Mgmt/Del`).

## Debug Logs

If you're having trouble launching games, check the debug logs at `/.userdata/tg5040/logs/TI83.log`.

## Building from Source

The GitHub Actions workflow cross-compiles the Numero libretro core for aarch64, applies the patches in `patches/`, packages the pak and publishes a GitHub release. Run it from the repository's **Actions** tab (**Build Numero Pak → Run workflow**) with a version number, or with the GitHub CLI:

```bash
gh workflow run build.yml -f version=0.1.0
```

The workflow creates the `v<version>` tag and release itself.

### Manual Build

```bash
# Install cross-compiler
sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Clone the pinned Numero commit and apply this repository's patches
git clone https://github.com/nbarkhina/numero.git
cd numero
git checkout 867c40ad9cdfe5295e0be81e0a17b16964a4a33e
for p in /path/to/nextui-ti83-pak/patches/*.patch; do git apply "$p"; done

# Build (-fsigned-char is required: char is unsigned on aarch64, which breaks the Z80 core)
CFLAGS=-fsigned-char CXXFLAGS=-fsigned-char make -f Makefile.libretro \
  CC=aarch64-linux-gnu-gcc \
  CXX=aarch64-linux-gnu-g++ \
  AR=aarch64-linux-gnu-ar \
  platform=unix -j$(nproc)
aarch64-linux-gnu-strip numero_libretro.so

# Package (files at the root of the zip, matching the release)
cp /path/to/nextui-ti83-pak/launch.sh /path/to/nextui-ti83-pak/default.cfg .
zip TI83.pak.zip default.cfg launch.sh numero_libretro.so
```

## Credits

- [Numero](https://github.com/nbarkhina/numero) by nbarkhina — TI-83 Libretro core
- [Wabbitemu](https://github.com/sputt/wabbitemu) — The original TI calculator emulator
- [NextUI TIC-80 Pak](https://github.com/amayer5125/nextui-tic-80-pak) by amayer5125 — Reference pak structure

## License

The pak files in this repository are released under the MIT License (see `LICENSE`). See the [Numero repository](https://github.com/nbarkhina/numero) for licensing details on the emulator core.
