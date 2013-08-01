mongoose = require('mongoose')
Schema = mongoose.Schema

boardSchema = new Schema(
  factors: [
    masu: Number
    koma: Number
    sengo: Number
  ]
)

boardSchema.methods.testMethod = ->
  'abc'

module.exports = mongoose.model('Board', boardSchema)
