local lcs = require 'src.blockdiff.lcs'

describe('LCS', function()

  it('excludes deletion', function()
    assert.are.equal(lcs('0123456789', '01236789', 1), '01236789')
  end)

  it('excludes deletion at start', function()
    assert.are.equal(lcs('0123456789', '23456789', 1), '23456789')
  end)

  it('excludes deletion at end', function()
    assert.are.equal(lcs('0123456789', '01234567', 1), '01234567')
  end)

  it('excludes addition', function()
    assert.are.equal(lcs('0123456789', '012345ab6789', 1), '0123456789')
  end)

  it('excludes addition at end', function()
    assert.are.equal(lcs('0123456789', '0123456789ab', 1), '0123456789')
  end)

  it('excludes addition at start', function()
    assert.are.equal(lcs('0123456789', 'ab0123456789', 1), '0123456789')
  end)

  it('excludes deletion and addition', function()
    assert.are.equal(lcs('0123456789', '0123ab6789', 1), '01236789')
  end)

  it('no changes if same input', function()
    assert.are.equal(lcs('0123456789', '0123456789', 1), '0123456789')
  end)

  it('excludes whole deleted block', function()
    assert.are.equal(lcs('aaaabbbbcccc', 'aaaabbbBcccc', 4), 'aaaacccc')
  end)

  it('excludes whole added block', function()
    assert.are.equal(lcs('aaaabbbbcccc', 'aaaabbbbDDDDcccc', 4), 'aaaabbbbcccc')
  end)

  it('works with different lengths', function()
    assert.are.equal(lcs('aaabbbccc', 'aaaabbbbccccdddd', 1), 'aaabbbccc')
  end)

  it('test long string for fun', function()
    assert.are.equal(lcs(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin et vulputate massa. Nam congue, neque id interdum semper, arcu massa sodales nisl, sit amet iaculis nulla risus vel sapien. Curabitur tristique malesuada mauris in mattis. Duis lobortis rutrum ligula id euismod. Maecenas bibendum, nunc non tristique feugiat, nisl velit fringilla velit, pretium elementum nibh tellus nec quam. Curabitur cursus tempus sodales. Aliquam erat volutpat. Duis dignissim eu justo ac dictum. Integer massa nunc.',
        'Donec tincidunt, tortor sit amet elementum tristique, orci tellus mollis ipsum, a consectetur nisl nisl eu diam. Vivamus condimentum non orci id cursus. Sed venenatis tristique neque quis sollicitudin. Donec dictum vel ex quis pretium. Sed porttitor molestie purus, vitae vulputate mauris luctus at. Donec iaculis aliquet tellus. Sed sit amet massa id arcu aliquam accumsan vitae tristique cras amet.', 1),
        'oe iu oor sit amet eeturisie ri elu mss a coneeu i ieu m aus ode ni i cursus veenai tristique eu uis iti. D itum l  uis eium  otrstie u, vita vlt ri ltu t nec u ait teus ds amet a id u u accum teerasa.')
  end)
end)
