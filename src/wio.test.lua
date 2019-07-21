describe('WIO:', function()
    local wio = require 'wio'
    local util = require 'util'

    local function readHex(hex)
        return wio.read(util.hexToBin(hex))
    end

    describe('bytes(n):', function()
        it('should read', function()
            local reader = readHex('4D415243454C4F')
            assert.are.equals(reader:bytes(4), 'MARC')
            assert.are.equals(reader.cursor, 5)
        end)
        
        it('should cap to data length', function()
            local reader = readHex('4D415243454C4F')
            assert.are.equals(reader:bytes(10), 'MARCELO')
            assert.are.equals(reader.cursor, 8)
        end)

        it('should read empty if no more data', function()
            local reader = readHex('')
            assert.are.equals(reader:bytes(22), '')
            assert.are.equals(reader.cursor, 1)
        end)
    end)
    
    describe('string():', function()
        it('should read until null', function()
            local reader = readHex('4D415243454C4F20484F53534F4D4900')
            assert.are.equals(reader:string(), 'MARCELO HOSSOMI')
            assert.are.equals(reader.cursor, 17)
        end)
        
        it('should read until end if no null', function()
            local reader = readHex('4D415243454C4F20484F53534F4D49')
            assert.are.equals(reader:string(), 'MARCELO HOSSOMI')
            assert.are.equals(reader.cursor, 16)
        end)

        it('should read empty if no more data', function()
            local reader = readHex('')
            assert.are.equals(reader:string(), '')
            assert.are.equals(reader.cursor, 1)
        end)
    end)

    describe('int():', function()
        it('should read little endian', function()
            local reader = readHex('01000000')
            assert.are.equals(reader:int(), 1)
            assert.are.equals(reader.cursor, 5)
        end)

        it('should read nil if no more data', function()
            local reader = readHex('')
            assert.are.is_nil(reader:int())
        end)
    end)

    describe('short():', function()
        it('should read little endian', function()
            local reader = readHex('0100')
            assert.are.equals(reader:short(), 1)
            assert.are.equals(reader.cursor, 3)
        end)

        it('should read nil if no more data', function()
            local reader = readHex('')
            assert.are.is_nil(reader:short())
        end)
    end)

    describe('real():', function()
        it('should read little endian', function()
            local reader = readHex('A4709D3F')
            assert.is_true(math.abs(reader:real() - 1.23) < 1E-5)
            assert.are.equals(reader.cursor, 5)
        end)

        it('should read nil if no more data', function()
            local reader = readHex('')
            assert.are.is_nil(reader:real())
        end)
    end)
end)
