User = require '../coffee_files/user.coffee'
factory = require './factories.coffee'
require '../coffee_files/global.coffee'

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
      expect(@errors).to.be.null
    it 'should be instanceof User', ->
      expect(@user).to.be.instanceof User

  it 'should respond to addToOptionsKeys', ->
    expect(User).to.have.property 'addToOptionsKeys'
  context '#addToOptionsKeys()', ->
    context 'when empty object', ->
      it 'should return object with proper keys', ->
        expect(User.addToOptionsKeys({})).to.have.keys ['name', 'surname', 'address','password','email']
    context 'when some value false',->
      it 'should remain name eq false', ->
        expect(User.addToOptionsKeys({name: false}).name).to.be.eql false
      it 'should remain surname eq false', ->
        expect(User.addToOptionsKeys({surname: false}).surname).to.be.eql false
    context 'when some is not provided',->
      it 'should add non-provided key', ->
        expect(User.addToOptionsKeys({name: 1}).surname).to.be.null

  context '#constructor()', ->
    context 'when without arguments', ->
      before ->
        @user = new User()
      it 'should set name to null', ->
        expect(@user.name).to.be.null
      it 'should set surname to null', ->
        expect(@user.surname).to.be.null
      it 'should set address to null', ->
        expect(@user.address).to.be.null
      it 'should set email to null', ->
        expect(@user.email).to.be.null
      it 'should set password to null', ->
        expect(@user.password).to.be.null
    it 'should respond to validate', ->
      expect(new User).respondTo 'validate'
    context.skip '#validate()', ->
      beforeEach ->
        @user = factory.buildSync 'user'
      context 'when wrong options provided', ->
        context 'when one of attribute is not provide', ->
          context 'when name', ->
            before ->
#              delete @userAttributes.name
            it 'should return false', ->
              expect(@user.validate()).to.be.false
            it 'should set isValid to false', ->
              @user.validate()
              expect(@user.isValid).to.be.false




