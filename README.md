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
https://user-images.githubusercontent.com/77031032/173044581-d4e7e905-e69d-4c36-b5d3-a6ddeb45041b.mp4
