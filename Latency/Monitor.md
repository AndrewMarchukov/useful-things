Optimal FPS caps are about frame time buffers. The higher the refresh rate, the tighter the frame time window, so a larger gap between FPS cap and refresh rate provides more buffer to prevent latency or tearing. You need a ~0.3ms frame time buffer difference between max FPS and refresh rate.

Frame times relative to FPS change exponentially. Say, the difference between 116 FPS and 120Hz is 0.28ms, while the difference between 236 FPS and 240Hz is 0.07ms. So it's 4 times easier to miss the frame time VRR window! What matters in keeping VRR engaged at all times is not FPS, but frame times, so each single frame manages to get into the time window.

The old “3 or 4 under your refresh rate” FPS cap from Blur Busters is outdated and incorrect. There is a formula used by Special K to find out your cap and it’s often the same cap (or close to the same) you get by enabling Nvidia Reflex in supported games with Gsync and driver Vsync on.

The FPS Cap formula is:

    Refresh - (Refresh x Refresh / 3600) = FPS Cap

So for my 240Hz monitor it would look like this:

    240 - (240 x 240 / 3600) = 224 FPS Cap (the same one reflex gives)

This gives me the desired ~0.3ms frame time buffer. You can verify this with the following simple math as well.

    1000 ÷ 240Hz = 4.167ms

    1000 ÷ 224 FPS = 4.464ms

    4.464 - 4.167 = 0.297ms frame time buffer

As you can see, the FPS Cap formula gives you the correct max global FPS cap for your given monitor refresh rate that aligns with the same caps enforced when using Nvidia Relfex or Ultra Low Latency Mode in the Control Panel. Nvidia’s technology knows to give a ~0.3ms frame time buffer so that you do not overshoot the refresh cycle, which would result in added latency. That formula gives the following FPS caps for their respective refresh rates:

    480Hz -> 416 FPS

    360Hz -> 324 FPS

    240Hz -> 224 FPS

    180Hz -> 171 FPS

    165Hz -> 157 FPS

    144Hz -> 138 FPS

    120Hz -> 116 FPS

You should be using a cap like this with Gsync on even in eSports titles like CS and Valorant! Using these caps in addition to Gsync + driver Vsync will result in latency that is within 1ms of uncapping your FPS with Reflex on. Techless on YT proved that with Gsync set up properly, a FPS cap on a 240Hz monitor has only 0.6ms more latency than an uncapped FPS, with Reflex on, hitting 500+ FPS in Valorant or CS. It makes no sense to incur screen tearing and micro stutters (due to fluctuating FPS) by uncapping your FPS just to save 0.6ms of latency. The stuttering and tearing of uncapped FPS often leads to a higher perceived latency because of how un-smooth the experience is, leading to a harder time tracking enemies and landing precise shots.

And in games without Reflex, the Gsync + Vsync + FPS Cap setup actually reduces latency compared to uncapping the FPS and not using Gsync or Vsync.

One final piece to the puzzle is GPU usage. You don’t want to max your GPU usage as this can also lead to stutters. My goal is always to have my GPU maxing out at around 90% usage or less. So if a given game is hitting 99% usage at like 160 FPS, then I just cap at around 145 FPS or whatever I need to get that usage down to 90%. The global FPS cap is only relevant if you’re actually able to hit it comfortably without maxing your GPU usage.

TLDR; Use the following settings for zero screen tearing and reducing latency.

    Gsync - on in Nvidia Control Panel or Nvidia App (for fullscreen and windowed)

    Vsync - off in game but set to ‘On’ in Control Panel or Nvidia App

    Max Frame Rate - set a global cap based on your refresh rate (formula above)

    Reflex - always on in game when available


Here is the AMD version.

    Freesync - on in the Adrenalin App

    Vsync - off in game but turn it on in Adrenalin App (labeled as Wait for Vertical Refresh: put it to Always On)

    Radeon Chill - set a global cap based on your refresh rate (formula above) with Chill you set the "min" and "max" FPS to the same number

    Anti Lag 2 - always on in game when available
