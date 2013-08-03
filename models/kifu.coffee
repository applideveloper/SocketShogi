mongoose = require('mongoose')
Schema = mongoose.Schema

kifuTreeSchema = new Schema(
  initialBoard: {type: ObjectId, ref: 'Board', required: true}
  head: {type: ObjectId, ref: 'KifuNode'}
)

kifuNodeSchema = new Schema(
  sasite:
    masu:
      before: {type: Number, required: true}
      after: {type: Number, required: true}
    koma: {type: Number, required: true}
    sengo: {type: Number, required: true}
    nari: {type: Boolean}
    # いるか分からないけど一応変則ルールのために
    changeSengo: {type: Boolean}
  next: [{type: ObjectId, ref: 'KifuNode'}]
)

module.exports = mongoose.model('KifuTree', kifuSchema)
module.exports = mongoose.model('KifuNode', kifuSchema)
