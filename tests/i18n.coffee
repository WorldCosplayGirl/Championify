should = require('chai').should()
expect = require('chai').expect

async = require 'async'
glob = require 'glob'
path = require 'path'
_ = require 'lodash'

_source = null
keys_count = null
locales = {}

describe 'i18n', ->
  before ->
    _source = require '../i18n/_source.json'
    keys_count = _.keys(_source).length

    locales_files = glob.sync './i18n/*.json'
    locales_files.shift()

    _.each locales_files, (locale_path) ->
      locale = path.basename(locale_path).replace('.json', '')
      locales[locale] = require path.join('..', locale_path)


  describe 'each locale', ->
    it 'should have the same length of keys as _source', (done) ->
      _.each _.keys(locales), (locale) ->
        _.keys(locales[locale]).length.should.equal(keys_count)
      done()

    it 'should contain the same keys as _source', (done) ->
      _.each _.keys(_source), (key) ->
        _.each _.keys(locales), (locale) ->
          expect(locales[locale][key]).to.exist

      done()