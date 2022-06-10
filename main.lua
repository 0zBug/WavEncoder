
local function Endian(n, len)
	local n, bytes = math.max(math.floor(n), 0), {}

	for i = 1, len do
		bytes[i] = n % 256
		n = math.floor(n / 256)
	end

	return string.char(unpack(bytes))
end

return function(Samples, Channels, Rate, Bits)
	local Wave = "RIFF????WAVEfmt "
	
	local Header = {
		16, 4, 1, 2, Channels, 2, Rate, 4,
		Rate * Channels * (Bits / 8), 4,
		Channels * (Bits / 8), 2, Bits, 2
	}

	for i = 1, 14, 2 do
		Wave = Wave .. Endian(Header[i], Header[i + 1])
	end

	Wave = Wave .. "data????"

	for Chunk = 1, #Samples, 2048 do
		local Data = {}

		for Index = 1, 2048 do
			local Sample = Samples[Chunk + Index]
			
			if Sample then
				table.insert(Data, Endian(Sample < 0 and Sample + (256 ^ (Bits / 8)) or Sample, 4))
			end
		end

		Wave = Wave .. table.concat(Data)
	end

	local Size = #Wave

	Wave = Wave:sub(1, 4) .. Endian(Size - 8, 4) .. Wave:sub(9)
	Wave = Wave:sub(1, 40) .. Endian(Size - 44, 4) .. Wave:sub(45)

	return Wave
end
