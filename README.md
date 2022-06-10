# WavEncoder
A module that can create wav audio files.
# Example
```lua
local Samples = {}

for i = 0, 256 * 2 do
	table.insert(Samples, (math.sin(i / 256 * math.pi * 2) + 1) * 32800)
end

writefile("wave.wav", EncodeWav(Samples, 1, 256, 16))
```
# Output
https://github.com/0zBug/WavEncoder/blob/main/wave.wav?raw=true
