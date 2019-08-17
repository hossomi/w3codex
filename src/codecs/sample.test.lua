local codecs = {properties = 'war3map.w3i'}

local samples = {
  'test/maps/sample-1.w3x', 'test/maps/sample-2.w3x', 'test/maps/sample-3.w3x',
  'test/maps/sample-4.w3x'
}

describe('Codecs', function()

  after_each(function()
    os.remove('out/sample.bin')
  end)

  for codec, file in pairs(codecs) do

    describe(codec, function()

      for i, sample in ipairs(samples) do
        local codec = require('src.codecs.' .. codec)
        local file = sample .. '/' .. file

        it(file, function()
          codec:encode(codec:decode(file), 'out/sample.bin')
          assert.are.equals(assert(io.open(file)):read('*all'),
              assert(io.open('out/sample.bin')):read('*all'))
        end)
      end
    end)
  end
end)
