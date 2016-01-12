factoryGirl = require 'factory-girl'
faker = require 'faker'

getFakeAddress = ->
  address = "#{faker.address.country()}"
  address.concat ", #{faker.address.streetAddress()}"
  address.concat ", #{faker.address.zipCode()}"

factoryGirl.define 'user', User,
  name: faker.name.findName(),
  email: faker.internet.email(),
  username: faker.internet.userName(),
  password: faker.internet.password(),
  address: getFakeAddress()


module.exports = factoryGirl


