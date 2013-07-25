mongoose = require('mongoose')
Schema = mongoose.Schema

boardSchema = new Schema(
  factors: [
    masu: Number
    koma: Number
    sengo: Number
  ]
)

module.exports = mongoose.model('boards', boardSchema)
