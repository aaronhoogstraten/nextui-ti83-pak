# NextUI Numero Pak (TI-83)

A [Numero](https://github.com/nbarkhina/numero) [Libretro](https://www.libretro.com/) core pak for [NextUI](https://nextui.loveretro.games/) to emulate the TI-83 family of graphing calculators.

Numero is based on the [Wabbitemu](https://github.com/sputt/wabbitemu) emulator and allows you to play TI-83 games with a gamepad, virtual mouse, or keyboard.

## Installation

1. Download `TI83.pak.zip` from the [latest release](../../releases).
2. Extract the zip onto your SD card in the `/Emus/tg5040` directory. You should see a new `TI83.pak` directory after extracting.
3. Create the `/Roms/TI-83 Calculator (TI83)` directory on your SD card for your programs and games.

## BIOS Setup

**A BIOS file is required.** Place your TI-83 BIOS ROM in the `/Bios/TI83/` directory on your SD card.

- `ti83se.rom` is recommended for the largest storage capacity
- Other supported BIOS files: `ti83p.rom`, `ti83.rom`

## Supported File Types

Place these files in your `/Roms/TI-83 Calculator (TI83)/` directory:

- `.8xp` — TI-83+ programs
- `.8xg` — TI-83+ group files (app loaders like Ion, Mirage)
- `.rom` — Calculator ROM images (can also be used to launch specific states)

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

## Usage Tips

- The emulator auto-saves progress every 10 seconds — all calculator state is preserved in RAM
- You can run the core without any content to use it as a plain calculator
- **Installing apps**: Load app loaders (like `Ion.8xg`) first, then load games one at a time — each file gets installed on top of the existing calculator state
- **Save states**: Use different save state slots to preserve different calculator configurations
- **Restart warning**: Restarting the core will clear all calculator memory — use this only as a last resort if the emulator hangs
- If apps won't install, try moving things between Memory and Archive in the calculator's memory management

## Debug Logs

If you're having trouble launching games, check the debug logs at `/.userdata/tg5040/logs/TI83.log`.

## Building from Source

The GitHub Actions workflow automatically cross-compiles the Numero libretro core for aarch64 and packages the pak. To trigger a build:

1. Push a tag: `git tag 0.1.0 && git push --tags`
2. The workflow will compile the core, package `TI83.pak.zip`, and create a GitHub release

### Manual Build

```bash
# Install cross-compiler
sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Clone and build
git clone https://github.com/nbarkhina/numero.git
cd numero
make -f Makefile.libretro \
  CC=aarch64-linux-gnu-gcc \
  CXX=aarch64-linux-gnu-g++ \
  AR=aarch64-linux-gnu-ar \
  platform=unix -j$(nproc)

# Package
mkdir -p TI83.pak
cp numero_libretro.so TI83.pak/
# Copy launch.sh and default.cfg into TI83.pak/
aarch64-linux-gnu-strip TI83.pak/numero_libretro.so
zip -r TI83.pak.zip TI83.pak/
```

## Credits

- [Numero](https://github.com/nbarkhina/numero) by nbarkhina — TI-83 Libretro core
- [Wabbitemu](https://github.com/sputt/wabbitemu) — The original TI calculator emulator
- [NextUI TIC-80 Pak](https://github.com/amayer5125/nextui-tic-80-pak) by amayer5125 — Reference pak structure

## License

See the [Numero repository](https://github.com/nbarkhina/numero) for licensing details on the emulator core.
