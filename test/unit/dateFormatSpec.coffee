date = (elems) ->
  res = new Date()
  res.setMilliseconds(0)
  res.setSeconds(elems.seconds || 0)
  res.setMinutes(elems.minutes || 0)
  res.setHours(elems.hours || 0)
  res.setDate(elems.day) if elems.day?
  res.setMonth(elems.month - 1) if elems.month?
  res.setFullYear(elems.year) if elems.year?
  res

describe 'fsDateFormat', ->
  require '../../src/coffee/dateFormat'

  $scope = null
  $compile = null
  input = null

  beforeEach angular.mock.module('formstamp')

  beforeEach inject ($rootScope, $compile) ->
    $scope = $rootScope.$new()

    compile = (elem) -> $compile(elem)($scope)
    input = compile('<input type="text" fs-date-format ng-model="value" />')
    $scope.$apply()

  it "test", inject ($rootScope, $compile)->
    $scope.value = date(day: 1, month: 1, year: 2012)
    $scope.$apply()
    expect(input.val()).toEqual '1/1/12'

  it 'should parse date', ->
    input.val('2/2/12').triggerHandler('input')
    expect($scope.value).toEqual date(day: 2, month: 2, year: 2012)

  it 'should set model to null if view is empty', ->
    expect($scope.value).toBe undefined
    input.val('').triggerHandler('input')
    expect($scope.value).toBe null

  it 'should set value to null if input is invalid', ->
    input.val('invalid date').triggerHandler('input')
    expect($scope.value).toBe null

    input.val('21/40/2033').triggerHandler('input')
    expect($scope.value).toBe null
