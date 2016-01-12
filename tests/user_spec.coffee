User = require '../coffee_files/user.coffee'
factory = require './factories.coffee'


describe 'User', ->
  it "has property name", ->
    expect(new User()).to.have.property 'name'
  it "has property surname", ->
    expect(new User).to.have.property 'surname'
  it "has property email", ->
    expect(new User).to.have.property 'email'
  it "has property address", ->
    expect(new User).to.have.property 'address'
  it "has property password", ->
    expect(new User).to.have.property 'password'
  it "has method validate", ->
    expect(new User).respondTo 'validate'
  it "has attribute isValid", ->
    expect(new User).to.have.property 'isValid'
  it "has method updateInfo", ->
    expect(new User).respondTo 'updateInfo'

  context '#creatingUserFactory',->
    before ->
      self = @
      factory.build 'user', (err, userFactory) ->
        self.user = userFactory
        self.errors = err

    it 'should not be created with error', ->
      expect(@errors).to.be.undefined
    it 'should be instanceof User', ->
      except(@user).to.be.instanceof User

  context.skip '#constructor()', ->
    context 'when wrong options provided', ->
      @rightAttributes



