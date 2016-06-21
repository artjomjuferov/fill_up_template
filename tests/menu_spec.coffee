Menu = require '../coffee_files/menu.coffee'

describe "Menu", ->
  it "is a singleton", ->
    expect(Menu.get()).to.be.instanceOf Menu
  it "is singleton", ->
    a = Menu.get()
    b = Menu.get()
    expect(a).to.be.eql b

