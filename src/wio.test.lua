local function testFormatters(name, Reader)
    describe(name, function()
        describe('bytes(n)', function()
            it('should return data if enough data', function()
                local reader = Reader('test/wio/bytes.bin')
                assert.are.equals(reader:bytes(4), 'MARC')
            end)

            it('should return data if just enough data', function()
                local reader = Reader('test/wio/bytes.bin')
                assert.are.equals(reader:bytes(7), 'MARCELO')
            end)
            
            it('should return nil if not enough data', function()
                local reader = Reader('test/wio/bytes.bin')
                assert.is_nil(reader:bytes(50))
            end)
        end)
        
        describe('string()', function()
            it('should return data up to terminator', function()
                local reader = Reader('test/wio/string.bin')
                assert.are.equals(reader:string(), 'MARCELO HOSSOMI')
            end)
            
            it('should return nil if no terminator', function()
                local reader = Reader('test/wio/bytes.bin')
                assert.is_nil(reader:string())
            end)
        end)

        describe('int()', function()
            it('should read little endian', function()
                local reader = Reader('test/wio/integer.bin')
                assert.are.equals(reader:int(), 1)
            end)

            it('should return nil if no more data', function()
                local reader = Reader('test/wio/empty.bin')
                assert.are.is_nil(reader:int())
            end)
        end)

        describe('short()', function()
            it('should read little endian', function()
                local reader = Reader('test/wio/short.bin')
                assert.are.equals(reader:short(), 1)
            end)

            it('should return nil if no more data', function()
                local reader = Reader('test/wio/empty.bin')
                assert.are.is_nil(reader:short())
            end)
        end)

        describe('real()', function()
            it('should read little endian', function()
                local reader = Reader('test/wio/real.bin')
                assert.is_true(math.abs(reader:real() - 1.23) < 1E-5)
            end)

            it('should read nil if no more data', function()
                local reader = Reader('test/wio/empty.bin')
                assert.are.is_nil(reader:real())
            end)
        end)
    end)
end

describe('WIO', function()
    local wio = require 'wio'
    local util = require 'util'

    testFormatters('StringReader', function(path)
        local file = assert(io.open(path, 'rb'))
        return wio.StringReader(file:read('*all'))
    end)

    testFormatters('FileReader', function(path)
        local file = assert(io.open(path, 'rb'))
        return wio.FileReader(file)
    end)
end)
