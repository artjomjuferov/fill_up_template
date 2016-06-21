global = require '../coffee_files/global.coffee'

undefinedToNull = global.undefinedToNull

describe "Objects monkey-patched with amountOfKeys", ->
  context 'create object with new Object()', ->
    it 'add this method to created object', ->
      expect(new Object()).to.respondTo 'amountOfKeys'
  context 'anonymous object', ->
    it 'add method to objects', ->
      expect({}).to.respondTo 'amountOfKeys'

#  It does not work because everything is inherited from Object
#  it 'should not add to Array method', ->
#    expect([]).not.to.respondTo 'amountOfKeys'
#  it 'should not add to number', ->
#    expect(1).not.to.respondTo 'amountOfKeys'
#  it 'should not add to string', ->
#    expect("").not.to.respondTo 'amountOfKeys'

  it 'should return 0 when empty object', ->
    expect({}.amountOfKeys()).to.be.eql 0
  it 'should return 1 when 1 set', ->
    expect({key: "value"}.amountOfKeys()).to.be.eql 1
  it 'should return 1 even when 1 set but undefined value', ->
    expect({key: undefined}.amountOfKeys()).to.be.eql 1
  it 'should return 1 even when 1 set but undefined value', ->
    expect({key: undefined}.amountOfKeys()).to.be.eql 1


describe '#undefinedToNull()', ->
  context 'when pass undefined', ->
    it 'should return null', ->
      expect(undefinedToNull(undefined)).to.be.null
  context 'when pass "undefined"', ->
    it 'should return null', ->
      expect(undefinedToNull("undefined")).to.be.null
  context 'when pass empty array', ->
    it 'should return empty array', ->
      expect(undefinedToNull([])).to.be.eql []
  context 'when pass array with undefined', ->
    it 'should return array with null', ->
      expect(undefinedToNull([undefined])[0]).to.be.eql null
  context 'when pass array with "undefined"', ->
    it 'should return array with null', ->
      expect(undefinedToNull(["undefined"])[0]).to.be.eql null
  context 'when pass false', ->
    it 'should return false', ->
      expect(undefinedToNull(false)).to.be.eql false
  context 'when pass {}', ->
    it 'should return {}', ->
      expect(undefinedToNull({})).to.be.eql {}
  context 'when pass {key: undefined}', ->
    it 'should return {key: null}', ->
      result = undefinedToNull({key: undefined}).key
      expect(result).to.be.eql null
  context 'when pass {key: "undefined"}', ->
    it 'should not return {key: null}', ->
      result = undefinedToNull({key: "undefined"}).key
      expect(result).to.be.eql null
