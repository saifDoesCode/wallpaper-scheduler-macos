# 🌅 Auto Wallpaper Scheduler for macOS

Automatically switch between light and dark wallpapers based on time of day on macOS. Perfect for matching your workflow with natural light cycles.

## Features

- ⏰ Schedule wallpaper changes at specific times
- 🖥️ Works across all connected displays (MacBook + external monitors)
- 🎨 Support for any image format macOS supports
- 🔄 Runs automatically in the background
- 🪶 Lightweight and simple - just a bash script and cron

## Quick Start

### 1. Clone or Download

```bash
git clone https://github.com/yourusername/wallpaper-scheduler-macos.git
cd wallpaper-scheduler-macos
```

Or download the `set_wallpaper.sh` script directly.

### 2. Make the Script Executable

```bash
chmod +x set_wallpaper.sh
```

### 3. Move to a Permanent Location

```bash
mkdir -p ~/scripts
cp set_wallpaper.sh ~/scripts/
```

### 4. Grant Permissions (macOS Ventura and later)

**Important:** macOS requires Full Disk Access for cron to modify system settings.

1. Open **System Settings** → **Privacy & Security** → **Full Disk Access**
2. Click the **+** button
3. Press **Cmd+Shift+G** and enter: `/usr/sbin/cron`
4. Click **Open** to add it
5. Toggle the switch to enable it

### 5. Set Up Your Schedule

Edit your crontab:

```bash
crontab -e
```

Add your wallpaper schedule (example below for 6 AM light, 5 PM dark):

```cron
0 6 * * * ~/scripts/set_wallpaper.sh "/path/to/your/light-wallpaper.jpg"
0 17 * * * ~/scripts/set_wallpaper.sh "/path/to/your/dark-wallpaper.jpg"
```

**Replace** `/path/to/your/` with your actual wallpaper paths!

Save and exit (in vim: press `Esc`, then type `:wq` and press Enter).

### 6. Verify

Check that your crontab is set:

```bash
crontab -l
```

## Usage

### Manual Testing

Test the script manually before setting up automation:

```bash
~/scripts/set_wallpaper.sh "/path/to/wallpaper.jpg"
```

If it works, you'll see: `Wallpaper set to: /path/to/wallpaper.jpg`

### Cron Schedule Examples

The format is: `minute hour day month weekday command`

```cron
# Light wallpaper at 7 AM, dark at 6 PM
0 7 * * * ~/scripts/set_wallpaper.sh "/path/to/light.jpg"
0 18 * * * ~/scripts/set_wallpaper.sh "/path/to/dark.jpg"

# Light at sunrise (6:30 AM), dark at sunset (8:30 PM)
30 6 * * * ~/scripts/set_wallpaper.sh "/path/to/light.jpg"
30 20 * * * ~/scripts/set_wallpaper.sh "/path/to/dark.jpg"

# Change every 4 hours
0 */4 * * * ~/scripts/set_wallpaper.sh "/path/to/wallpaper.jpg"
```

Need help with cron syntax? Check out [crontab.guru](https://crontab.guru/)

## Troubleshooting

### Wallpaper not changing?

**Check permissions:**
- Verify cron has Full Disk Access in System Settings
- Make sure the script is executable: `ls -l ~/scripts/set_wallpaper.sh` should show `-rwxr-xr-x`

**Check your paths:**
- Use absolute paths in crontab (paths starting with `/` or `~`)
- Verify wallpaper files exist: `ls -l /path/to/wallpaper.jpg`

**Test the script:**
```bash
~/scripts/set_wallpaper.sh "/path/to/wallpaper.jpg"
```

**Check cron logs:**
```bash
log show --predicate 'process == "cron"' --last 1h --info
```

### Common Issues

**"Permission denied"**
- Run: `chmod +x ~/scripts/set_wallpaper.sh`

**Wallpaper not applying to all screens**
- The script uses AppleScript to target all desktops. If one screen isn't updating, try disconnecting and reconnecting it.

**Changes not happening when asleep**
- Cron jobs run when the scheduled time arrives. If your Mac is asleep, the job will run when it wakes up (some delay is normal).

### Still having issues?

Open an issue on GitHub with:
- Your macOS version
- The output of `crontab -l`
- Any error messages from testing the script manually
